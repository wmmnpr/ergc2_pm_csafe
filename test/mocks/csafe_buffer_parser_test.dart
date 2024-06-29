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
      //"f0:00:fd:81:7e:09:85:07:0a:25:01:06:07:07:e8:b4:f2",
      "f1:81:76:05:01:03:05:14:13:f3:02:f2",
      //"f0:fd:00:76:09:22:07:0a:26:01:06:07:07:e8:99:f2"
    ];
      // @formatter:on
      for (int i = 0; i < csafeList.length; i++) {
        IntList response = DataConvUtils.hexStringToIntArray(csafeList[i].stripCommnad());
        Map<String, Object>mappedResponse = CsafeBufferParser.parseResponse(response);
        print(mappedResponse.toString());

      }
    });
  });
}