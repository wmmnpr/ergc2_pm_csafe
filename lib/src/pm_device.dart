import 'dart:async';

import 'package:ergc2_pm_csafe/src/models/pm_data.dart';

abstract class PmBleCharacteristic<T> {
  void listen(StreamSink sink) {
    throw UnimplementedError();
  }

  Future<void> writeCsafe(IntList command) async {
    throw UnimplementedError();
  }

  T create();
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

  Future<void> sendCommand(IntList command) async {
    List<int> buffer = List<int>.empty(growable: true);
    int checksum = 0;
    for (int i = 0; i < command.length; i++) {
      checksum ^= command[i];
    }
    for (int i = 0; i < command.length; i++) {
      int value = command[i];
      if (value >= 0xF0 && value <= 0xF3) {
        buffer.add(0xF3);
        buffer.add(value - 0xF0);
      } else {
        buffer.add(value);
      }
    }
    command.insert(0, 0xF1);
    command.add(checksum);
    command.add(0xF2);

    characteristics[0x21]!.writeCsafe(command);
  }
}
