import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMap extends StatefulWidget {
  HomeMap({Key key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  Set<Marker> _mapMarkers = Set();
  Set<Polygon> _mapPolygons = Set();
  Map<String, dynamic> _markersInfo = Map();
  GoogleMapController _mapController;
  Position _currentPosition;
  Position _defaultPosition = Position(
    longitude: 20.608148,
    latitude: -103.417576,
  );
  TextEditingController _controller = TextEditingController();
  bool _locationMarkerAdded;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _locationMarkerAdded = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentPosition(),
      builder: (context, result) {
        if (result.error == null) {
          if (_currentPosition == null) _currentPosition = _defaultPosition;
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Basic Map'),),
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: _mapMarkers,
                  polygons: _mapPolygons,
                  onLongPress: _setMarker,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition.latitude,
                      _currentPosition.longitude,
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              visible: true,
              curve: Curves.bounceIn,
              children: [
                SpeedDialChild(
                  child: Icon(
                    Icons.add_location,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.deepOrange,
                  onTap: () {
                    _searchPlace();
                  },
                  label: "Search Location",
                  labelBackgroundColor: Colors.deepOrangeAccent,
                ),
                SpeedDialChild(
                  child: Icon(
                    Icons.polymer,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                  onTap: () {
                    print('draw polygon');
                    _drawPolygon();
                  },
                  label: "Draw Polygon",
                  labelBackgroundColor: Colors.green,
                ),
                                SpeedDialChild(
                  child: Icon(
                    Icons.location_searching,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blueAccent,
                  onTap: () {
                    _moveCamera(
                      LatLng(
                        _currentPosition.latitude,
                        _currentPosition.longitude,
                      )
                    );
                  },
                  label: "Current location",
                  labelBackgroundColor: Colors.blueAccent,
                ),
              ],
            ),
          );
        } else {
          Scaffold(
            body: Center(child: Text("Error!")),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void _showSnackBar(String msg) {
    var snackbar = new SnackBar(content: new Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _onMarkerTap(MarkerId markerId) {
    dynamic info = _markersInfo[markerId.value];
    _showMarkerDetailModal(context, info);
  }

  void _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _setMarker(LatLng coord) async {
    Placemark _place = await _getGeolocationAddress(
      Position(latitude: coord.latitude, longitude: coord.longitude),
    );
    setState(() { 
      final MarkerId id = MarkerId(coord.toString());
      Map<String, dynamic> info = _place.toJson();
      Marker m = Marker(
          markerId: id,
          position: coord,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          consumeTapEvents: false,
          onTap: () {
            _onMarkerTap(id);
          },
        );
      _markersInfo[coord.toString()] = info;
      _mapMarkers.add(m);
      _moveCamera(coord);
    });
  }

  void _drawPolygon() {
    setState(() {
      if (_mapPolygons.isEmpty) {
        List<LatLng> coords = new List();
        _mapMarkers.forEach((element) {
          if (element.markerId.value != 'Location') {
            coords.add(element.position);
          }
        });
        if (coords.isNotEmpty) {
          _mapPolygons.add(
            Polygon(
              polygonId: PolygonId('polygon'),
              points: coords,
              strokeColor: Colors.blueAccent
            )
          );
        }
      } else {
        _mapPolygons = Set();
      }
    });
  }

  void _moveCamera(LatLng target) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: 15.0,
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    _currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Placemark _place = await _getGeolocationAddress(_currentPosition);
    final MarkerId locId = MarkerId('Location');
    Map<String, dynamic> info = _place.toJson();

    if (!_locationMarkerAdded) {
      _locationMarkerAdded = _mapMarkers.add(
        Marker(
          markerId: locId,
          position: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          onTap: () {
            _onMarkerTap(locId);
          }
        ),
      );
      _markersInfo['Location'] = info;
    }

  }

  Future<Placemark> _getGeolocationAddress(Position position) async {
    var places = await Geolocator().placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      return place;
    }
    return null;
  }

  Future<Placemark> _searchPlaceGeolocation(String address) async {
    try {
      List<Placemark> places = await Geolocator().placemarkFromAddress(address);
      if (places != null && places.isNotEmpty) {
        final Placemark place = places.first;
        print(place.toJson());
        return place;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }

  }

  void _showMarkerDetailModal(context, info){
      String _default = "Not found";
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
            return Container(
              child: ListView(
                children: <Widget>[
                  new ListTile(
                    title: new Text('Country',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['country'] ?? _default),
                    onTap: () => {}          
                  ),
                  new ListTile(
                    title: new Text('Country Code',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['countryCode'] ?? _default),
                    onTap: () => {},          
                  ),
                  new ListTile(
                    title: new Text('Postal Code',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['postalCode'] ?? _default),
                    onTap: () => {},          
                  ),
                  new ListTile(
                    title: new Text('State',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['administrativeArea'] ?? _default),
                    onTap: () => {},          
                  ),
                  new ListTile(
                    title: new Text('Sub AdministrativeArea',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['subAdministrativeArea'] ?? _default),
                    onTap: () => {},          
                  ),
                  new ListTile(
                    title: new Text('Locality',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['locality'] ?? _default),
                    onTap: () => {},          
                  ),
                  new ListTile(
                    title: new Text('Colony',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['subLocality'] ?? _default),
                    onTap: () => {},          
                  ),     
                  new ListTile(
                    title: new Text('Street',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['thoroughfare'] ?? _default),
                    onTap: () => {},          
                  ),   
                  new ListTile(
                    title: new Text('Number',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(info['subThoroughfare'] ?? _default),
                    onTap: () => {},          
                  ), 
                  new ListTile(
                    title: new Text('Coordinates' ?? '',style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: new Text(
                      "(${info['position']['longitude']}, ${info['position']['latitude']})" ?? _default
                      ),
                    onTap: () => {},          
                  ), 
                ],
              )
          );
        }
      );
  }

  void _searchPlace() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Search place"),
          content: new TextField(
              controller: _controller,
          ),
          actions: <Widget>[           
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                _controller.clear();
                 Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Search"),
              onPressed: () async {
                Placemark p =  await _searchPlaceGeolocation(_controller.text);
                if (p != null) {
                  /*_setMarker(
                      LatLng(p.position.latitude, p.position.longitude)
                  );*/
                  _moveCamera(LatLng(p.position.latitude, p.position.longitude));
                } else {
                  _showSnackBar('Place not found');
                }
                 _controller.clear();
                 Navigator.of(context).pop();
              },
            ), 
          ],
        );
      },
    );
  }

}
