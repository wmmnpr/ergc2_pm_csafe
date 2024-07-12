/* Frame contents */
// @formatter:off
import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';

const int CSAFE_EXT_FRAME_START_BYTE        = 0xF0;
const int CSAFE_FRAME_START_BYTE            = 0xF1;
const int CSAFE_FRAME_END_BYTE              = 0xF2;
const int CSAFE_FRAME_STUFF_BYTE            = 0xF3;

const int CSAFE_FRAME_MAX_STUFF_OFFSET_BYTE = 0x03;

const int CSAFE_FRAME_FLG_LEN               = 2;
const int CSAFE_EXT_FRAME_ADDR_LEN          = 2;
const int CSAFE_FRAME_CHKSUM_LEN            = 1;

const int CSAFE_SHORT_CMD_TYPE_MSK          = 0x80;
const int CSAFE_LONG_CMD_HDR_LENGTH         = 2;
const int CSAFE_LONG_CMD_BYTE_CNT_OFFSET    = 1;
const int CSAFE_RSP_HDR_LENGTH              = 2;

const int CSAFE_FRAME_STD_TYPE              = 0;
const int CSAFE_FRAME_EXT_TYPE              = 1;

const int CSAFE_DESTINATION_ADDR_HOST       = 0x00;
const int CSAFE_DESTINATION_ADDR_ERG_MASTER = 0x01;
const int CSAFE_DESTINATION_ADDR_BROADCAST  = 0xFF;
const int CSAFE_DESTINATION_ADDR_ERG_DEFAULT= 0xFD;

const int CSAFE_FRAME_MAXSIZE               = 96;
const int CSAFE_INTERFRAMEGAP_MIN				    = 50;
const int CSAFE_CMDUPLIST_MAXSIZE           = 10;
const int CSAFE_MEMORY_BLOCKSIZE            = 64;
const int CSAFE_FORCEPLOT_BLOCKSIZE         = 32;
const int CSAFE_HEARTBEAT_BLOCKSIZE			    = 32;

/* Manufacturer Info */
const int CSAFE_MANUFACTURE_ID              = 22;
const int CSAFE_CLASS_ID                    = 2;

const int CSAFE_MODEL_NUM						        = 5;
const int CSAFE_UNITS_TYPE				          = 0;
const int CSAFE_SERIALNUM_DIGITS		        = 9;

const int CSAFE_HMS_FORMAT_CNT				      = 3;
const int CSAFE_YMD_FORMAT_CNT				      = 3;
const int CSAFE_ERRORCODE_FORMAT_CNT	      = 3;

/* Command space partitioning for standard commands */
const int CSAFE_CTRL_CMD_LONG_MIN           = 0x01;
const int CSAFE_CFG_CMD_LONG_MIN            = 0x10;
const int CSAFE_DATA_CMD_LONG_MIN           = 0x20;
const int CSAFE_AUDIO_CMD_LONG_MIN          = 0x40;
const int CSAFE_TEXTCFG_CMD_LONG_MIN        = 0x60;
const int CSAFE_TEXTSTATUS_CMD_LONG_MIN     = 0x65;
const int CSAFE_CAP_CMD_LONG_MIN            = 0x70;
const int CSAFE_PMPROPRIETARY_CMD_LONG_MIN  = 0x76;

const int CSAFE_CTRL_CMD_SHORT_MIN          = 0x80;
const int CSAFE_STATUS_CMD_SHORT_MIN        = 0x91;
const int CSAFE_DATA_CMD_SHORT_MIN          = 0xA0;
const int CSAFE_AUDIO_CMD_SHORT_MIN         = 0xC0;
const int CSAFE_TEXTCFG_CMD_SHORT_MIN       = 0xE0;
const int CSAFE_TEXTSTATUS_CMD_SHORT_MIN    = 0xE5;

/* Command space partitioning for PM proprietary commands */
const int CSAFE_GETPMCFG_CMD_SHORT_MIN      = 0x80;
const int CSAFE_GETPMCFG_CMD_LONG_MIN       = 0x50;
const int CSAFE_SETPMCFG_CMD_SHORT_MIN      = 0xE0;
const int CSAFE_SETPMCFG_CMD_LONG_MIN       = 0x00;
const int CSAFE_GETPMDATA_CMD_SHORT_MIN     = 0xA0;
const int CSAFE_GETPMDATA_CMD_LONG_MIN      = 0x68;
const int CSAFE_SETPMDATA_CMD_SHORT_MIN     = 0xD0;
const int CSAFE_SETPMDATA_CMD_LONG_MIN      = 0x30;

typedef Unmarshal = Map<String, Object>Function(List<String> keys, IntList);
typedef Marshal = IntList Function (Map<String, Object>);

Map<String, Object>unpackByte(List<String> keys, IntList values) {
  return {
    keys[0]: values[0]
  };
}

IntList packByte(Map<String, Object>map) {
  return [1];
}

enum FrameFieldType {
  CHAR, INT, INT2, INT3, INT4, FLOAT, RACE_TYPE;
}

class CsafeParserContext {
  Map<String, Object>result = {};
}

class FrameContentProcessor{
  int cmd;
  Map<String, FrameFieldType>?fields;

  FrameContentProcessor(this.cmd, this.fields);

  int process(CsafeParserContext context, IntList data, int start){
    int cmd = data[start];
    assert(cmd == this.cmd);
    int length = data[start+1];
    int pos = start + 2;
    this.fields!.forEach((key, value) {
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
          context.result.putIfAbsent(key, () => (data[pos] << 32) + (data[pos+1] << 16) + (data[pos+2]) + data[pos+3]);
          pos = pos + 4;
        default:
      }
    });
    return pos;
  }
}


/// Public Short Commands
/// Page: 46 & 47
enum CSAFE_PUBLIC_SHORT_CMDS {
  CSAFE_GETSTATUS_CMD                 (0x80),
  CSAFE_RESET_CMD                     (0x81),
  CSAFE_GOIDLE_CMD                    (0x82),
  CSAFE_GOHAVEID_CMD                  (0x83),
  CSAFE_GOINUSE_CMD                   (0x85),
  CSAFE_GOFINISHED_CMD                (0x86),
  CSAFE_GOREADY_CMD                   (0x87),
  CSAFE_BADID_CMD                     (0x88),
  CSAFE_GETVERSION_CMD                (0x91),
  CSAFE_GETID_CMD                     (0x92),
  CSAFE_GETUNITS_CMD                  (0x93),
  CSAFE_GETSERIAL_CMD                 (0x94),
  CSAFE_GETLIST_CMD                   (0x98),
  CSAFE_GETUTILIZATION_CMD            (0x99),
  CSAFE_GETMOTORCURRENT_CMD           (0x9A),
  CSAFE_GETODOMETER_CMD               (0x9B),
  CSAFE_GETERRORCODE_CMD              (0x9C),
  CSAFE_GETSERVICECODE_CMD            (0x9D),
  CSAFE_GETUSERCFG1_CMD               (0x9E),
  CSAFE_GETUSERCFG2_CMD               (0x9F),
  CSAFE_GETTWORK_CMD                  (0xA0),
  CSAFE_GETHORIZONTAL_CMD             (0xA1),
  CSAFE_GETVERTICAL_CMD               (0xA2),
  CSAFE_GETCALORIES_CMD               (0xA3),
  CSAFE_GETPROGRAM_CMD                (0xA4),
  CSAFE_GETSPEED_CMD                  (0xA5),
  CSAFE_GETPACE_CMD                   (0xA6),
  CSAFE_GETCADENCE_CMD                (0xA7),
  CSAFE_GETGRADE_CMD                  (0xA8),
  CSAFE_GETGEAR_CMD                   (0xA9),
  CSAFE_GETUPLIST_CMD                 (0xAA),
  CSAFE_GETUSERINFO_CMD               (0xAB),
  CSAFE_GETTORQUE_CMD                 (0xAC),
  CSAFE_GETHRCUR_CMD                  (0xB0),
  CSAFE_GETHRTZONE_CMD                (0xB2),
  CSAFE_GETMETS_CMD                   (0xB3),
  CSAFE_GETPOWER_CMD                  (0xB4),
  CSAFE_GETHRAVG_CMD                  (0xB5),
  CSAFE_GETHRMAX_CMD                  (0xB6),
  CSAFE_GETUSERDATA1_CMD              (0xBE),
  CSAFE_GETUSERDATA2_CMD              (0xBF),
  CSAFE_GETAUDIOCHANNEL_CMD           (0xC0),
  CSAFE_GETAUDIOVOLUME_CMD            (0xC1),
  CSAFE_GETAUDIOMUTE_CMD              (0xC2),
  CSAFE_ENDTEXT_CMD                   (0xE0),
  CSAFE_DISPLAYPOPUP_CMD              (0xE1),
  CSAFE_GETPOPUPSTATUS_CMD            (0xE5),
  CSAFE_CTRL_CMD_SHORT_MAX            (0xE6);
  final int id;
  const CSAFE_PUBLIC_SHORT_CMDS(this.id);
}

/// Public Long Commands
/// Page: 47 & 48
enum CSAFE_PUBLIC_LONG_CMDS {
  CSAFE_AUTOUPLOAD_CMD2               (0x01),
  CSAFE_UPLIST_CMD                    (0x02),
  CSAFE_UPSTATUSSEC_CMD               (0x04),
  CSAFE_UPLISTSEC_CMD                 (0x05),
  CSAFE_IDDIGITS_CMD                  (0x10),
  CSAFE_SETTIME_CMD                   (0x11),
  CSAFE_SETDATE_CMD                   (0x12),
  CSAFE_SETTIMEOUT_CMD                (0x13),
  CSAFE_SETUSERCFG1_CMD               (0x1A),
  CSAFE_SETUSERCFG2_CMD               (0x1B),
  CSAFE_SETTWORK_CMD                  (0x20),
  CSAFE_SETHORIZONTAL_CMD             (0x21),
  CSAFE_SETVERTICAL_CMD               (0x22),
  CSAFE_SETCALORIES_CMD               (0x23),
  CSAFE_SETPROGRAM_CMD                (0x24),
  CSAFE_SETSPEED_CMD                  (0x25),
  CSAFE_SETGRADE_CMD                  (0x28),
  CSAFE_SETGEAR_CMD                   (0x29),
  CSAFE_SETUSERINFO_CMD               (0x2B),
  CSAFE_SETTORQUE_CMD                 (0x2C),
  CSAFE_SETLEVEL_CMD                  (0x2D),
  CSAFE_SETTARGETHR_CMD               (0x30),
  CSAFE_SETMETS_CMD                   (0x33),
  CSAFE_SETPOWER_CMD                  (0x34),
  CSAFE_SETHRZONE_CMD                 (0x35),
  CSAFE_SETHRMAX_CMD                  (0x36),
  CSAFE_SETCHANNELRANGE_CMD           (0x40),
  CSAFE_SETVOLUMERANGE_CMD            (0x41),
  CSAFE_SETAUDIOMUTE_CMD              (0x42),
  CSAFE_SETAUDIOCHANNEL_CMD           (0x43),
  CSAFE_SETAUDIOVOLUME_CMD            (0x44),
  CSAFE_STARTTEXT_CMD                 (0x60),
  CSAFE_APPENDTEXT_CMD                (0x61),
  CSAFE_GETTEXTSTATUS_CMD             (0x65),
  CSAFE_GETCAPS_CMD                   (0x70),
  CSAFE_SETPMCFG_CMD                  (0x76),
  CSAFE_SETPMDATA_CMD                 (0x77),
  CSAFE_GETPMCFG_CMD                  (0x7E),
  CSAFE_GETPMDATA_CMD                 (0x7F);
  final int id;
  const CSAFE_PUBLIC_LONG_CMDS(this.id);
}
/// C2 Proprietary Short Commands
/// page: 49 & 50
///
enum CSAFE_PROPRIETARY_SHORT_CMDS {
  CSAFE_PM_GET_WORKOUTTYPE            (0x89),
  CSAFE_PM_GET_WORKOUTSTATE           (0x8D),
  CSAFE_PM_GET_INTERVALTYPE           (0x8E),
  CSAFE_PM_GET_WORKOUTINTERVALCOUNT   (0x9F),
  CSAFE_PM_GET_WORKTIME               (0xA0),
  CSAFE_PM_GET_WORKDISTANCE           (0xA3),
  CSAFE_PM_GET_ERRORVALUE2            (0xC9),
  SAFE_PM_GET_RESTTIME                (0xCF);
  final int id;
  const CSAFE_PROPRIETARY_SHORT_CMDS(this.id);
}

/// C2 Proprietary Long Commands
/// Page: 50
///
enum CSAFE_PROPRIETARY_LONG_CMDS {
  CSAFE_PM_SET_SPLITDURATION          (0x05, null, null),
  CSAFE_PM_GET_FORCEPLOTDATA          (0x6B, null, null),
  CSAFE_PM_SET_SCREENERRORMODE        (0x27, null, null),
  CSAFE_PM_GET_HEARTBEATDATA          (0x6C, null, null);
  final int id;
  final Unmarshal? unpack;
  final Marshal? pack;
  const CSAFE_PROPRIETARY_LONG_CMDS(this.id, this.unpack, this.pack);
}


/// C2 Proprietary Short Get Configuration Commands
/// Page: 54
///
///

enum CSAFE_PROP_SHORT_GET_CONF_CMDS {
  CSAFE_PM_GET_FW_VERSION                             (0x80, null),
  CSAFE_PM_GET_HW_VERSION                             (0x81, null),
  CSAFE_PM_GET_HW_ADDRESS                             (0x82, null),
  CSAFE_PM_GET_TICK_TIMEBASE                          (0x83, null),
  CSAFE_PM_GET_HRM                                    (0x84, null),
  CSAFE_PM_GET_DATETIME                               (0x85, {"hours": FrameFieldType.INT, "minutes": FrameFieldType.INT, "meridiem": FrameFieldType.INT, "month": FrameFieldType.INT, "day": FrameFieldType.INT, "year": FrameFieldType.INT2}),
  CSAFE_PM_GET_SCREENSTATESTATUS                      (0x86, null),
  CSAFE_PM_GET_RACE_LANE_REQUEST                      (0x87, null),
  CSAFE_PM_GET_RACE_ENTRY_REQUEST                     (0x88, null),
  CSAFE_PM_GET_WORKOUTTYPE                            (0x89, null),
  CSAFE_PM_GET_DISPLAYTYPE                            (0x8A, null),
  CSAFE_PM_GET_DISPLAYUNITS                           (0x8B, null),
  CSAFE_PM_GET_LANGUAGETYPE                           (0x8C, null),
  CSAFE_PM_GET_WORKOUTSTATE                           (0x8D, null),
  CSAFE_PM_GET_INTERVALTYPE                           (0x8E, null),
  CSAFE_PM_GET_OPERATIONALSTATE                       (0x8F, null),
  CSAFE_PM_GET_LOGCARDSTATE                           (0x90, null),
  CSAFE_PM_GET_LOGCARDSTATUS                          (0x91, null),
  CSAFE_PM_GET_POWERUPSTATE                           (0x92, null),
  CSAFE_PM_GET_ROWINGSTATE                            (0x93, null),
  CSAFE_PM_GET_SCREENCONTENT_VERSION                  (0x94, null),
  CSAFE_PM_GET_COMMUNICATIONSTATE                     (0x95, null),
  CSAFE_PM_GET_RACEPARTICIPANTCOUNT                   (0x96, null),
  CSAFE_PM_GET_BATTERYLEVELPERCENT                    (0x97, null),
  CSAFE_PM_GET_RACEMODESTATUS                         (0x98, null),
  CSAFE_PM_GET_INTERNALLOGPARAMS                      (0x99, null),
  CSAFE_PM_GET_PRODUCTCONFIGURATION                   (0x9A, null),
  CSAFE_PM_GET_ERGSLAVEDISCOVERREQUESTSTATUS          (0x9B, null),
  CSAFE_PM_GET_WIFICONFIG                             (0x9C, null),
  CSAFE_PM_GET_CPUTICKRATE                            (0x9D, null),
  CSAFE_PM_GET_LOGCARDUSERCENSUS                      (0x9E, null),
  CSAFE_PM_GET_WORKOUTINTERVALCOUNT                   (0x9F, null),
  CSAFE_PM_GET_WORKOUTDURATION                        (0xE8, null),
  CSAFE_PM_GET_WORKOTHER                              (0xE9, null),
  CSAFE_PM_GET_EXTENDED_HRM                           (0xEA, null),
  CSAFE_PM_GET_DEFCALIBRATIONVERFIED                  (0xEB, null),
  CSAFE_PM_GET_FLYWHEELSPEED                          (0xEC, null),
  CSAFE_PM_GET_ERGMACHINETYPE                         (0xED, null),
  CSAFE_PM_GET_RACE_BEGINEND_TICKCOUNT                (0xEE, null),
  CSAFE_PM_GET_PM5_FWUPDATESTATUS                     (0xEF, null);

  final int id;
  final Map<String, FrameFieldType>?fields;
  const CSAFE_PROP_SHORT_GET_CONF_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Get Configuration Commands
/// Page: 57
///


/// C2 Proprietary Short Get Data Commands
/// Page: 59
///

/// C2 Proprietary Long Get Data Commands
/// Page: 62

/// C2 Proprietary Short Set Configuration Commands
/// Page: 65
///

/// C2 Proprietary Short Set Configuration Commands
/// Page: 65
///

/// C2 Proprietary Long Set Configuration Commands
/// Page: 65
///


/// C2 Proprietary Long Set Data Commands
/// Page: 69
///



const Map<int, String>STATE_MACHINE_STATE = {
  0x00: "Error",
  0x01: "Ready",
  0x02: "Idle",
  0x03: "Have ID",
  0x05: "In Use",
  0x06: "Pause",
  0x07: "Finish",
  0x08: "Manual",
  0x09: "Off line"
};

const Map<int, String>PREVIOUS_FRAME_STATUS = {
  0x00: "Ok",
  0x10: "Reject",
  0x20: "Bad",
  0x30: "Not ready"
};


enum RACE_TYPE {
  RACETYPE_FIXEDDIST_SINGLEERG                                   (00),
  RACETYPE_FIXEDTIME_SINGLEERG                                   (01),
  RACETYPE_FIXEDDIST_TEAMERG                                     (02),
  RACETYPE_FIXEDTIME_TEAMERG                                     (03),
  RACETYPE_WORKOUTRACESTART                                      (04),
  RACETYPE_FIXEDCAL_SINGLEERG                                    (05),
  RACETYPE_FIXEDCAL_TEAMERG                                      (06),
  RACETYPE_FIXEDDIST_RELAY_SINGLEERG                             (07),
  RACETYPE_FIXEDTIME_RELAY_SINGLEERG                             (08),
  RACETYPE_FIXEDCAL_RELAY_SINGLEERG                              (09),
  RACETYPE_FIXEDDIST_RELAY_TEAMERG                               (10),
  RACETYPE_FIXEDTIME_RELAY_TEAMERG                               (11),
  RACETYPE_FIXEDCAL_RELAY_TEAMERG                                (12),
  RACETYPE_FIXEDDIST_MULTIACTIVITY_SEQUENTIAL_SINGLEERG          (13),
  RACETYPE_FIXEDTIME_MULTIACTIVITY_SEQUENTIAL_SINGLEERG          (14),
  RACETYPE_FIXEDCAL_MULTIACTIVITY_SEQUENTIAL_SINGLEERG           (15),
  RACETYPE_FIXEDDIST_MULTIACTIVITY_SEQUENTIAL_TEAMERG            (16),
  RACETYPE_FIXEDTIME_MULTIACTIVITY_SEQUENTIAL_TEAMERG            (17),
  RACETYPE_FIXEDCAL_MULTIACTIVITY_SEQUENTIAL_TEAMERG             (18),
  RACETYPE_FIXEDDIST_ERGATHLON                                   (19),
  RACETYPE_FIXEDTIME_ERGATHLON                                   (20),
  RACETYPE_FIXEDCAL_ERGATHLON                                    (21),
  RACETYPE_FIXEDDIST_MULTIACTIVITY_SIMULTANEOUS_SINGLEERG        (22),
  RACETYPE_FIXEDTIME_MULTIACTIVITY_SIMULTANEOUS_SINGLEERG        (23),
  RACETYPE_FIXEDCAL_MULTIACTIVITY_SIMULTANEOUS_SINGLEERG         (24),
  RACETYPE_FIXEDDIST_MULTIACTIVITY_SIMULTANEOUS_TEAMERG          (25),
  RACETYPE_FIXEDTIME_MULTIACTIVITY_SIMULTANEOUS_TEAMERG          (26),
  RACETYPE_FIXEDCAL_MULTIACTIVITY_SIMULTANEOUS_TEAMERG           (27),
  RACETYPE_FIXEDDIST_BIATHLON                                    (28),
  RACETYPE_FIXEDCAL_BIATHLON                                     (29),
  RACETYPE_FIXEDDIST_RELAY_NOCHANGE_SINGLEERG                    (30),
  RACETYPE_FIXEDTIME_RELAY_NOCHANGE_SINGLEERG                    (31),
  RACETYPE_FIXEDCAL_RELAY_NOCHANGE_SINGLEERG                     (32),
  RACETYPE_FIXEDTIME_CALSCORE_SINGLEERG                          (33),
  RACETYPE_FIXEDTIME_CALSCORE_TEAMERG                            (34),
  RACETYPE_FIXEDDIST_TIMECAP_SINGLEERG                           (35),
  RACETYPE_FIXEDCAL_TIMECAP_SINGLEERG                            (36);
  final int id;
  const RACE_TYPE(this.id);

}