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
