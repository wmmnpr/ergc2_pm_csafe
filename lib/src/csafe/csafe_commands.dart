import 'dart:convert';

import '../../ergc2_pm_csafe.dart';
import 'csafe_constants.dart';

// @formatter:on

extension IntExtensions on int {
  String toHex() {
    return toRadixString(16).padLeft(2, '0');
  }
}

int handle(IntList data, start, Map<String, Object> result) {
  return start + 2;
}

int commandWrapper(IntList data, start, Map<String, Object> result) {
  return start;
}

int csafePmSetSplitduration(IntList data, start, Map<String, Object> result) {
  result["csafePmSetSplitdurationType"] =
      data[start + 1] == 0x00 ? "Time" : "Distance";
  result["csafePmSetSplitduration"] = DataConvUtils.getUint32(data, start + 2);
  return start + 5;
}

Map<int, int Function(IntList, int, Map<String, Object>)>
    COMMAND_ID_ACTION_MAP = {
  0x76: commandWrapper,
  0x7e: handle,
  CSAFE_PROPRIETARY_LONG_CMDS.CSAFE_PM_SET_SPLITDURATION.index:
      csafePmSetSplitduration
};

class CsafeBufferParser {
  static final Map<int, Object> _commandsParser = _initCommandParsers();
  static final Map<int, FrameContentProcessor> _responseParser =
      _initResponseParsers();

  static _initCommandParsers() {
    Map<int, Object> v = {};
    for (CSAFE_PUBLIC_SHORT_CMDS e in CSAFE_PUBLIC_SHORT_CMDS.values) {
      v.putIfAbsent(e.id, () => e);
    }
    return v;
  }

  static _initResponseParsers() {
    Map<int, FrameContentProcessor> v = {};
    for (CSAFE_PROP_SHORT_GET_CONF_CMDS e
        in CSAFE_PROP_SHORT_GET_CONF_CMDS.values) {
      v.putIfAbsent(e.id, () => FrameContentProcessor(e.id, e.fields));
    }

    for (CSAFE_PROP_LONG_GET_DATA_CMDS e
        in CSAFE_PROP_LONG_GET_DATA_CMDS.values) {
      v.putIfAbsent(e.id, () => FrameContentProcessor(e.id, e.fields));
    }

    return v;
  }

  static _addressText(int v) => v == 0x00 ? "Master" : "Slave";

  static _stateText(int v) => STATE_MACHINE_STATE[(v & 0x0F)];

  static _previousFrameStatus2text(int v) => PREVIOUS_FRAME_STATUS[(v & 0x30)];

  static IntList _unpack(IntList inputList) {
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
    IntList data = _unpack(inputList);
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
        i = 1;
      default:
        throw Exception("no start byte");
    }

    //parse frame contents
    CsafeParserContext context = CsafeParserContext();
    for (int j = i; j < data.length - 2; j++) {
      if (data[j] == CSAFE_FRAME_END_BYTE) break;
      //print("#$j:value=${data[j].toRadixString(16).padLeft(2, '0')}");
      int v = data[j];
      if (_responseParser.containsKey(v)) {
        j = _responseParser[v]!.process(context, data, j);
        print("hi");
      }
    }
    response.putIfAbsent("data", () => context.result);

    print(jsonEncode(response));
    return response;
  }
}
