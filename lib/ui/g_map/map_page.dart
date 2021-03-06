import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/joblistProvider.dart';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  final accessPermission = MapProvider();

  //const MapPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<void>.value(
          value: accessPermission.determinePosition(context),
          initialData: () {},
        ),
        ChangeNotifierProvider.value(value: accessPermission),
      ],
      child: Consumer<MapProvider>(
        builder: (_, pro, __) {
          print("iori ${pro.mapNotifier}");
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                pro.upDateCameraNewPosition(pro.getPosition);
              },
              child: Icon(Icons.my_location_sharp),
            ),
            body: Stack(
              children: [
                if (pro.mapNotifier == NotifierState.loading)
                  Align(child: CircularProgressIndicator()),
                if (pro.mapNotifier == NotifierState.loaded)
                  GoogleMap(
                    onCameraMove: pro.onCameraMove,
                    markers: pro.getMakers(context),
                    onMapCreated: pro.mapController,
                    mapType: MapType.normal,
                    initialCameraPosition: pro.initialCameraPosition(),
                    zoomControlsEnabled: false,
                  ),
                if (pro.mapNotifier == NotifierState.loaded)
                  //currentPostion
                  Positioned.fill(
                    top: AppConfig.of(context).appHeight(0),
                    bottom: AppConfig.of(context).appHeight(5),
                    right: AppConfig.of(context).appWidth(2),
                    child: Center(
                      child: Icon(Icons.location_on),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapProvider with ChangeNotifier {
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

  //accessPermission and get Current Location
  Future<void> determinePosition(BuildContext context) async {
    setMapNotifier(NotifierState.loading);
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

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition().then((value) {
      _setPosition(value);
      // upDateCameraNewPosition(value);
    });
    setMapNotifier(NotifierState.loaded);
  }

  Set<Marker> getMakers([BuildContext? context]) {
    List<Jobs> list = [];
    context!.read<JobListProvider>().jobList.map((category) {
      category.map((single) {
        single.jobs!.map((data) {
          list.add(data);
        }).toList();
      }).toList();
    });
    return list
        .map((pos) => Marker(
              markerId: MarkerId(pos.task.toString()),
              position: LatLng(double.parse(pos.lat!), double.parse(pos.long!)),
            ))
        .toSet();
  }

  //mapController
  void mapController(GoogleMapController controller) {
    _mapController = controller;
    _controller.complete(controller);
    notifyListeners();
  }

  //initial camera Position on Startup
  CameraPosition initialCameraPosition() {
    return CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: 14,
        bearing: 15);
  }

  void upDateCameraNewPosition(Position position) {
    print('bilal');
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14,
        tilt: 30,
        bearing: 15)));
  }
  //onCameraMove
  void onCameraMove(CameraPosition cameraPosition){

  }
}
