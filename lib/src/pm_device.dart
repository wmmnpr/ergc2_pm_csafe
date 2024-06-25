import 'dart:async';

import 'package:ergc2_pm_csafe/src/models/data_conv_utils.dart';
import 'package:ergc2_pm_csafe/src/models/pm_data.dart';

abstract class PmBleCharacteristic<T> {
  void listen(StreamSink sink) {
    throw UnimplementedError();
  }

  Future<void> writeCsafe(IntList command) async {
    throw UnimplementedError();
  }

  Future<IntList> readCsafe() async {
    throw UnimplementedError();
  }

  T create() {
    throw UnimplementedError();
  }
}

class PmBLEDevice {
  Map<int, PmBleCharacteristic> characteristics;

  PmBLEDevice(this.characteristics);

  Stream<T> subscribe<T extends PmData<T>>(int uuid) {
    StreamController<IntList> deviceStream = StreamController<IntList>();
    StreamController<T> clientStream = StreamController<T>();
    characteristics[uuid]!.listen(deviceStream.sink);
    deviceStream.stream.listen((event) {
      clientStream.add(characteristics[uuid]!.create().from(event));
    }, onDone: () {
      clientStream.close();
    }, onError: (err) {
      clientStream.addError(err);
    });
    return clientStream.stream;
  }

  Future<void> sendCommand(int uuid, IntList command,
      [String message = "NONE"]) async {
    print(message);
    IntList csafeBuffer = DataConvUtils.toCsafe(command);
    return characteristics[uuid]!.writeCsafe(csafeBuffer);
  }

  Future<IntList> readCharacteristic(int uuid) async {
    return characteristics[uuid]!.readCsafe();
  }
}
