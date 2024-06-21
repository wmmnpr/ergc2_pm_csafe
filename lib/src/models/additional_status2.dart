import 'package:ergc2_pm_csafe/src/models/pm_data.dart';

import 'data_conv_utils.dart';

enum AdditionalStatus2ByteFieldIndex {
  ELAPSED_TIME_LO,
  ELAPSED_TIME_MID,
  ELAPSED_TIME_HI,
  INTERVAL_COUNT,
  AVG_POWER_LO,
  AVG_POWER_HI,
  TOTAL_CALORIES_LO,
  TOTAL_CALORIES_HI,
  SPLIT_INTERVAL_AVG_PACE_LO,
  SPLIT_INTERVAL_AVG_PACE_HI,
  SPLIT_INTERVAL_AVG_POWER_LO,
  SPLIT_INTERVAL_AVG_POWER_HI,
  SPLIT_INTERVAL_AVG_CALORIES_LO,
  SPLIT_INTERVAL_AVG_CALORIES_HI,
  LAST_SPLIT_TIME_LO,
  LAST_SPLIT_TIME_MID,
  LAST_SPLIT_TIME_HI,
  LAST_SPLIT_DISTANCE_LO,
  LAST_SPLIT_DISTANCE_MID,
  LAST_SPLIT_DISTANCE_HI,
  BLE_PAYLOAD_SIZE
}

class AdditionalStatus2 extends PmData<AdditionalStatus2> {
  static final int uuid = 0x0033;

  int elapsedTime = 0;
  int intervalCount = 0;
  int averagePower = 0;
  int totalCalories = 0;
  int splitAveragePace = 0;
  int splitAveragePower = 0;
  int splitAverageCalories = 0;
  int lastSplitTime = 0;
  int lastSplitDistance = 0;

  Map<String, dynamic> toJson() {
    return {
      'elapsedTime': elapsedTime,
      'intervalCount': intervalCount,
      'averagePower': averagePower,
      'totalCalories': totalCalories,
      'splitAveragePace': splitAveragePace,
      'splitAveragePower': splitAveragePower,
      'splitAverageCalories': splitAverageCalories,
      'lastSplitTime': lastSplitTime,
      'lastSplitDistance': lastSplitDistance
    };
  }

  AdditionalStatus2 from(List<int> intList) {
    AdditionalStatus2 additionalStatus2 = this;
    // @formatter:off
    additionalStatus2.elapsedTime = DataConvUtils.getUint24(intList, AdditionalStatus2ByteFieldIndex.ELAPSED_TIME_LO.index) * 10;
    additionalStatus2.intervalCount = DataConvUtils.getUint8(intList, AdditionalStatus2ByteFieldIndex.INTERVAL_COUNT.index);
    additionalStatus2.averagePower = DataConvUtils.getUint16(intList, AdditionalStatus2ByteFieldIndex.AVG_POWER_LO.index);
    additionalStatus2.totalCalories = DataConvUtils.getUint16(intList, AdditionalStatus2ByteFieldIndex.TOTAL_CALORIES_LO.index);
    additionalStatus2.splitAveragePace = calcPace(DataConvUtils.getUint8(intList, AdditionalStatus2ByteFieldIndex.SPLIT_INTERVAL_AVG_PACE_LO.index),
        DataConvUtils.getUint8(intList, AdditionalStatus2ByteFieldIndex.SPLIT_INTERVAL_AVG_PACE_HI.index));
    additionalStatus2.splitAveragePower =  DataConvUtils.getUint16(intList, AdditionalStatus2ByteFieldIndex.SPLIT_INTERVAL_AVG_POWER_LO.index);
    additionalStatus2.splitAverageCalories = DataConvUtils.getUint16(intList, AdditionalStatus2ByteFieldIndex.SPLIT_INTERVAL_AVG_CALORIES_LO.index);
    additionalStatus2.lastSplitTime = DataConvUtils.getUint16(intList, AdditionalStatus2ByteFieldIndex.LAST_SPLIT_TIME_LO.index) * 100;
    additionalStatus2.lastSplitDistance = DataConvUtils.getUint24(intList, AdditionalStatus2ByteFieldIndex.LAST_SPLIT_DISTANCE_LO.index);

    // @formatter:on
    return additionalStatus2;
  }

  static int calcPace(int lowByte, int highByte) {
    return (lowByte + highByte * 256) * 10;
  }
}