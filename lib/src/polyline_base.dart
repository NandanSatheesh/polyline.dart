import 'dart:math';

// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class Polyline {
  bool get isAwesome => true;
  String encodedString;
  List<List<double>> decoded_coordinates = [];
  int precision;

  /// .decode(str, p) named constructor
  Polyline.Decode({this.encodedString, this.precision}) {
    decoded_coordinates = _decode(encodedString, precision);
  }


  /// Decodes encoded polyline string to a [latitude, longitude] coordinates list.
  /// @decode_poly Function
  /// @param {String} str
  /// @param {int} precision
  /// @returns {List<dynamic>}
  List<List<double>> _decode(String str, int precision) {
    int index = 0,
        lat = 0,
        lng = 0,
        shift = 0,
        result = 0,
        byte,
        latitude_change,
        longitude_change,
        factor = pow(10, precision is int ? precision : 5);
    // ignore: omit_local_variable_types
    List<List<double>> coordinates = [];

    // Coordinates have variable length when encoded, so just keep
    // track of whether we've hit the end of the string. In each
    // loop iteration, a single coordinate is decoded.
    while (index < str.length) {

      // Reset shift, result, and byte
      byte = null;
      shift = 0;
      result = 0;

      do {
        byte = str.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);

      latitude_change = (((result & 1) == 1) ? ~(result >> 1) : (result >> 1));

      shift = result = 0;

      do {
        byte = str.codeUnitAt(index++) - 63;
        result |= (byte & 0x1f) << shift;
        shift += 5;
      } while (byte >= 0x20);

      longitude_change = ((result & 1) == 1 ? ~(result >> 1) : (result >> 1));

      lat += latitude_change;
      lng += longitude_change;

      coordinates.add([lat / factor, lng / factor]);
    }

    decoded_coordinates = coordinates;
    return coordinates;
  }



}
// cc 2019