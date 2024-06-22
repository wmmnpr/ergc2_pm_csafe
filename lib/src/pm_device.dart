import 'dart:async';

import 'package:ergc2_pm_csafe/src/models/pm_data.dart';

abstract class PmBleCharacteristic<T> {
  void listen(StreamSink sink);

  T create();
}

class PmBLEDevice {
  Map<int, PmBleCharacteristic> characteristics;

  PmBLEDevice(this.characteristics);

  Stream<T> subscribe<T extends PmData<T>>(int uuid) {
    StreamController<List<int>> deviceStream = StreamController<List<int>>();
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
}
