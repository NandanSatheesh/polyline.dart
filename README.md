![Pub](https://img.shields.io/pub/v/polyline) ![Dart](https://img.shields.io/badge/dart-2.2.0-orange)

<div style="text-align:center"><img height="89" src="./poly4PL.png" /></div>

# polyline.dart
Polyline encoding is a lossy compression algorithm that allows you to 
store a series of coordinates as a single string.

Polyline is a dart port of Google's Polyline Algorithm explained 
[here](https://developers.google.com/maps/documentation/utilities/polylinealgorithm).
Inspired by Mapbox's [polyline.js](https://github.com/mapbox/polyline).
Compatible with Dart 2.


# Installation 
Add ```polyline: ^1.0.2``` to your pubspec.yaml.
Then run:
```shell script
pub get # flutter pub get
```

# Usage

A simple usage example: <br>
Three named constructors are provided ```Polyline.Decode```, ```Polyline.Encode``` and ```Polyline.Distance```. <br>


## Constructors 
#### Polyline.Encode
Calling Polyline.Encode will compute the ```encodedString``` and set the passed in coordinates
to ```decodedCoords``` on the instance of Polyline so that each instance of Polyline  has access to the  correct encoded string and subsequent decoded coordinates. 
```dart
  Polyline polyline;
  polyline = Polyline.Encode(decodedCoords: coordinates, precision: precision);
```

#### Polyline.Decode
Likewise, calling Polyline.Decode computes the list of coordinates from the
encoded string and sets the passed in ```encodedString``` and the calculated ```decodedCoords``` to the instance of Polyline.
```dart 
  Polyline polyline;
  polyline = Polyline.Decode(encodedString: encoded, precision: precision);
```

#### Polyline.Distance
Polyline.Distance calcuates the haversine distance of a polyline, this is the spherical distance adjusted for the Earth's radius and is not the flat distance. The ```encodedString``` is automatically decoded to calcualte the distance and as such is available off the Polyline instance aswell as ```distance```  and ```decodedCoords```. Unit can either be in 'kilometers' or 'meters'.
```dart
  Polyline polyline;
  polyline =  Polyline.Distance(encodedString: encoded,  unit: 'kilometers');
```


## Example
Note that a precision of 5 is standard  and that distance is haversine.

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
  polyline = Polyline.Encode(decodedCoords: coordinates, precision: precision );
  print('Encoded String: ${polyline.encodedString}, Coords: ${polyline.decodedCoords}');

  // Decode an encoded string to a list of coordinates
  polyline = Polyline.Decode(encodedString: encoded, precision: precision);
  print('Decoded Coords: ${polyline.decodedCoords}');
  print('String: ${polyline.encodedString}');

  // Calculate the distance of an encoded polyline, and decode the polyline
  polyline =  Polyline.Distance(encodedString: encoded,  unit: 'kilometers');
  // By calling Distance the encodedString, decodedCoords, and distance variables
  // of the Polyline class are available
  print('Distance: ${polyline.distance.floor()}km , Encoded String: ${polyline.encodedString} Decoded Coords: ${polyline.decodedCoords}');
```

## Documentation
[Api Documentation][docs]

[docs]:https://pub.dev/documentation/polyline/latest/polyline/Polyline-class.html

## Development for v1.0.3
Multiple flags for extended capabilities
* [X] add haversine
* [X] add haversine distance
<!--
* [ ] Todo add merge polylines
* [ ] Todo add merge multiple polylines
* [ ] Todo add from geoJson
-->

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://github.com/sashvoncurtis/polyline.dart/issues/new

Pull requests welcome.

## MIT License
```
Copyright (c) 2019 sashvoncurtis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

:)
```
