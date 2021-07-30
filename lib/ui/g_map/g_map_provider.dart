import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_app/ui/g_map/Markergenerator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/joblist_Provider.dart';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'map_marker.dart';


class MapProvider with ChangeNotifier,StreamCurrentUser,MapService {
  MapProvider(){
    positionStream.listen((position) {
      centerScreen(position);
    });
  }
  // @override
  // void dispose() {
  //   print('dispose');
  //   super.dispose();
  // }
  final List<Jobs> jobList = [];

  NotifierState _mapNotifier = NotifierState.initial;

  NotifierState get mapNotifier => _mapNotifier;

  void setMapNotifier(NotifierState notifier) {
    _mapNotifier = notifier;
    notifyListeners();
  }

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  late Position _position;

  void _setPosition(Position position) {
    _position = position;
    notifyListeners();
  }

  Position get getPosition => _position;
  Set<Marker> _getMarkers = {};

  Set<Marker> get getMarkers => _getMarkers;

  //methods
  //accessPermission and get Current Location
  Future<void> determinePosition(BuildContext context) async {
    setMapNotifier(NotifierState.loading);
    await determinePermission(context);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition().then((value) {
      _setPosition(value);
    });
    await setMakers(context);
    setMapNotifier(NotifierState.loaded);
  }

  //markers
  List<Marker> _customMarkers = [];
  setMakers(BuildContext context) async {
    context
        .read<JobListProvider>()
        .jobList
        .map((category) {
      category.map((single) {
        single.jobs!.map((data) {
          // print("${data.jobNo}and ${data.task}");
          jobList.add(data);
        }).toList();
      }).toList();
    });

    jobList.sort((a, b) => a.jobNo!.compareTo(b.jobNo!));

    MarkerGenerator(_markerWidgets(), (bitmaps) {
      return mapBitmapsToMarkers(bitmaps, (markerList) {
        _getMarkers = markerList;
        notifyListeners();
      });
    }).generate(context);
  }
  List<Widget> _markerWidgets() {
    List<Widget> list = [];
    jobList.forEach((element) {
      list.add(MapMarker(element.jobNo.toString()));
    });
    return list;
  }
  int currentMarkerIndex = 0;
  void mapBitmapsToMarkers(List<Uint8List> bitmaps,
      Function(Set<Marker>) callback,) {
    bitmaps.asMap().forEach((i, bmp) {
      _customMarkers.add(Marker(
          markerId: MarkerId("$i"),
          position: LatLng(
              double.parse(jobList[i].lat!), double.parse(jobList[i].long!)),
          icon: BitmapDescriptor.fromBytes(bmp),
          onTap: () async {
            PageNotifier.generate(index: i, callback: (page, pageIndex) {
              currentMarkerIndex = i;
              //page.animateToPage(i,duration: Duration(milliseconds: 2500),curve: Curves.easeInOut);
              page.jumpToPage(i);
            });
          }));
    });
    callback(_customMarkers.toSet());
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////

  // List<List<PointLatLng>> points = [];
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  // static const String googleAPIKey = 'AIzaSyBOFccMjpf2pFo5z7lnTi16SR3b43xobKA';
  //
  // Future<PolylineResult> setPolyLine() async {
  //    return polylinePoints
  //       .getRouteBetweenCoordinates(googleAPIKey, PointLatLng(24.863455, 67.051977), PointLatLng(24.8631904, 67.06666))
  //       .then((value) => value, onError: (exception) {
  //     print(exception);
  //   });
  //   //points.add(result.points);
  //   // for (int i = 0; i <= _jobList.length-1; i++) {
  //   //   var nextPoint = i + 1;
  //   //   var result = await polylinePoints.getRouteBetweenCoordinates(
  //   //       googleAPIKey,
  //   //       PointLatLng(double.parse(_jobList[i].lat.toString()), double.parse(_jobList[i].long.toString())),
  //   //       PointLatLng(double.parse(_jobList[nextPoint].lat.toString()),
  //   //           double.parse(_jobList[nextPoint].long.toString())));
  //   //   if (result.points.isNotEmpty)
  //   //     print("faran ${result.points}");
  //   //   points.add(result.points);
  //   // }
  // }
  //
  // Set<Polyline> getPolyLine() {
  //   setPolyLine();
  //   return {};
  // }
///////////////////////////////////////////////////////////////////////////////////////////////////////
  //mapController
  void mapController(GoogleMapController controller) {
    _mapController = controller;
    _controller.complete(controller);
  }

  //initial camera Position on Startup
  CameraPosition initialCameraPosition() {
    return CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: 14,
        bearing: 15);
  }

  //move to current Postion
  void upDateCameraNewPosition(double lat, double lng) {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lng), zoom: 18, tilt: 30, bearing: 50)));
  }

  Future<void> centerScreen(Position position) async {
    print('faran');
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18.0)));

  }
}


class PageNotifier {
  PageNotifier() {
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  static PageController? _pageController;

  PageController? get pageController => _pageController;

  static void generate({int? index, Function(PageController, int)? callback}) {
    callback!(_pageController!, index!);
  }
}
class StreamCurrentUser {
Stream<Position> positionStream = Geolocator.getPositionStream(distanceFilter: 10,desiredAccuracy: LocationAccuracy.high);

}
class MapService{
  Future<void> determinePermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services logiuare not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pop(context);
        // Add Your Code here.
      });
      ToastNotifier.showToast(context, 'Location services are disabled');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        ToastNotifier.showToast(context, 'Location permissions are denied');
        Navigator.pop(context);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ToastNotifier.showToast(context,
          'Location permissions are permanently denied, we cannot request permissions.');
      Navigator.pop(context);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}





