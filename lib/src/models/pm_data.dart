
extension StringExtensions on String {
  String stripCommnad() {
    return this.replaceAll(":", "");
  }
}

abstract class PmData<T> {
  T from(List<int> intList);
}