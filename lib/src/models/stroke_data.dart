import 'package:ergc2_pm_csafe/src/models/pm_data.dart';

import 'data_conv_utils.dart';

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

  @override
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
