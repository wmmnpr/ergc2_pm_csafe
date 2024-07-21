/* Frame contents */
// @formatter:off


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
const int CSAFE_INTERFRAMEGAP_MIN           = 50;
const int CSAFE_CMDUPLIST_MAXSIZE           = 10;
const int CSAFE_MEMORY_BLOCKSIZE            = 64;
const int CSAFE_FORCEPLOT_BLOCKSIZE         = 32;
const int CSAFE_HEARTBEAT_BLOCKSIZE         = 32;

/* Manufacturer Info */
const int CSAFE_MANUFACTURE_ID              = 22;
const int CSAFE_CLASS_ID                    = 2;

const int CSAFE_MODEL_NUM                   = 5;
const int CSAFE_UNITS_TYPE                  = 0;
const int CSAFE_SERIALNUM_DIGITS            = 9;

const int CSAFE_HMS_FORMAT_CNT              = 3;
const int CSAFE_YMD_FORMAT_CNT              = 3;
const int CSAFE_ERRORCODE_FORMAT_CNT        = 3;

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

enum FrameFieldType {
  STATE, CHAR, INT, INT2, INT3, INT4, FLOAT, VAR_BUFF;
}

/// Public Short Commands
/// Page: 46 & 47
enum CSAFE_PUBLIC_SHORT_CMDS {
  CSAFE_GETSTATUS_CMD                 (0x80, {"status": FrameFieldType.CHAR}),
  CSAFE_RESET_CMD                     (0x81, {"state": FrameFieldType.STATE}),
  CSAFE_GOIDLE_CMD                    (0x82, {"state": FrameFieldType.STATE}),
  CSAFE_GOHAVEID_CMD                  (0x83, {"state": FrameFieldType.STATE}),
  CSAFE_GOINUSE_CMD                   (0x85, {"state": FrameFieldType.STATE}),
  CSAFE_GOFINISHED_CMD                (0x86, {"state": FrameFieldType.STATE}),
  CSAFE_GOREADY_CMD                   (0x87, {"state": FrameFieldType.STATE}),
  CSAFE_BADID_CMD                     (0x88, {"state": FrameFieldType.STATE}),
  CSAFE_GETVERSION_CMD                (0x91, {"mfgId": FrameFieldType.CHAR, "cId": FrameFieldType.CHAR, "model": FrameFieldType.CHAR, "hWVersion": FrameFieldType.INT2, "sWVerson": FrameFieldType.INT2}),
  CSAFE_GETID_CMD                     (0x92, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETUNITS_CMD                  (0x93, {"unitType": FrameFieldType.INT}),
  CSAFE_GETSERIAL_CMD                 (0x94, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETLIST_CMD                   (0x98, {}),
  CSAFE_GETUTILIZATION_CMD            (0x99, {}),
  CSAFE_GETMOTORCURRENT_CMD           (0x9A, {}),
  CSAFE_GETODOMETER_CMD               (0x9B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETERRORCODE_CMD              (0x9C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETSERVICECODE_CMD            (0x9D, {}),
  CSAFE_GETUSERCFG1_CMD               (0x9E, {}),
  CSAFE_GETUSERCFG2_CMD               (0x9F, {}),
  CSAFE_GETTWORK_CMD                  (0xA0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETHORIZONTAL_CMD             (0xA1, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETVERTICAL_CMD               (0xA2, {}),
  CSAFE_GETCALORIES_CMD               (0xA3, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETPROGRAM_CMD                (0xA4, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETSPEED_CMD                  (0xA5, {}),
  CSAFE_GETPACE_CMD                   (0xA6, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETCADENCE_CMD                (0xA7, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETGRADE_CMD                  (0xA8, {}),
  CSAFE_GETGEAR_CMD                   (0xA9, {}),
  CSAFE_GETUPLIST_CMD                 (0xAA, {}),
  CSAFE_GETUSERINFO_CMD               (0xAB, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETTORQUE_CMD                 (0xAC, {}),
  CSAFE_GETHRCUR_CMD                  (0xB0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETHRTZONE_CMD                (0xB2, {}),
  CSAFE_GETMETS_CMD                   (0xB3, {}),
  CSAFE_GETPOWER_CMD                  (0xB4, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETHRAVG_CMD                  (0xB5, {}),
  CSAFE_GETHRMAX_CMD                  (0xB6, {}),
  CSAFE_GETUSERDATA1_CMD              (0xBE, {}),
  CSAFE_GETUSERDATA2_CMD              (0xBF, {}),
  CSAFE_GETAUDIOCHANNEL_CMD           (0xC0, {}),
  CSAFE_GETAUDIOVOLUME_CMD            (0xC1, {}),
  CSAFE_GETAUDIOMUTE_CMD              (0xC2, {}),
  CSAFE_ENDTEXT_CMD                   (0xE0, {}),
  CSAFE_DISPLAYPOPUP_CMD              (0xE1, {}),
  CSAFE_GETPOPUPSTATUS_CMD            (0xE5, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PUBLIC_SHORT_CMDS(this.id, this.fields);
}

/// Public Long Commands
/// Page: 47 & 48
enum CSAFE_PUBLIC_LONG_CMDS {
  CSAFE_AUTOUPLOAD_CMD2               (0x01, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_UPLIST_CMD                    (0x02, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_UPSTATUSSEC_CMD               (0x04, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_UPLISTSEC_CMD                 (0x05, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_IDDIGITS_CMD                  (0x10, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETTIME_CMD                   (0x11, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETDATE_CMD                   (0x12, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETTIMEOUT_CMD                (0x13, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETUSERCFG1_CMD               (0x1A, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETUSERCFG2_CMD               (0x1B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETTWORK_CMD                  (0x20, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETHORIZONTAL_CMD             (0x21, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETVERTICAL_CMD               (0x22, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETCALORIES_CMD               (0x23, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETPROGRAM_CMD                (0x24, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETSPEED_CMD                  (0x25, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETGRADE_CMD                  (0x28, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETGEAR_CMD                   (0x29, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETUSERINFO_CMD               (0x2B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETTORQUE_CMD                 (0x2C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETLEVEL_CMD                  (0x2D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETTARGETHR_CMD               (0x30, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETMETS_CMD                   (0x33, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETPOWER_CMD                  (0x34, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETHRZONE_CMD                 (0x35, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETHRMAX_CMD                  (0x36, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETCHANNELRANGE_CMD           (0x40, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETVOLUMERANGE_CMD            (0x41, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETAUDIOMUTE_CMD              (0x42, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETAUDIOCHANNEL_CMD           (0x43, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETAUDIOVOLUME_CMD            (0x44, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_STARTTEXT_CMD                 (0x60, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_APPENDTEXT_CMD                (0x61, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETTEXTSTATUS_CMD             (0x65, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_GETCAPS_CMD                   (0x70, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_SETPMCFG_CMD                  (0x76, {}),
  CSAFE_SETPMDATA_CMD                 (0x77, {}),
  CSAFE_GETPMCFG_CMD                  (0x7E, {}),
  CSAFE_GETPMDATA_CMD                 (0x7F, {});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PUBLIC_LONG_CMDS(this.id, this.fields);
}
/// C2 Proprietary Short Commands
/// page: 49 & 50
///
enum CSAFE_PROPRIETARY_SHORT_CMDS {
  CSAFE_PM_GET_WORKOUTTYPE            (0x89, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTSTATE           (0x8D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_INTERVALTYPE           (0x8E, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTINTERVALCOUNT   (0x9F, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKTIME               (0xA0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKDISTANCE           (0xA3, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERRORVALUE2            (0xC9, {"buffer": FrameFieldType.VAR_BUFF}),
  SAFE_PM_GET_RESTTIME                (0xCF, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROPRIETARY_SHORT_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Commands
/// Page: 50
///
enum CSAFE_PROPRIETARY_LONG_CMDS {
  CSAFE_PM_SET_SPLITDURATION          (0x05, null),
  CSAFE_PM_GET_FORCEPLOTDATA          (0x6B, null),
  CSAFE_PM_SET_SCREENERRORMODE        (0x27, null),
  CSAFE_PM_GET_HEARTBEATDATA          (0x6C, null);
  final int id;
  final Map<String, FrameFieldType>?fields;
  const CSAFE_PROPRIETARY_LONG_CMDS(this.id, this.fields);
}


/// C2 Proprietary Short Get Configuration Commands
/// Page: 54
///
///

enum CSAFE_PROP_SHORT_GET_CONF_CMDS {
  CSAFE_PM_GET_FW_VERSION                       (0x80, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HW_VERSION                       (0x81, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HW_ADDRESS                       (0x82, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TICK_TIMEBASE                    (0x83, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HRM                              (0x84, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DATETIME                         (0x85, {"hours": FrameFieldType.INT, "minutes": FrameFieldType.INT, "meridiem": FrameFieldType.INT, "month": FrameFieldType.INT, "day": FrameFieldType.INT, "year": FrameFieldType.INT2}),
  CSAFE_PM_GET_SCREENSTATESTATUS                (0x86, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACE_LANE_REQUEST                (0x87, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACE_ENTRY_REQUEST               (0x88, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTTYPE                      (0x89, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DISPLAYTYPE                      (0x8A, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DISPLAYUNITS                     (0x8B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LANGUAGETYPE                     (0x8C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTSTATE                     (0x8D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_INTERVALTYPE                     (0x8E, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_OPERATIONALSTATE                 (0x8F, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LOGCARDSTATE                     (0x90, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LOGCARDSTATUS                    (0x91, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_POWERUPSTATE                     (0x92, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ROWINGSTATE                      (0x93, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SCREENCONTENT_VERSION            (0x94, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_COMMUNICATIONSTATE               (0x95, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACEPARTICIPANTCOUNT             (0x96, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_BATTERYLEVELPERCENT              (0x97, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACEMODESTATUS                   (0x98, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_INTERNALLOGPARAMS                (0x99, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_PRODUCTCONFIGURATION             (0x9A, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERGSLAVEDISCOVERREQUESTSTATUS    (0x9B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WIFICONFIG                       (0x9C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_CPUTICKRATE                      (0x9D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LOGCARDUSERCENSUS                (0x9E, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTINTERVALCOUNT             (0x9F, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOUTDURATION                  (0xE8, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKOTHER                        (0xE9, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_EXTENDED_HRM                     (0xEA, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DEFCALIBRATIONVERFIED            (0xEB, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_FLYWHEELSPEED                    (0xEC, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERGMACHINETYPE                   (0xED, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACE_BEGINEND_TICKCOUNT          (0xEE, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_PM5_FWUPDATESTATUS               (0xEF, {"buffer": FrameFieldType.VAR_BUFF});

  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_SHORT_GET_CONF_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Get Configuration Commands
/// Page: 57
///
enum CSAFE_PROP_LONG_GET_CONF_CMDS {
  CSAFE_PM_GET_ERG_NUMBER                       (0x50, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERGNUMBERREQUE                   (0x51, {"buffer": FrameFieldType.VAR_BUFF}),
  TCSAFE_PM_GET_USERIDSTRING                    (0x52, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LOCALRACEPARTICIPANT             (0x53, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_USER_ID                          (0x54, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_USER_PROFILE                     (0x55, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HRBELT_INFO                      (0x56, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_EXTENDED_HRBELT_INFO             (0x57, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_CURRENT_LOG_STRUCTURE            (0x58, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_LONG_GET_CONF_CMDS(this.id, this.fields);
}

/// C2 Proprietary Short Get Data Commands
/// Page: 59
///
enum CSAFE_PROP_SHORT_GET_DATA_CMDS {
  CSAFE_PM_GET_WORKTIME                         (0xA0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_PROJECTED_WORKTIME               (0xA1, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_RESTTIME                   (0xA2, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_WORKDISTANCE                     (0xA3, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_WORKDISTANCE               (0xA4, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_PROJECTED_WORKDISTANCE           (0xA5, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RESTDISTANCE                     (0xA6, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_RESTDISTANCE               (0xA7, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKE_500M_PACE                 (0xA8, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKE_POWER                     (0xA9, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKE_CALORICBURNRATE           (0xAA, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLIT_AVG_500M_PACE              (0xAB, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLIT_AVG_POWER                  (0xAC, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLIT_AVG_CALORICBURNRATE        (0xAD, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLIT_AVG_CALORIES               (0xAE, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_AVG_500MPACE               (0xAF, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_AVG_POWER                  (0xB0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_AVG_CALORICBURNRATE        (0xB1, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_AVG_CALORIES               (0xB2, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKE_RATE                      (0xB3, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLIT_AVG_STROKERATE             (0xB4, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TOTAL_AVG_STROKERATE             (0xB5, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_AVG_HEART_RATE                   (0xB6, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ENDING_AVG_HEARTRATE             (0xB7, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_REST_AVG_HEARTRATE               (0xB8, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLITTIME                        (0xB9, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LAST_SPLITTIME                   (0xBA, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SPLITDISTANCE                    (0xBB, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LAST_SPLITDISTANCE               (0xBC, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LAST_RESTDISTANCE                (0xBD, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TARGETPACETIME                   (0xBE, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKESTATE                      (0xBF, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKERATESTATE                  (0xC0, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DRAGFACTOR                       (0xC1, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ENCODER_PERIOD                   (0xC2, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HEARTRATESTATE                   (0xC3, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SYNC_DATA                        (0xC4, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SYNCDATAALL                      (0xC5, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RACE_DATA                        (0xC6, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_TICK_TIME                        (0xC7, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERRORTYPE                        (0xC8, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_ERRORVALUE                       (0xC9, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STATUSTYPE                       (0xCA, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STATUSVALUE                      (0xCB, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_EPMSTATUS                        (0xCC, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DISPLAYUPDATETIME                (0xCD, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_SYNCFRACTIONALTIME               (0xCE, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_RESTTIME                         (0xCF, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_SHORT_GET_DATA_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Get Data Commands
/// Page: 62
///
enum CSAFE_PROP_LONG_GET_DATA_CMDS {
  CSAFE_PM_GET_MEMORY                           (0x68, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_LOGCARD_MEMORY                   (0x69, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_INTERNALLOGMEMORY                (0x6A, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_FORCEPLOTDATA                    (0x6B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_HEARTBEATDATA                    (0x6C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_UI_EVENTS                        (0x6D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_STROKESTATS                      (0x6E, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DIAGLOG_RECORD_NUM               (0x70, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_DIAGLOG_RECORD                   (0x71, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_GET_CURRENT_WORKOUT_HASH             (0x72, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_LONG_GET_DATA_CMDS(this.id, this.fields);
}
/// C2 Proprietary Short Set Configuration Commands
/// Page: 65
///
enum CSAFE_PROP_SHORT_SET_CONFIG_CMDS {
  CSAFE_PM_SET_RESET_ALL                       (0xE0, {}),
  CSAFE_PM_SET_RESET_ERG_NUMBER                (0xE1, {});

  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_SHORT_SET_CONFIG_CMDS(this.id, this.fields);
}

/// C2 Proprietary Short Set Configuration Commands
/// Page: 65
///
enum CSAFE_PROP_SHORT_SET_DATA_CMDS {
  CSAFE_PM_SET_SYNC_DISTANCE                    (0xD0, {}),
  CSAFE_PM_SET_SYNC_STROKE_PACE                 (0xD1, {}),
  CSAFE_PM_SET_SYNC_AVG_HEARTRATE               (0xD2, {}),
  CSAFE_PM_SET_SYNC_TIME                        (0xD3, {}),
  CSAFE_PM_SET_SYNC_SPLIT_DATA                  (0xD4, {}),
  CSAFE_PM_SET_SYNC_ENCODER_PERIOD              (0xD5, {}),
  CSAFE_PM_SET_SYNC_VERSION_INFO                (0xD6, {}),
  CSAFE_PM_SET_SYNC_RACETICKTIME                (0xD7, {}),
  CSAFE_PM_SET_SYNC_DATAALL                     (0xD8, {}),
  CSAFE_PM_SET_SYNC_ROWINGACTIVE_TIME           (0xD9, {});

  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_SHORT_SET_DATA_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Set Configuration Commands
/// Page: 65
///
enum CSAFE_PROP_LONG_SET_CONFIG_CMDS {
  CSAFE_PM_SET_BAUDRATE                        (0x00, {}),
  CSAFE_PM_SET_WORKOUTTYPE                     (0x01, {}),
  CSAFE_PM_SET_STARTTYPE                       (0x02, {}),
  CSAFE_PM_SET_WORKOUTDURATION                 (0x03, {}),
  CSAFE_PM_SET_RESTDURATION                    (0x04, {}),
  CSAFE_PM_SET_SPLITDURATION                   (0x05, {}),
  CSAFE_PM_SET_TARGETPACETIME                  (0x06, {}),
  CSAFE_PM_SET_INTERVALIDENTIFIER              (0x07, {}),
  CSAFE_PM_SET_OPERATIONALSTATE                (0x08, {}),
  CSAFE_PM_SET_RACETYPE                        (0x09, {}),
  CSAFE_PM_SET_WARMUPDURATION                  (0x0A, {}),
  CSAFE_PM_SET_RACELANESETUP                   (0x0B, {}),
  CSAFE_PM_SET_RACELANEVERIFY                  (0x0C, {}),
  CSAFE_PM_SET_RACESTARTPARAMS                 (0x0D, {}),
  CSAFE_PM_SET_ERGSLAVEDISCOVERYREQUEST        (0x0E, {}),
  CSAFE_PM_SET_BOATNUMBER                      (0x0F, {}),
  CSAFE_PM_SET_ERGNUMBER                       (0x10, {}),
  CSAFE_PM_SET_COMMUNICATIONSTATE              (0x11, {}),
  CSAFE_PM_SET_CMDUPLIST                       (0x12, {}),
  CSAFE_PM_SET_SCREENSTATE                     (0x13, {}),
  CSAFE_PM_CONFIGURE_WORKOUT                   (0x14, {}),
  CSAFE_PM_SET_TARGETAVGWATTS                  (0x15, {}),
  CSAFE_PM_SET_TARGETCALSPERHR                 (0x16, {}),
  CSAFE_PM_SET_INTERVALTYPE                    (0x17, {}),
  CSAFE_PM_SET_WORKOUTINTERVALCOUNT            (0x18, {}),
  CSAFE_PM_SET_DISPLAYUPDATERATE               (0x19, {}),
  CSAFE_PM_SET_AUTHENPASSWORD                  (0x1A, {}),
  CSAFE_PM_SET_TICKTIME                        (0x1B, {}),
  CSAFE_PM_SET_TICKTIMEOFFSET                  (0x1C, {}),
  CSAFE_PM_SET_RACEDATASAMPLETICKS             (0x1D, {}),
  CSAFE_PM_SET_RACEOPERATIONTYPE               (0x1E, {}),
  CSAFE_PM_SET_RACESTATUSDISPLAYTICKS          (0x1F, {}),
  CSAFE_PM_SET_RACESTATUSWARNINGTICKS          (0x20, {}),
  CSAFE_PM_SET_RACEIDLEMODEPARMS               (0x22, {}),
  CSAFE_PM_SET_DATETIME                        (0x23, {}),
  CSAFE_PM_SET_LANGUAGETYPE                    (0x24, {}),
  CSAFE_PM_SET_WIFICONFIG                      (0x25, {}),
  CSAFE_PM_SET_CPUTICKRATE                     (0x26, {}),
  CSAFE_PM_SET_LOGCARDUSER                     (0x27, {}),
  CSAFE_PM_SET_SCREENERRORMODE                 (0x28, {}),
  CSAFE_PM_SET_CABLETEST                       (0x29, {}),
  CSAFE_PM_SET_USER_ID                         (0x2A, {}),
  CSAFE_PM_SET_USER_PROFILE                    (0x2B, {}),
  CSAFE_PM_SET_HRM                             (0x2C, {}),
  CSAFE_PM_SET_RACESTARTINGPHYSCALADDRESS      (0x21, {}),
  CSAFE_PM_SET_HRBELT_INFO                     (0x2D, {}),
  CSAFE_PM_SET_SENSOR_CHANNEL                  (0x2F, {});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_LONG_SET_CONFIG_CMDS(this.id, this.fields);
}

/// C2 Proprietary Long Set Data Commands
/// Page: 69
///
enum CSAFE_PROP_LONG_SET_DATA_CMDS {
  CSAFE_PM_SET_TEAM_DISTANCE                   (0x30, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_TEAM_FINISH_TIME                (0x31, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_RACEPARTICIPANT                 (0x32, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_RACESTATUS                      (0x33, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_LOGCARD_MEMORY                  (0x34, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_DISPLAYSTRING                   (0x35, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_DISPLAYBITMAP                   (0x36, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_LOCALRACEPARTICIPANT            (0x37, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_GAMEPARAMS                      (0x38, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_EXTENDED_HRBELT_INFO            (0x39, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_EXTENDED_HRM                    (0x3A, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_LEDBACKLIGHT                    (0x3B, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_DIAGLOG_RECORD_ARCHIVE          (0x3C, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_WIRELESS_CHANNEL_CONFIG         (0x3D, {"buffer": FrameFieldType.VAR_BUFF}),
  CSAFE_PM_SET_RACECONTROLPARAMS               (0x3E, {"buffer": FrameFieldType.VAR_BUFF});
  final int id;
  final Map<String, FrameFieldType>fields;
  const CSAFE_PROP_LONG_SET_DATA_CMDS(this.id, this.fields);
}

enum STATE_MACHINE_STATE {
  Error           (0x00, "Error"),
  Ready           (0x01, "Ready"),
  Idle            (0x02, "Idle"),
  HaveID          (0x03, "Have ID"),
  InUse           (0x05, "In Use"),
  Pause           (0x06, "Pause"),
  Finish          (0x07, "Finish"),
  Manual          (0x08, "Manual"),
  Offline         (0x09, "Off line");
  final int id;
  final String text;
  const STATE_MACHINE_STATE(this.id, this.text);
  static fromInt(int v) => STATE_MACHINE_STATE.values.firstWhere((e) => (e.id == (v & 0x0F)));
}

enum PREVIOUS_FRAME_STATUS {
  Ok             (0x00, "Ok"),
  Reject         (0x00, "Reject"),
  Bad            (0x00, "Bad"),
  NotReady       (0x00, "Not Ready");
  final int id;
  final String text;
  const PREVIOUS_FRAME_STATUS(this.id, this.text);
  static fromInt(int v) => PREVIOUS_FRAME_STATUS.values.firstWhere((e) => (e.id == (v & 0x30)));
}

enum ADDRESS_TEXT {
  Master   (0x00, "Master"),
  Slave    (0x01, "Slave");

  final int id;
  final String text;
  const ADDRESS_TEXT(this.id, this.text);
  static fromInt(int v) => v == 0x00 ? Master : Slave;
}

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

  // @formatter:on
  final int id;

  const RACE_TYPE(this.id);
}
// @formatter:on
