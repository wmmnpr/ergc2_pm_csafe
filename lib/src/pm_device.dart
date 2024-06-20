import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:ergc2_pm_csafe/src/ergc2_pm_csafe_base.dart';
import 'package:hex/hex.dart';

abstract class BluetoothCharacteristic<T> {
  void listen(StreamSink sink);
  T create();

}

class StrokeDataCharacteristic extends BluetoothCharacteristic<StrokeData> {
  @override
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

  StrokeData create(){
    return StrokeData();
  }

  void listen(StreamSink sink) {
    int i = 0;
    void tick(Timer tock) {
      i++;
      sleep(const Duration(milliseconds: 1000));
      List<int> buffer =
          HEX.decode(hexDataList[i % hexDataList.length].stripCommnad());
      sink.add(buffer);
      int iso = Isolate.current.hashCode;
      if(i++ > 10){
        sink.close();
        tock.cancel();
      }
      print("producer: $i : $iso");
    }

    Timer.periodic(Duration(seconds: 1), tick);
  }
}

class PmBLEDevice {
  Map<int, BluetoothCharacteristic> characteristics = {
    0x33: StrokeDataCharacteristic()
  };

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
