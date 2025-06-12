// This file is a placeholder for non-web platforms.
// It provides a minimal implementation to avoid compilation errors.

// ignore_for_file: unused_element

// A mock of the Geolocation API
class _Geolocation {
  Future<_Position> getCurrentPosition() async {
    // This will never be called on mobile, so we can throw an error
    // or return a default/mock value.
    throw UnimplementedError('Geolocation is only available on the web.');
  }
}

// A mock of the Position object
class _Position {
  final _Coordinates? coords;

  // Allow passing mocked coordinates; defaults to null when not provided.
  const _Position({this.coords});
}

// A mock of the Coordinates object
class _Coordinates {
  final double? latitude;
  final double? longitude;

  const _Coordinates({this.latitude, this.longitude});
}

// A mock of the Navigator object
class _Navigator {
  final _Geolocation geolocation = _Geolocation();
}

// A mock of the Window object
class _Window {
  final _Navigator navigator = _Navigator();
}

// The top-level 'window' object
final _Window window = _Window();
