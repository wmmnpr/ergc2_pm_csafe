import 'dart:isolate';

void main() async {
  int iso = Isolate.current.hashCode;
  print("just before end of main $iso");
  print("end of main $iso");
}
