import 'dart:convert';

import 'package:ergc2_pm_csafe/src/models/additional_status2.dart';
import 'package:ergc2_pm_csafe/src/models/data_conv_utils.dart';
import 'package:ergc2_pm_csafe/src/models/stroke_data.dart';
import 'package:hex/hex.dart';
import 'package:test/test.dart';

import 'mocks/mock_characteristics.dart';

void main() {
  group('data conversion', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('multi checksum test', () {
      Map<int, String> tests = {
        0xcf: "7e:07:6a:05:00:06:9d:50:12:",
        163: "07:6a:05:00:06:9d:50",
        0x68: "1a:07:05:05:80:f4:01:00:00:"
      };
      for (var key in tests.keys) {
        String content = tests[key]!;
        List<int> payload =
            DataConvUtils.hexStringToIntArray(content.stripCommnad());
        expect(DataConvUtils.checksum(payload), key);
      }
    });

    test('StrokeData test', () {
      List<String> hexDataList = [
        "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00",
        "5f:00:00:1c:00:00:61:4f:00:00:e1:00:63:05:d9:03:00:00:01:00",
        "f3:00:00:4b:00:00:61:4f:8a:00:e1:00:63:05:d9:03:00:00:01:00",
        "44:01:00:6a:00:00:76:4c:8a:00:13:03:d3:06:4e:04:d8:09:02:00",
        "e3:01:00:a7:00:00:76:4c:92:00:13:03:d3:06:4e:04:d8:09:02:00",
        "2e:02:00:c6:00:00:76:42:92:00:8b:03:75:06:00:04:44:0f:03:00",
        "d6:02:00:09:01:00:76:42:9e:00:8b:03:75:06:00:04:44:0f:03:00",
        "22:03:00:29:01:00:79:43:9e:00:dd:03:e8:06:40:04:c7:11:04:00",
        "cd:03:00:6f:01:00:79:43:a1:00:dd:03:e8:06:40:04:c7:11:04:00",
        "17:04:00:90:01:00:79:41:a1:00:fe:03:4e:07:75:04:6c:13:05:00",
        "cb:04:00:da:01:00:79:41:aa:00:fe:03:4e:07:75:04:6c:13:05:00",
        "17:05:00:fb:01:00:7c:43:aa:00:34:04:f1:06:24:04:d6:14:06:00",
        "c8:05:00:44:02:00:7c:43:a5:00:34:04:f1:06:24:04:d6:14:06:00",
        "10:06:00:64:02:00:79:41:a5:00:13:04:c5:06:33:04:fc:13:07:00",
        "be:06:00:ab:02:00:79:41:a4:00:13:04:c5:06:33:04:fc:13:07:00",
        "07:07:00:ca:02:00:79:42:a4:00:0b:04:aa:06:0d:04:ae:13:08:00",
        "b6:07:00:11:03:00:79:42:a3:00:0b:04:aa:06:0d:04:ae:13:08:00",
        "00:08:00:32:03:00:79:42:a3:00:03:04:e9:06:38:04:5d:13:09:00",
        "b3:08:00:7a:03:00:79:42:a6:00:03:04:e9:06:38:04:5d:13:09:00",
        "fa:08:00:9a:03:00:7c:43:a6:00:1a:04:89:07:54:04:fc:13:0a:00",
        "b3:09:00:e6:03:00:7c:43:ab:00:1a:04:89:07:54:04:fc:13:0a:00",
      ];

      for (String hexData in hexDataList) {
        List<int> buffer = HEX.decode(hexData.stripCommnad());
        StrokeData strokeData = StrokeData().from(buffer);
        var jsonStrokeData = json.encode(strokeData.toJson());
        print(jsonStrokeData);
      }
    });

    test('AdditionalStatus2 test', () {
      List<String> hexDataList = [
        "2a:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00",
        "5b:00:00:00:41:00:00:00:a4:44:41:00:00:00:00:00:00:00:00:00",
        "8c:00:00:00:41:00:00:00:a4:44:41:00:00:00:00:00:00:00:00:00",
        "be:00:00:00:41:00:00:00:a4:44:41:00:00:00:00:00:00:00:00:00",
        "f0:00:00:00:41:00:00:00:a4:44:41:00:00:00:00:00:00:00:00:00",
        "24:01:00:00:41:00:00:00:a4:44:41:00:00:00:00:00:00:00:00:00",
        "57:01:00:00:60:00:00:00:33:3c:60:00:00:00:00:00:00:00:00:00",
        "88:01:00:00:60:00:00:00:33:3c:60:00:00:00:00:00:00:00:00:00",
        "ba:01:00:00:60:00:00:00:33:3c:60:00:00:00:00:00:00:00:00:00",
        "eb:01:00:00:60:00:00:00:33:3c:60:00:00:00:00:00:00:00:00:00",
        "1f:02:00:00:7c:00:01:00:4a:37:7c:00:01:00:00:00:00:00:00:00",
        "50:02:00:00:7c:00:01:00:4a:37:7c:00:01:00:00:00:00:00:00:00",
        "82:02:00:00:7c:00:01:00:4a:37:7c:00:01:00:00:00:00:00:00:00",
        "b3:02:00:00:7c:00:01:00:4a:37:7c:00:01:00:00:00:00:00:00:00",
        "e5:02:00:00:7c:00:01:00:4a:37:7c:00:01:00:00:00:00:00:00:00",
        "19:03:00:00:8d:00:01:00:e1:34:8d:00:01:00:00:00:00:00:00:00",
        "4a:03:00:00:8d:00:01:00:e1:34:8d:00:01:00:00:00:00:00:00:00",
        "7c:03:00:00:8d:00:01:00:e1:34:8d:00:01:00:00:00:00:00:00:00",
        "ad:03:00:00:8d:00:01:00:e1:34:8d:00:01:00:00:00:00:00:00:00",
        "e0:03:00:00:8d:00:01:00:e1:34:8d:00:01:00:00:00:00:00:00:00",
        "13:04:00:00:9b:00:02:00:51:33:9b:00:02:00:00:00:00:00:00:00",
        "45:04:00:00:9b:00:02:00:51:33:9b:00:02:00:00:00:00:00:00:00",
        "77:04:00:00:9b:00:02:00:51:33:9b:00:02:00:00:00:00:00:00:00",
        "a9:04:00:00:9b:00:02:00:51:33:9b:00:02:00:00:00:00:00:00:00",
        "d9:04:00:00:9b:00:02:00:51:33:9b:00:02:00:00:00:00:00:00:00",
        "0d:05:00:00:a4:00:03:00:45:32:a4:00:03:00:00:00:00:00:00:00",
        "3e:05:00:00:a4:00:03:00:45:32:a4:00:03:00:00:00:00:00:00:00",
        "70:05:00:00:a4:00:03:00:45:32:a4:00:03:00:00:00:00:00:00:00",
        "a2:05:00:00:a4:00:03:00:45:32:a4:00:03:00:00:00:00:00:00:00",
        "d4:05:00:00:a4:00:03:00:45:32:a4:00:03:00:00:00:00:00:00:00",
        "06:06:00:00:ab:00:03:00:a7:31:ab:00:03:00:00:00:00:00:00:00",
        "38:06:00:00:ab:00:03:00:a7:31:ab:00:03:00:00:00:00:00:00:00",
        "6a:06:00:00:ab:00:03:00:a7:31:ab:00:03:00:00:00:00:00:00:00",
        "9c:06:00:00:ab:00:03:00:a7:31:ab:00:03:00:00:00:00:00:00:00",
        "cf:06:00:00:ab:00:03:00:a7:31:ab:00:03:00:00:00:00:00:00:00",
        "01:07:00:00:af:00:04:00:3f:31:af:00:04:00:00:00:00:00:00:00",
        "33:07:00:00:af:00:04:00:3f:31:af:00:04:00:00:00:00:00:00:00",
        "63:07:00:00:af:00:04:00:3f:31:af:00:04:00:00:00:00:00:00:00",
        "96:07:00:00:af:00:04:00:3f:31:af:00:04:00:00:00:00:00:00:00",
        "c8:07:00:00:af:00:04:00:3f:31:af:00:04:00:00:00:00:00:00:00",
        "fb:07:00:00:b2:00:05:00:f9:30:b2:00:05:00:00:00:00:00:00:00",
        "2c:08:00:00:b2:00:05:00:f9:30:b2:00:05:00:00:00:00:00:00:00",
        "5e:08:00:00:b2:00:05:00:f9:30:b2:00:05:00:00:00:00:00:00:00",
        "91:08:00:00:b2:00:05:00:f9:30:b2:00:05:00:00:00:00:00:00:00",
        "c1:08:00:00:b2:00:05:00:f9:30:b2:00:05:00:00:00:00:00:00:00",
        "f4:08:00:00:b4:00:05:00:bb:30:b4:00:05:00:00:00:00:00:00:00",
        "27:09:00:00:b4:00:05:00:bb:30:b4:00:05:00:00:00:00:00:00:00",
        "59:09:00:00:b4:00:05:00:bb:30:b4:00:05:00:00:00:00:00:00:00",
        "8b:09:00:00:b4:00:05:00:bb:30:b4:00:05:00:00:00:00:00:00:00",
        "b7:09:00:01:b6:00:06:00:9a:30:b6:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b6:00:06:00:9a:30:b6:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b6:00:06:00:9a:30:b6:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
        "b9:09:00:01:b5:00:06:00:a4:30:b5:00:06:00:bc:09:00:00:00:00",
      ];

      for (String hexData in hexDataList) {
        List<int> buffer = HEX.decode(hexData.stripCommnad());
        AdditionalStatus2 additionalStatus2 = AdditionalStatus2().from(buffer);
        var jsonAdditionalStatus2 = json.encode(additionalStatus2.toJson());
        print(jsonAdditionalStatus2);
      }
    });
  });
}
