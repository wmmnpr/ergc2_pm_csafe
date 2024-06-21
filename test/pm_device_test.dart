import 'dart:async';
import 'dart:isolate';

import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:ergc2_pm_csafe/src/models/additional_status2.dart';
import 'package:ergc2_pm_csafe/src/models/stroke_data.dart';
import 'package:ergc2_pm_csafe/src/pm_device.dart';
import 'package:test/test.dart';

import 'mocks/mock_characteristics.dart';

void main() {
  group('data conversion', () {
    setUp(() {
      // Additional setup goes here.
    });
    test('StrokeData test', () {
      Map<int, BluetoothCharacteristic> characteristics = {
        StrokeData.uuid: StrokeDataCharacteristic(),
        AdditionalStatus2.uuid: AdditionalStatus2Characteristic()
      };

      int callCount = 0;
      PmBLEDevice pm = PmBLEDevice(characteristics);

      pm.subscribe<StrokeData>(StrokeData.uuid).listen((data) {
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

      expect(Completer().future.timeout(Duration(seconds: 5)),
          throwsA(isA<TimeoutException>()));
    });

    test('AdditionalStatus2 test', () {
      Map<int, BluetoothCharacteristic> characteristics = {
        StrokeData.uuid: StrokeDataCharacteristic(),
        AdditionalStatus2.uuid: AdditionalStatus2Characteristic()
      };

      int callCount = 0;
      PmBLEDevice pm = PmBLEDevice(characteristics);

      pm.subscribe<AdditionalStatus2>(AdditionalStatus2.uuid).listen((data) {
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

      expect(Completer().future.timeout(Duration(seconds: 5)),
          throwsA(isA<TimeoutException>()));
    });
  });
}
