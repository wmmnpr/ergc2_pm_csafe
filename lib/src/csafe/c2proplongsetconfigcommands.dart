import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';

import 'csafe_constants.dart';

enum CSAFE_PM_WORKOUTTYPE {
  // @formatter:off
  JUSTROW_NOSPLITS                     (0x00),
  JUSTROW_SPLITS                       (0x01),
  FIXEDDIST_NOSPLITS                   (0x02),
  FIXEDDIST_SPLITS                     (0x03),
  FIXEDTIME_NOSPLITS                   (0x04),
  FIXEDTIME_SPLITS                     (0x05),
  FIXEDTIME_INTERVAL                   (0x06),
  FIXEDDIST_INTERVAL                   (0x07),
  VARIABLE_INTERVAL                    (0x08),
  VARIABLE_UNDEFINEDREST_INTERVAL      (0x09),
  FIXEDCALORIE_SPLITS                  (0x0A),
  FIXEDWATTMINUTE_SPLITS               (0x0B),
  FIXEDCALS_INTERVAL                   (0x0C);

  final int id;
  const CSAFE_PM_WORKOUTTYPE(this.id);
  // @formatter:on
}

enum SCREEN_TYPE {
  // @formatter:off
  SCREENTYPE_NONE                     (0xFF),
  SCREENTYPE_WORKOUT                  (0x00),
  SCREENTYPE_RACE                     (0x01),
  SCREENTYPE_CSAFE                    (0x02),
  SCREENTYPE_DIAG                     (0x03),
  SCREENTYPE_MFG                      (0x04);
  final int id;
  const SCREEN_TYPE(this.id);
  // @formatter:on
}

enum DURATION_UNITS {
  // @formatter:off
  //  (0: Time, 0x40: Calories, 0x60: Watt-Min, 0x80: Distance)
  TIME                  (0x00),
  CALORIES              (0x40),
  WATT_MIN              (0x60),
  DISTANCE              (0x80);
  final int id;
  const DURATION_UNITS(this.id);
  // @formatter:on
}

enum SCREEN_VALUE {
  // @formatter:off
  SCREENVALUEWORKOUT_NONE                              (0x00),
  SCREENVALUEWORKOUT_PREPARETOROWWORKOUT               (0x01),
  SCREENVALUEWORKOUT_TERMINATEWORKOUT                  (0x02),
  SCREENVALUEWORKOUT_REARMWORKOUT                      (0x03),
  SCREENVALUEWORKOUT_REFRESHLOGCARD                    (0x04),
  SCREENVALUEWORKOUT_PREPARETORACESTART                (0x05),
  SCREENVALUEWORKOUT_GOTOMAINSCREEN                    (0x06),
  SCREENVALUEWORKOUT_LOGCARDBUSYWARNING                (0x07),
  SCREENVALUEWORKOUT_LOGCARDSELECTUSER                 (0x08),
  SCREENVALUEWORKOUT_RESETRACEPARAMS                   (0x09),
  SCREENVALUEWORKOUT_CABLETESTSLAVE                    (0x0A),
  SCREENVALUEWORKOUT_FISHGAME                          (0x0B),
  SCREENVALUEWORKOUT_DISPLAYPARTICIPANTINFO            (0x0C),
  SCREENVALUEWORKOUT_DISPLAYPARTICIPANTINFOCONFIRM     (0x0D),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPETARGET           (0x14),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPESTANDARD         (0x15),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPEFORCEVELOCITY    (0x16),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPEPACEBOAT         (0x17),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPEPERSTROKE        (0x18),
  SCREENVALUEWORKOUT_CHANGEDISPLAYTYPESIMPLE           (0x19),
  SCREENVALUEWORKOUT_CHANGEUNITSTYPETIMEMETERS         (0x1E),
  SCREENVALUEWORKOUT_CHANGEUNITSTYPEPACE               (0x1F),
  SCREENVALUEWORKOUT_CHANGEUNITSTYPEWATTS              (0x20),
  SCREENVALUEWORKOUT_CHANGEUNITSTYPECALORICBURNRATE    (0x21),
  SCREENVALUEWORKOUT_TARGETGAMEBASIC                   (0x22),
  SCREENVALUEWORKOUT_TARGETGAMEADVANCED                (0x23),
  SCREENVALUEWORKOUT_DARTGAME                          (0x24),
  SCREENVALUEWORKOUT_GOTOUSBWAITREADY                  (0x25),
  SCREENVALUEWORKOUT_TACHCABLETESTDISABLE              (0x26),
  SCREENVALUEWORKOUT_TACHSIMDISABLE                    (0x27),
  SCREENVALUEWORKOUT_TACHSIMENABLERATE1                (0x28),
  SCREENVALUEWORKOUT_TACHSIMENABLERATE2                (0x29),
  SCREENVALUEWORKOUT_TACHSIMENABLERATE3                (0x2A),
  SCREENVALUEWORKOUT_TACHSIMENABLERATE4                (0x2B),
  SCREENVALUEWORKOUT_TACHSIMENABLERATE5                (0x2C),
  SCREENVALUEWORKOUT_TACHCABLETESTENABLE               (0x2D),
  SCREENVALUEWORKOUT_CHANGEUNITSTYPECALORIES           (0x2E),
  SCREENVALUEWORKOUT_VIRTUALKEY_A                      (0x2F),
  SCREENVALUEWORKOUT_VIRTUALKEY_B                      (0x30),
  SCREENVALUEWORKOUT_VIRTUALKEY_C                      (0x31),
  SCREENVALUEWORKOUT_VIRTUALKEY_D                      (0x32),
  SCREENVALUEWORKOUT_VIRTUALKEY_E                      (0x33),
  SCREENVALUEWORKOUT_VIRTUALKEY_UNITS                  (0x34),
  SCREENVALUEWORKOUT_VIRTUALKEY_DISPLAY                (0x35),
  SCREENVALUEWORKOUT_VIRTUALKEY_MENU                   (0x36),
  SCREENVALUEWORKOUT_TACHSIMENABLERATERANDOM           (0x37),
  SCREENVALUEWORKOUT_SCREENREDRAW                      (0xFF);

  // @formatter:on
  final int id;

  const SCREEN_VALUE(this.id);
}

abstract class CSafeCommand {
  final CSAFE_PROP_LONG_SET_CONFIG_CMDS id;

  List<int> toBytes();

  const CSafeCommand(this.id);
}

class CSafeCommandFrame {
  List<CSafeCommand> commands;

  CSafeCommandFrame(this.commands);

  List<int> toBytes() {
    IntList buffer = [];
    for (var command in commands) {
      buffer.addAll(command.toBytes());
    }
    buffer.insertAll(0, [0x76, buffer.length]);
    int checkSum = DataConvUtils.checksum(buffer);
    buffer.add(checkSum);
    buffer.insert(0, 0xf1);
    buffer.insert(buffer.length, 0xf2);
    return buffer;
  }
}

class CSafeSetWorkoutType extends CSafeCommand {
  CSAFE_PM_WORKOUTTYPE workoutType;

  CSafeSetWorkoutType(this.workoutType)
      : super(CSAFE_PROP_LONG_SET_CONFIG_CMDS.CSAFE_PM_SET_WORKOUTTYPE);

  CSafeSetWorkoutType.build(
      {workouType = CSAFE_PM_WORKOUTTYPE.FIXEDDIST_SPLITS})
      : this(workouType);

  @override
  List<int> toBytes() {
    return [super.id.id, 0x01, workoutType.id];
  }
}

class CSafeSetWorkoutDuration extends CSafeCommand {
  DURATION_UNITS durationUnits;
  int duration;

  CSafeSetWorkoutDuration(this.durationUnits, this.duration)
      : super(CSAFE_PROP_LONG_SET_CONFIG_CMDS.CSAFE_PM_SET_WORKOUTDURATION);

  CSafeSetWorkoutDuration.build(
      {durationUnits = DURATION_UNITS.DISTANCE, required duration})
      : this(durationUnits, duration);

  @override
  List<int> toBytes() {
    int byte0 = duration ~/ 16777216;
    int byte1 = (duration - (byte0 * 16777216)) ~/ 65536;
    int byte2 = (duration - (byte0 * 16777216) - (byte1 * 65536)) ~/ 256;
    int byte3 =
        (duration - (byte0 * 16777216) - (byte1 * 65536) - (byte2 * 256))
            .toInt();

    return [super.id.id, 0x05, durationUnits.id, byte0, byte1, byte2, byte3];
  }
}

class CSafeSetSplitDuration extends CSafeCommand {
  DURATION_UNITS durationUnits;
  int duration;

  CSafeSetSplitDuration(this.durationUnits, this.duration)
      : super(CSAFE_PROP_LONG_SET_CONFIG_CMDS.CSAFE_PM_SET_SPLITDURATION);

  CSafeSetSplitDuration.build(
      {durationUnits = DURATION_UNITS.DISTANCE, required duration})
      : this(durationUnits, duration);

  @override
  List<int> toBytes() {
    int byte0 = duration ~/ 16777216;
    int byte1 = (duration - (byte0 * 16777216)) ~/ 65536;
    int byte2 = (duration - (byte0 * 16777216) - (byte1 * 65536)) ~/ 256;
    int byte3 =
    (duration - (byte0 * 16777216) - (byte1 * 65536) - (byte2 * 256))
        .toInt();

    return [super.id.id, 0x05, durationUnits.id, byte0, byte1, byte2, byte3];
  }
}

class CSafeConfigureWorkout extends CSafeCommand {
  bool programmingMode;

  CSafeConfigureWorkout(this.programmingMode)
      : super(CSAFE_PROP_LONG_SET_CONFIG_CMDS.CSAFE_PM_CONFIGURE_WORKOUT);

  CSafeConfigureWorkout.build({programmingMode = true}) : this(programmingMode);

  @override
  List<int> toBytes() {
    return [super.id.id, 0x01, programmingMode ? 0x01 : 0x00];
  }
}

class CSafeSetScreenState extends CSafeCommand {
  SCREEN_TYPE screenType;
  SCREEN_VALUE screenValue;

  CSafeSetScreenState(this.screenType, this.screenValue)
      : super(CSAFE_PROP_LONG_SET_CONFIG_CMDS.CSAFE_PM_SET_SCREENSTATE);

  CSafeSetScreenState.build(
      {screenType = SCREEN_TYPE.SCREENTYPE_WORKOUT,
      screenValue = SCREEN_VALUE.SCREENVALUEWORKOUT_PREPARETOROWWORKOUT})
      : this(screenType, screenValue);

  @override
  List<int> toBytes() {
    return [super.id.id, 0x02, screenType.id, screenValue.id];
  }
}
