import 'dart:convert';

import '../../ergc2_pm_csafe.dart';
import 'csafe_constants.dart';

extension IntExtensions on int {
  String toHex() {
    return toRadixString(16).padLeft(2, '0');
  }
}

class CsafeFrameProcessor {
  final Map<int, CsafeFrameContentBaseProcessor> _responseParser =
      _initResponseParsers();

  static _initResponseParsers() {
    Map<int, CsafeFrameContentBaseProcessor> v = {};

    for (CSAFE_PUBLIC_SHORT_CMDS e in CSAFE_PUBLIC_SHORT_CMDS.values) {
      v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
    }

    for (CSAFE_PROP_LONG_GET_DATA_CMDS e
        in CSAFE_PROP_LONG_GET_DATA_CMDS.values) {
      v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
    }

    for (CSAFE_PUBLIC_LONG_CMDS e in CSAFE_PUBLIC_LONG_CMDS.values) {
      if (e.id >= 0x76 && e.id <= 0x7F) {
        v.putIfAbsent(e.id, () => CsafeFrameWrapperProcessor(e.id));
      } else {
        v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
      }
    }
    return v;
  }

  static _addressText(int v) => v == 0x00 ? "Master" : "Slave";

  static _stateText(int v) => STATE_MACHINE_STATE[(v & 0x0F)];

  static _previousFrameStatus2text(int v) => PREVIOUS_FRAME_STATUS[(v & 0x30)];

  static IntList _unstuff(IntList inputList) {
    IntList data = [];
    for (int i = 0; i < inputList.length; i++) {
      if (inputList[i] == 0xF3) {
        data.add(inputList[i + 1] + 0xF0);
        i++;
      } else {
        data.add(inputList[i]);
      }
    }
    return data;
  }

  Map<String, Object> parseResponseFrame(IntList inputList) {
    IntList data = _unstuff(inputList);
    Map<String, Object> response = {};
    int i = 0;
    switch (data[0]) {
      case CSAFE_EXT_FRAME_START_BYTE:
        response["checksum"] =
            DataConvUtils.csafe_checksum(data, 3, data.length - 1);
        response["source"] = _addressText(data[++i]);
        response["target"] = _addressText(data[++i]);
        response["state"] = _stateText(data[++i])!;
        response["previousFrameStatus"] = _previousFrameStatus2text(data[i])!;
        i = 4;
      case CSAFE_FRAME_START_BYTE:
        response["checksum"] =
            DataConvUtils.csafe_checksum(data, 1, data.length - 1);
        response["state"] = _stateText(data[++i])!;
        i = 2;
      default:
        throw Exception("no start byte");
    }

    //parse frame contents
    CsafeFrameProcessorContext context = CsafeFrameProcessorContext();
    for (int j = i; j < data.length - 2; j++) {
      if (data[j] == CSAFE_FRAME_END_BYTE) break;
      //print("#$j:value=${data[j].toRadixString(16).padLeft(2, '0')}");
      int v = data[j];
      if (_responseParser.containsKey(v)) {
        j = _responseParser[v]!.process(context, data, j);
      }
    }
    response.putIfAbsent("data", () => context.result);

    print(jsonEncode(response));
    return response;
  }
}

class CsafeFrameProcessorContext {
  Map<String, Object> result = {};
}

abstract class CsafeFrameContentBaseProcessor {
  int cmd;

  CsafeFrameContentBaseProcessor(this.cmd);

  int process(CsafeFrameProcessorContext context, IntList data, int start);
}

class CsafeFrameWrapperProcessor extends CsafeFrameContentBaseProcessor {
  final Map<int, CsafeFrameContentBaseProcessor> _responseParser =
      _initResponseParsers();

  CsafeFrameWrapperProcessor(super.cmd);

  static _initResponseParsers() {
    Map<int, CsafeFrameContentProcessor> v = {};
    for (CSAFE_PROP_LONG_GET_DATA_CMDS e
        in CSAFE_PROP_LONG_GET_DATA_CMDS.values) {
      v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
    }

    for (CSAFE_PUBLIC_LONG_CMDS e in CSAFE_PUBLIC_LONG_CMDS.values) {
      v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
    }

    for (CSAFE_PROP_SHORT_GET_CONF_CMDS e
        in CSAFE_PROP_SHORT_GET_CONF_CMDS.values) {
      v.putIfAbsent(e.id, () => CsafeFrameContentProcessor(e.id, e.fields));
    }
    return v;
  }

  @override
  int process(CsafeFrameProcessorContext context, IntList data, int start) {
    int cmd = data[start];
    assert(cmd == this.cmd);
    int length = data[start + 1];
    int idx = start + 2;
    for (; idx < length; idx++) {
      int v = data[idx];
      if (_responseParser.containsKey(v)) {
        idx = _responseParser[v]!.process(context, data, idx);
      }
    }
    return idx;
  }
}

class CsafeFrameContentProcessor extends CsafeFrameContentBaseProcessor {
  Map<String, FrameFieldType>? fields;

  CsafeFrameContentProcessor(super.cmd, this.fields);

  @override
  int process(CsafeFrameProcessorContext context, IntList data, int start) {
    int cmd = data[start];
    assert(cmd == this.cmd);
    int length = data[start + 1];
    int pos = start + 2;
    this.fields!.forEach((key, value) {
      // @formatter:off
      switch(value){
        case FrameFieldType.CHAR:
          context.result.putIfAbsent(key, () => data[pos].toString());
          pos = pos + 1;
        case FrameFieldType.INT:
          context.result.putIfAbsent(key, () => data[pos]);
          pos = pos + 1;
        case FrameFieldType.INT2:
          context.result.putIfAbsent(key, () => (data[pos] << 8) + data[pos+1]);
          pos = pos + 2;
        case FrameFieldType.INT3:
          context.result.putIfAbsent(key, () => (data[pos] << 16) + (data[pos+1] << 8) + data[pos+2]);
          pos = pos + 3;
        case FrameFieldType.INT4:
          context.result.putIfAbsent(key, () => (data[pos] << 24) + (data[pos+1] << 16) + (data[pos+2] << 8) + data[pos+3]);
          pos = pos + 4;
        case FrameFieldType.VAR_BUFF:
          context.result.putIfAbsent(key, () => DataConvUtils.intSubArrayToHex(data, pos, length));
          pos = pos + length;
        default:
      }
      // @formatter:on
    });
    return pos;
  }
}
