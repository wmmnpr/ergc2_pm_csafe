import '../../ergc2_pm_csafe.dart';

class CsafeBuffer extends PmData<CsafeBuffer> {
  List<int> buffer = [];

  @override
  CsafeBuffer from(List<int> intList) {
    this.buffer = intList;
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {'buffer': DataConvUtils.intArrayToHex(buffer)};
  }
}
