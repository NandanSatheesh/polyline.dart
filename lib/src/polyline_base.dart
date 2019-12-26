import 'dart:math';

/// Checks if you are awesome. Spoiler: you are.
class Polyline {
  bool get isAwesome => true;
  String encodedString;
  List<List<double>> decodedCoords = [];
  int precision;

  /// .Decode(str, p) named constructor
  Polyline.Decode({this.encodedString, this.precision}) {
    decodedCoords = _decode(encodedString, precision);
    encodedString = encodedString;
  }

  /// .Encode(coords, p) named constructor
  Polyline.Encode({this.decodedCoords, this.precision}) {
    encodedString = encode_poly(decodedCoords, precision);
    decodedCoords = decodedCoords;
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

    decodedCoords = coordinates;
    return coordinates;
  }

  /// Encodes the given [latitude, longitude] coordinates list to an encoded string.
  /// @encode_poly Function
  /// @param {List<dynamic>} coordinates
  /// @param {int} precision
  /// @returns {String}
  String encode_poly(List<List<double>> coordinates, int precision) {
    if (coordinates.length == null) {
      return '';
    }

    int factor = pow(10, precision is int ? precision : 5);
    var output = _encode(coordinates[0][0], 0, factor) +
        _encode(coordinates[0][1], 0, factor);

    for (var i = 1; i < coordinates.length; i++) {
      var a = coordinates[i], b = coordinates[i - 1];
      output += _encode(a[0], b[0], factor);
      output += _encode(a[1], b[1], factor);
    }

    return output;
  }

  /// Returns the character string
  /// @param {double} current
  /// @param {double} previous
  /// @param {int} factor
  /// @returns {String}
  String _encode(double current, double previous, int factor) {
    final _current = (current * factor).round();
    final _previous = (previous * factor).round();

    var coordinate = _current - _previous;
    coordinate <<= 1;
    if (_current - _previous < 0) {
      coordinate = ~coordinate;
    }

    var output = '';
    while (coordinate >= 0x20) {
      output += String.fromCharCode((0x20 | (coordinate & 0x1f)) + 63);
      coordinate >>= 5;
    }
    output += String.fromCharCode(coordinate + 63);
    return output;
  }
}
