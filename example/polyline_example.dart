import 'package:polyline/polyline.dart';

void main() {
  Polyline polyline;
  const coordinates = [
    [33.80119, -84.34788],
    [35.10566, -80.8762],
    [30.4526, -81.71116],
    [28.57888, -81.2717]
  ];
  const precision = 5;
  const encoded = 'mxhmEfeyaO}w}F_aeTrxk[nabDv}lJsytA';

  // Encode a list of coordinates with precision 5 to produce the encoded string
  polyline = Polyline.Encode(
      decodedCoords: coordinates,
      precision: 5
  );
  print('Encoded String: ${polyline.encodedString}');
  print('Coords: ${polyline.decodedCoords}');

  // Decode an encoded string to a list of coordinates
  polyline = Polyline.Decode(
      encodedString: encoded,
      precision: precision
  );
  print('Decoded Coords: ${polyline.decodedCoords}');
  print('String: ${polyline.encodedString}');

}