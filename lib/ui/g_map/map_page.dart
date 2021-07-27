import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/joblistProvider.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:flutter_app/ui/g_map/Markergenerator.dart';
import 'package:flutter_app/ui/g_map/g_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  final accessPermission = MapProvider();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<void>.value(
            value: accessPermission.determinePosition(context), initialData: () {}),
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
                    //onCameraMove: pro.onCameraMove,
                   // polylines: pro.getPolyLine(),
                    markers: pro.getMakers(context),
                    onMapCreated: pro.mapController,
                    mapType: MapType.normal,
                    initialCameraPosition: pro.initialCameraPosition(),
                    zoomControlsEnabled: false,
                  ),
                if (pro.mapNotifier == NotifierState.loaded)
                  //currentPosition
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
