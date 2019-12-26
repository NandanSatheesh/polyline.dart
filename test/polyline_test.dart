import 'package:polyline/polyline.dart';
import 'package:test/test.dart';

void main() {
  const decoded_coords = [
    [33.80119, -84.34788],
    [35.10566, -80.8762],
    [30.4526, -81.71116],
    [28.57888, -81.2717]
  ];
  const encoded_string = 'mxhmEfeyaO}w}F_aeTrxk[nabDv}lJsytA';

  group('Polyline.Decode', () {
    Polyline polyline;
    polyline = Polyline.Decode(encodedString: encoded_string, precision: 5);

    test('Decoded coordinates are equal to decoded encodedString', () {
      expect(polyline.decodedCoords, decoded_coords);
    });

    test('polyline.encodedString is same as passed in encodedString', () {
      expect(polyline.encodedString, encoded_string);
    });
  });

  group('Polyline.Encode', () {
    Polyline polyline;
    polyline = Polyline.Encode(decodedCoords: decoded_coords, precision: 5);

    test('polylineEncoded is equal to an encoded string', () {
      expect(polyline.encodedString, encoded_string);
    });

    test('polyline.decodedCoords are same as passed in decodedCoords', () {
      expect(polyline.decodedCoords, decoded_coords);
    });
  });
}
