extension StringExtensions on String {
  String stripCommnad() {
    return this.replaceAll(":", "");
  }
}

abstract class PmData<T> {
  T from(List<int> intList);
}

enum StrokeDataByteFieldIndex {
  ELAPSED_TIME_LO,
  ELAPSED_TIME_MID,
  ELAPSED_TIME_HI,
  DISTANCE_LO,
  DISTANCE_MID,
  DISTANCE_HI,
  DRIVE_LENGTH,
  DRIVE_TIME,
  STROKE_RECOVERY_TIME_LO,
  STROKE_RECOVERY_TIME_HI,
  STROKE_DISTANCE_LO,
  STROKE_DISTANCE_HI,
  PEAK_DRIVE_FORCE_LO,
  PEAK_DRIVE_FORCE_HI,
  AVG_DRIVE_FORCE_LO,
  AVG_DRIVE_FORCE_HI,
  WORK_PER_STROKE_LO,
  WORK_PER_STROKE_HI,
  STROKE_COUNT_LO,
  STROKE_COUNT_HI,
  BLE_PAYLOAD_SIZE
}

class StrokeData extends PmData<StrokeData> {
  static final int uuid = 0x0035;

  int elapsedTime = 0;
  double distance = 0;
  double driveLength = 0;
  int driveTime = 0;
  int strokeRecoveryTime = 0;
  double strokeDistance = 0;
  double peakDriveForce = 0;
  double averageDriveForce = 0;
  double workPerStroke = 0;
  int strokeCount = 0;

  Map<String, dynamic> toJson() {
    return {
      'elapsedTime': elapsedTime,
      'distance': distance,
      'driveLength': driveLength,
      'driveTime': driveTime,
      'strokeRecoveryTime': strokeRecoveryTime,
      'strokeDistance': strokeDistance,
      'peakDriveForce': peakDriveForce,
      'averageDriveForce': averageDriveForce,
      'workPerStroke': workPerStroke,
      'strokeCount': strokeCount
    };
  }

  StrokeData from(List<int> intList) {
    StrokeData strokeData = this;
    // @formatter:off
    strokeData.elapsedTime = DataConvUtils.getUint24(intList, StrokeDataByteFieldIndex.ELAPSED_TIME_LO.index) * 10;
    strokeData.distance = DataConvUtils.getUint24(intList, StrokeDataByteFieldIndex.DISTANCE_LO.index) / 10;
    strokeData.driveLength = DataConvUtils.getUint8(intList, StrokeDataByteFieldIndex.DRIVE_LENGTH.index) / 100;
    strokeData.driveTime = DataConvUtils.getUint8(intList, StrokeDataByteFieldIndex.DRIVE_TIME.index) * 10;
    strokeData.strokeRecoveryTime = (DataConvUtils.getUint8(intList, StrokeDataByteFieldIndex.STROKE_RECOVERY_TIME_LO.index)
        + DataConvUtils.getUint8(intList, StrokeDataByteFieldIndex.STROKE_RECOVERY_TIME_HI.index) * 256) * 10;
    strokeData.strokeDistance = DataConvUtils.getUint16(intList, StrokeDataByteFieldIndex.STROKE_DISTANCE_LO.index) / 100;
    strokeData.peakDriveForce = DataConvUtils.getUint16(intList, StrokeDataByteFieldIndex.PEAK_DRIVE_FORCE_LO.index) / 10;
    strokeData.averageDriveForce = DataConvUtils.getUint16(intList, StrokeDataByteFieldIndex.AVG_DRIVE_FORCE_LO.index) / 10;
    strokeData.workPerStroke = DataConvUtils.getUint16(intList, StrokeDataByteFieldIndex.WORK_PER_STROKE_LO.index) / 10;
    strokeData.strokeCount = DataConvUtils.getUint8(intList, StrokeDataByteFieldIndex.STROKE_COUNT_LO.index)
        + DataConvUtils.getUint8(intList,  StrokeDataByteFieldIndex.STROKE_COUNT_HI.index) * 256;
    // @formatter:on
    return strokeData;
  }
}

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

class DataConvUtils {
  static int getUint8(List<int> data, int offset) {
    return data[offset];
  }

  static int getUint16(List<int> data, int offset) {
    return data[offset + 1] << 8 + data[offset];
  }

  static int getUint24(List<int> data, int offset) {
    return (data[offset + 2] << 16) + (data[offset + 1] << 8) + (data[offset]);
  }

  static int checksum(List<int> content) {
    int checksum = 0;
    for (int i = 0; i < content.length; i++) {
      checksum ^= content[i];
    }
    return checksum;
  }

  static String intArrayToHex(List<int> intArray) {
    for (var value in intArray) {
      if (value < 0 || value > 255) {
        throw ArgumentError('All integers must be in the range 0-255.');
      }
    }

    // Convert each integer to a two-character hex string and concatenate them
    final hexStringBuffer = StringBuffer();
    for (var value in intArray) {
      hexStringBuffer.write(value.toRadixString(16).padLeft(2, '0'));
    }
    return hexStringBuffer.toString();
  }

  static List<int> hexStringToIntArray(String hex) {
    // Ensure the string length is even
    if (hex.length % 2 != 0) {
      throw FormatException('Hex string must have an even length');
    }
    // Initialize an empty list to store the integers
    List<int> intArray = [];
    // Loop through the hex string, taking 2 characters at a time
    for (int i = 0; i < hex.length; i += 2) {
      // Get the hex substring (2 characters)
      String hexPair = hex.substring(i, i + 2);
      // Convert the hex pair to an integer and add to the list
      int value = int.parse(hexPair, radix: 16);
      intArray.add(value);
    }
    return intArray;
  }
}
