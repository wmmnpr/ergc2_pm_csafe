import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:test/test.dart';

extension StringExtensions on String {
  String stripCommnad() {
    return replaceAll(":", "");
  }
}

void main() {
  group('data conversion', () {
    setUp(() {
      // Additional setup goes here.
    });
    test('Csafe conversion', () {
      // @formatter:off
    List<String> csafeList = [
      "F1:09:1A:03:BF:01:04:AA:F2",
      "f1:81:76:1A:18:01:17:03:04:06:14:18:17:03:04:06:14:18:17:03:04:06:14:18:17:03:04:06:14:13:ff:f2",
      //"f0:fd:00:76:09:22:07:0a:26:01:06:07:07:e8:99:f2", command
      "f18193010013f2",
      "f0:00:fd:81:7f:09:57:07:00:00:00:00:00:00:00:a7:f2",
      "f18176050103051413f302f2",
      "f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2",
      "F1811A009BF2",
      "f1:81:76:05:01:03:05:14:13:f3:02:f2",
      "f0:00:fd:89:7e:43:6a:41:40:95:03:00:10:19:b5:73:69:30:76:16:27:00:af:00:06:9c:be:96:00:00:00:00:f9:00:00:00:64:18:81:00:64:00:00:00:00:00:00:00:06:00:00:00:00:38:47:46:50:2f:e0:00:f9:00:18:8e:00:00:ff:00:00:00:00:00:00:d5:f2",
      "f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2",
      "f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2",
      "f1011a001bf2",
      //"f0:fd:00:76:09:22:07:0a:26:01:06:07:07:e8:99:f2", command. look at direction
      "f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2"
    ];
      // @formatter:on
      for (int i = 0; i < csafeList.length; i++) {
        try {
          CsafeFrameProcessor parser = CsafeFrameProcessor();
          print(csafeList[i]);
          String input = csafeList[i].stripCommnad().replaceAll(" ", "");
          IntList response = DataConvUtils.hexStringToIntArray(input);
          Map<String, Object> mappedResponse =
              parser.parseResponseFrame(response);
          print(mappedResponse.toString());
        } catch (ex) {
          print(ex);
        }
      }
    });
  });

  group('CSAFE Frame processing', () {
    setUp(() {
      // Additional setup goes here.
    });
    test('Frame processing ', () {
      List<String> frameContents = [
        "7e:09:85:07:0a:25:01:06:07:07:e8"
        //response f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2
      ];

      for (int i = 0; i < frameContents.length; i++) {
        try {
          IntList response = DataConvUtils.hexStringToIntArray(
              frameContents[i].stripCommnad());
          print(response);
        } catch (ex) {
          print(ex);
        }
      }
    });
  });
}