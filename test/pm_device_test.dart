import 'dart:async';
import 'dart:isolate';

import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:ergc2_pm_csafe/src/pm_device.dart';
import 'package:test/test.dart';

void main() {
  group('data conversion', () {
    setUp(() {
      // Additional setup goes here.
    });
    test('test device', () {

      int callCount = 0;
      PmBLEDevice pm = PmBLEDevice();
      pm.subscribe<StrokeData>(0x33).listen((data) {
        callCount++;
        var jsonStr = data.toJson();
        print('${Isolate.current.hashCode} -> Received: $jsonStr');
      }, onError: (error) {
        print('${Isolate.current.hashCode} -> Error: $error');
      }, onDone: () {
        print('${Isolate.current.hashCode} -> Stream closed.');
      });
      int iso = Isolate.current.hashCode;
      print("just before end of main $iso");
      print("end of main $iso");

      expect(Completer().future.timeout(Duration(seconds: 15)),
          throwsA(isA<TimeoutException>()));
    });

    test('StrokeData test', () {});

    test('AdditionalStatus2 test', () {});
  });
}
