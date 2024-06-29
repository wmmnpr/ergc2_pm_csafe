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

/* Standard Short Control Commands */
enum CSAFE_SHORT_CTRL_CMDS {
  CSAFE_GETSTATUS_CMD(CSAFE_GETPMCFG_CMD_SHORT_MIN),       // 0x80
  CSAFE_RESET_CMD(0x81),                                   // 0x81
  CSAFE_GOIDLE_CMD(0x82),                                  // 0x82
  CSAFE_GOHAVEID_CMD(0x83),                                // 0x83
  CSAFE_GOINUSE_CMD(0x85),                                 // 0x85
  CSAFE_GOFINISHED_CMD(0x86),                              // 0x86
  CSAFE_GOREADY_CMD(0x87),                                 // 0x87
  CSAFE_BADID_CMD(0x88),                                   // 0x88
  CSAFE_CTRL_CMD_SHORT_MAX(0x89);
  final int value;
  const CSAFE_SHORT_CTRL_CMDS(this.value);
}


/*
    Custom Long PULL Data Commands for PM
*/
enum CSAFE_PM_LONG_PULL_DATA_CMDS {
  CSAFE_PM_GET_MEMORY            (CSAFE_GETPMDATA_CMD_LONG_MIN),  // 0x68
  CSAFE_PM_GET_LOGCARDMEMORY     (CSAFE_GETPMDATA_CMD_LONG_MIN+1),// 0x69
  CSAFE_PM_GET_INTERNALLOGMEMORY (CSAFE_GETPMDATA_CMD_LONG_MIN+2),// 0x6A
  CSAFE_PM_GET_FORCEPLOTDATA     (CSAFE_GETPMDATA_CMD_LONG_MIN+3),// 0x6B
  CSAFE_PM_GET_HEARTBEATDATA     (CSAFE_GETPMDATA_CMD_LONG_MIN+4),// 0x6C
  CSAFE_PM_GET_UI_EVENTS         (CSAFE_GETPMDATA_CMD_LONG_MIN+5),// 0x6D
  // Unused,                                                      // 0x6E
  // Unused,                                                      // 0x6F
  // Unused,                                                      // 0x70
  // Unused,                                                      // 0x71
  // Unused,                                                      // 0x72
  // Unused,                                                      // 0x73
  // Unused,                                                      // 0x74
  // Unused,                                                      // 0x75
  // Command Wrapper,                                             // 0x76
  // Command Wrapper,                                             // 0x77
  // Unused,                                                      // 0x78
  // Unused,                                                      // 0x79
  // Unused,                                                      // 0x7A
  // Unused,                                                      // 0x7B
  // Unused,                                                      // 0x7C
  // Unused,                                                      // 0x7D
  // Command Wrapper,                                             // 0x7E
  // Command Wrapper,                                             // 0x7F
  CSAFE_GETPMDATA_CMD_LONG_MAX    (CSAFE_GETPMDATA_CMD_LONG_MIN+24);
  final int value;
  const CSAFE_PM_LONG_PULL_DATA_CMDS(this.value);
}

enum CSAFE_LONG_CAP_CMDS {
  CSAFE_GETCAPS_CMD(CSAFE_CAP_CMD_LONG_MIN),            // 0x70
  CSAFE_GETUSERCAPS1_CMD(0x7E),                         // 0x7E
  CSAFE_GETUSERCAPS2_CMD(0x7F),                         // 0x7F
  CSAFE_CAP_CMD_LONG_MAX(0x7F + 1);
  final int value;
  const CSAFE_LONG_CAP_CMDS(this.value);
}

enum CSAFE_LONG_PMPROPRIETARY_CMDS {
  CSAFE_SETPMCFG_CMD(0x76),
  CSAFE_SETPMDATA_CMD(0x77),                                // 0x77
  CSAFE_GETPMCFG_CMD(0x7E),                          // 0x7E
  CSAFE_GETPMDATA_CMD(0x7F),                                // 0x7F
  CSAFE_PMPROPRIETARY_CMD_LONG_MAX(0x7F+1);
  final int value;
  const CSAFE_LONG_PMPROPRIETARY_CMDS(this.value);
}

/*
    Custom Long PUSH Configuration Commands for PM
*/
enum CSAFE_PM_LONG_PUSH_CFG_CMDS {
  CSAFE_PM_SET_BAUDRATE,                                          // 0x00
  CSAFE_PM_SET_WORKOUTTYPE,                                       // 0x01
  CSAFE_PM_SET_STARTTYPE,                                         // 0x02
  CSAFE_PM_SET_WORKOUTDURATION,                                   // 0x03
  CSAFE_PM_SET_RESTDURATION,                                      // 0x04
  CSAFE_PM_SET_SPLITDURATION,                                     // 0x05
  CSAFE_PM_SET_TARGETPACETIME,                                    // 0x06
  CSAFE_PM_SET_INTERVALIDENTIFIER,                                // 0x07
  CSAFE_PM_SET_OPERATIONALSTATE,                                  // 0x08
  CSAFE_PM_SET_RACETYPE,                                          // 0x09
  CSAFE_PM_SET_WARMUPDURATION,                                    // 0x0A
  CSAFE_PM_SET_RACELANESETUP,                                     // 0x0B
  CSAFE_PM_SET_RACELANEVERIFY,                                    // 0x0C
  CSAFE_PM_SET_RACESTARTPARAMS,                                   // 0x0D
  CSAFE_PM_SET_ERGSLAVEDISCOVERYREQUEST,                          // 0x0E
  CSAFE_PM_SET_BOATNUMBER,                                        // 0x0F
  CSAFE_PM_SET_ERGNUMBER,                                         // 0x10
  CSAFE_PM_SET_COMMUNICATIONSTATE,                                // 0x11
  CSAFE_PM_SET_CMDUPLIST,                                         // 0x12
  CSAFE_PM_SET_SCREENSTATE,                                       // 0x13
  CSAFE_PM_CONFIGURE_WORKOUT,                                     // 0x14
  CSAFE_PM_SET_TARGETAVGWATTS,                                    // 0x15
  CSAFE_PM_SET_TARGETCALSPERHR,                                   // 0x16
  CSAFE_PM_SET_INTERVALTYPE,                                      // 0x17
  CSAFE_PM_SET_WORKOUTINTERVALCOUNT,                              // 0x18
  CSAFE_PM_SET_DISPLAYUPDATERATE,                                 // 0x19
  CSAFE_PM_SET_AUTHENPASSWORD,                                    // 0x1A
  CSAFE_PM_SET_TICKTIME,                                          // 0x1B
  CSAFE_PM_SET_TICKTIMEOFFSET,                                    // 0x1C
  CSAFE_PM_SET_RACEDATASAMPLETICKS,                               // 0x1D
  CSAFE_PM_SET_RACEOPERATIONTYPE,                                 // 0x1E
  CSAFE_PM_SET_RACESTATUSDISPLAYTICKS,                            // 0x1F
  CSAFE_PM_SET_RACESTATUSWARNINGTICKS,                            // 0x20
  CSAFE_PM_SET_RACEIDLEMODEPARAMS,                                // 0x21
  CSAFE_PM_SET_DATETIME,                                          // 0x22
  CSAFE_PM_SET_LANGUAGETYPE,                                      // 0x23
  CSAFE_PM_SET_WIFICONFIG,                                        // 0x24
  CSAFE_PM_SET_CPUTICKRATE,                                       // 0x25
  CSAFE_PM_SET_LOGCARDUSER,                                       // 0x26
  CSAFE_PM_SET_SCREENERRORMODE,                                   // 0x27
  CSAFE_PM_SET_CABLETEST,                                         // 0x28
  CSAFE_PM_SET_USER_ID,                                           // 0x29
  CSAFE_PM_SET_USER_PROFILE,                                      // 0x2A
  CSAFE_PM_SET_HRM,                                               // 0x2B
  // Unused,                                                      // 0x2C
  // Unused,                                                      // 0x2D
  // Unused,                                                      // 0x2E
  CSAFE_SETPMCFG_CMD_LONG_MAX
}

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
