![Pub](https://img.shields.io/pub/v/polyline)
<div style="text-align:center"><img height="89" src="./poly4PL.png" /></div>

# polyline.dart
Polyline encoding is a lossy compression algorithm that allows you to 
store a series of coordinates as a single string.

Polyline is a dart port of Google's Polyline Algorithm explained 
[here](https://developers.google.com/maps/documentation/utilities/polylinealgorithm).
Inspired by Mapbox's [polyline.js](https://github.com/mapbox/polyline).
Compatible with Dart 2.


# Installation 
Add ```polyline: ^1.0.1``` to your pubspec.yaml.
Then run:
```shell script
pub get # flutter pub get
```

# Usage

A simple usage example: <br>
Two named constructors are provided Polyline.Decode and Polyline.Encode. <br>

Calling Polyline.Encode will compute the ```encodedString``` and set the passed in coordinates
to ```decodedCoords``` on the instance of Polyline so that each instance of Polyline  has access to the  correct encoded string 
and subsequent decoded coordinates. Likewise, calling Polyline.Decode computes the list of coordinates from the
encoded string and sets the passed in encoded string to the instance of Polyline.

Note that a precision of 5 is standard.

```dart
import 'package:polyline/polyline.dart';

void main() {
  Polyline polyline;

  /// List<List<double> coordinates;
  const coordinates = [
    [33.80119, -84.34788],
    [35.10566, -80.8762],
    [30.4526, -81.71116],
    [28.57888, -81.2717]
  ];
  const precision = 5;
  const encoded = 'mxhmEfeyaO}w}F_aeTrxk[nabDv}lJsytA';

  // Encode a list of coordinates with precision 5 to produce the encoded string
  polyline = Polyline.Encode(decodedCoords: coordinates, precision: 5);
  print('Encoded String: ${polyline.encodedString}, Coords: ${polyline.decodedCoords}');

  // Decode an encoded string to a list of coordinates
  polyline = Polyline.Decode(encodedString: encoded, precision: precision);
  print('Decoded Coords: ${polyline.decodedCoords}');
  print('String: ${polyline.encodedString}');

  // Calculate the distance of an encoded polyline, and decode the polyline
  polyline =  Polyline.Distance(encodedString: encoded,  unit: 'kilometers');
  // By calling  length the encodedString, decodedCoords, and distance variables
  // of the Polyline class are available
  print('Distance: ${polyline.distance.floor()}km , Encoded String: ${polyline.encodedString} Decoded Coords: ${polyline.decodedCoords}');
```


See

## Documentation
Api Documentation

## Development 
Multiple flags for extended capabilities
* Todo add merge polylines
* Todo add merge multiple polylines
* Todo add from geoJson
* Todo add haversine
* Todo add haversine distance

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://github.com/sashvoncurtis/polyline.dart/issues/new