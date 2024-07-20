import '../../ergc2_pm_csafe.dart';

typedef IntList = List<int>;

abstract class PmData<T> {
  T from(IntList intList) {
    throw UnimplementedError();
  }

  IntList to(IntList command) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson();
}

class CsafeBuffer extends PmData<CsafeBuffer> {
  List<int> buffer = [];

  @override
  CsafeBuffer from(List<int> intList) {
    buffer = intList;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'buffer': DataConvUtils.intArrayToHex(buffer)};
  }
}
