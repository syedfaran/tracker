import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/joblistProvider.dart';
import 'package:flutter_app/customWidget/custom_loader.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:flutter_app/ui/g_map/Markergenerator.dart';
import 'package:flutter_app/ui/g_map/g_map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  final mapProvider = MapProvider();
  @override
  Widget build(BuildContext context) {
    print('ali');
    return MultiProvider(
      providers: [
        FutureProvider<void>.value(
            value: mapProvider.determinePosition(context), initialData: () {}),
        ChangeNotifierProvider.value(value: mapProvider),
      ],
      child: Consumer<MapProvider>(
        builder: (_, pro, __) {
          print("iori ${pro.mapNotifier}");
          return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  pro.upDateCameraNewPosition(pro.getPosition.latitude,pro.getPosition.longitude);
                },
                child: Icon(Icons.my_location_sharp),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: Stack(
              children: [
                if (pro.mapNotifier == NotifierState.loading)
                  Align(child: CustomLoader()),
                if (pro.mapNotifier == NotifierState.loaded)
                  GoogleMap(
                    //onCameraMove: pro.onCameraMove,
                   // polylines: pro.getPolyLine(),
                    markers: pro.getMarkers,
                    onMapCreated: pro.mapController,
                    mapType: MapType.terrain,
                    initialCameraPosition: pro.initialCameraPosition(),
                    zoomControlsEnabled: false,
                  ),
                if (pro.mapNotifier == NotifierState.loaded)
                  Positioned.fill(
                    top: AppConfig.of(context).appHeight(0),
                    bottom: AppConfig.of(context).appHeight(5),
                    right: AppConfig.of(context).appWidth(2),
                    child: Center(
                      child: Icon(Icons.location_on),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: AppConfig.of(context).appHeight(8.0),
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pro.jobList.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ActionChip(label: Text(pro.jobList[index].task), onPressed: (){
                            pro.upDateCameraNewPosition(double.parse(pro.jobList[index].lat!),double.parse(pro.jobList[index].long!));
                          }),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


