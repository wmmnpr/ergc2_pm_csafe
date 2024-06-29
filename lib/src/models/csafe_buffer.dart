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
  CSAFE_PM_LONG_PUSH_CFG_CMDS.CSAFE_PM_SET_SPLITDURATION.index:
      csafePmSetSplitduration
};

class CsafeBufferParser {
  static Map<int, Object> resp = {};

  static void init() {}

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

  static Map<String, Object> parseResponse(IntList inputList) {
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
        i = 2;
      default:
        throw Exception("no start byte");
    }
    for (int j = i; i < data.length; i++) {
      if (data[j] == CSAFE_FRAME_END_BYTE) break;

      j = COMMAND_ID_ACTION_MAP[data[j]]!(data, i, response);
    }

    return response;
  }
}
