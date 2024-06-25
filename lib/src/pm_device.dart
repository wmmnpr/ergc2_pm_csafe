import 'dart:async';

import 'package:ergc2_pm_csafe/src/models/data_conv_utils.dart';
import 'package:ergc2_pm_csafe/src/models/pm_data.dart';
import 'package:logging/logging.dart';

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
  final log = Logger('PmBLEDevice');

  Map<int, PmBleCharacteristic> characteristics;

  PmBLEDevice(this.characteristics);

  Stream<T> subscribe<T extends PmData<T>>(int uuid) {
    log.info('subscribing to characteristic: $uuid');
    StreamController<IntList> deviceStream = StreamController<IntList>();
    StreamController<T> clientStream = StreamController<T>();
    characteristics[uuid]!.listen(deviceStream.sink);
    deviceStream.stream.listen((event) {
      clientStream.add(characteristics[uuid]!.create().from(event));
    }, onDone: () {
      log.info('closing characteristic: $uuid');
      clientStream.close();
    }, onError: (err) {
      log.warning('error characteristic: $uuid: $err');
      clientStream.addError(err);
    });
    return clientStream.stream;
  }

  Future<void> sendCommand(int uuid, IntList command,
      [String message = "NONE"]) async {
    IntList csafeBuffer = DataConvUtils.toCsafe(command);
    if (log.isLoggable(Level.ALL)) {
      log.info(
          'sending csafe command: ${DataConvUtils.intArrayToHex(csafeBuffer)}');
    }
    return characteristics[uuid]!.writeCsafe(csafeBuffer);
  }

  Future<IntList> readCharacteristic(int uuid) async {
    log.info('reading characteristic: $uuid');
    return characteristics[uuid]!.readCsafe();
  }
}
