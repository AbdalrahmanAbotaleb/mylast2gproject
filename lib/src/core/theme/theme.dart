import 'dart:ui';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
// String colorToHex(Color color) {
//   return '#' + color.value.toRadixString(16).padLeft(8, '0').substring(2);
// }
