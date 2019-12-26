import 'package:polyline/polyline.dart';

void main() {
  List<List<double>> decoded;
  var encoded = 'mxhmEfeyaO}w}F_aeTrxk[nabDv}lJsytA';
  const precision = 5;

  /// Create an instance of [Polyline]
  var polylineDecoded = Polyline.Decode(encodedString: encoded, precision: precision);
  var polylineEncoded = Polyline;


  decoded = polylineDecoded.decoded_coordinates;
  print('Decoded coordinates: $decoded'); // Decoded coordinates: [[33.80119, -84.34788], [35.10566, -80.8762], [30.4526, -81.71116], [28.57888, -81.2717]]
}


