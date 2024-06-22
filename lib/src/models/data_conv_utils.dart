import '../../ergc2_pm_csafe.dart';

class DataConvUtils {
  static int getUint8(List<int> data, int offset) {
    return data[offset];
  }

  static int getUint16(List<int> data, int offset) {
    return data[offset + 1] << 8 + data[offset];
  }

  static int getUint24(List<int> data, int offset) {
    return (data[offset + 2] << 16) + (data[offset + 1] << 8) + (data[offset]);
  }

  static int checksum(List<int> content) {
    int checksum = 0;
    for (int i = 0; i < content.length; i++) {
      checksum ^= content[i];
    }
    return checksum;
  }

  static String intArrayToHex(List<int> intArray) {
    for (var value in intArray) {
      if (value < 0 || value > 255) {
        throw ArgumentError('All integers must be in the range 0-255.');
      }
    }

    // Convert each integer to a two-character hex string and concatenate them
    final hexStringBuffer = StringBuffer();
    for (var value in intArray) {
      hexStringBuffer.write(value.toRadixString(16).padLeft(2, '0'));
    }
    return hexStringBuffer.toString();
  }

  static IntList hexStringToIntArray(String hex) {
    // Ensure the string length is even
    if (hex.length % 2 != 0) {
      throw FormatException('Hex string must have an even length');
    }
    // Initialize an empty list to store the integers
    IntList intArray = [];
    // Loop through the hex string, taking 2 characters at a time
    for (int i = 0; i < hex.length; i += 2) {
      // Get the hex substring (2 characters)
      String hexPair = hex.substring(i, i + 2);
      // Convert the hex pair to an integer and add to the list
      int value = int.parse(hexPair, radix: 16);
      intArray.add(value);
    }
    return intArray;
  }

  static IntList toCsafe(IntList command) {
    IntList csafeBuffer = IntList.empty(growable: true);
    int checksum = 0;
    for (int i = 0; i < command.length; i++) {
      checksum ^= command[i];
    }
    for (int i = 0; i < command.length; i++) {
      int value = command[i];
      if (value >= 0xF0 && value <= 0xF3) {
        csafeBuffer.add(0xF3);
        csafeBuffer.add(value - 0xF0);
      } else {
        csafeBuffer.add(value);
      }
    }
    csafeBuffer.insert(0, 0xF1);
    csafeBuffer.add(checksum);
    csafeBuffer.add(0xF2);

    return csafeBuffer;
  }
}
