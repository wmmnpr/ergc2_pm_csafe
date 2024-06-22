import 'dart:async';
import 'dart:isolate';

import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:ergc2_pm_csafe/src/models/additional_status2.dart';
import 'package:test/test.dart';

import 'mocks/mock_characteristics.dart';

void main() {
  late Map<int, PmBleCharacteristic> characteristics;

  group('data conversion', () {
    setUp(() {
      characteristics = {
        StrokeData.uuid: StrokeDataCharacteristic(),
        AdditionalStatus2.uuid: AdditionalStatus2Characteristic(),
        CsafeWriteCharacteristic.uuid: CsafeWriteCharacteristic()
      };
    });
    test('StrokeData test', () {
      PmBLEDevice pm = PmBLEDevice(characteristics);
      pm.subscribe<StrokeData>(StrokeData.uuid).listen((data) {
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

      expect(Completer().future.timeout(Duration(seconds: 2)),
          throwsA(isA<TimeoutException>()));
    });

    test('AdditionalStatus2 test', () {
      PmBLEDevice pm = PmBLEDevice(characteristics);
      pm.subscribe<AdditionalStatus2>(AdditionalStatus2.uuid).listen((data) {
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

      expect(Completer().future.timeout(Duration(seconds: 2)),
          throwsA(isA<TimeoutException>()));
    });

    test('sendCommand test', () async {
      PmBLEDevice pm = PmBLEDevice(characteristics);
      pm.sendCommand([0x85]).whenComplete(() => print("done"));
    });
  });
}
