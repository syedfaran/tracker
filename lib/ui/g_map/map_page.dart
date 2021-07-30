import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/joblist_Provider.dart';
import 'package:flutter_app/customWidget/custom_loader.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:flutter_app/ui/g_map/Markergenerator.dart';
import 'package:flutter_app/ui/g_map/g_map_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapProvider = MapProvider();
  @override
  void dispose() {
   // mapProvider.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<void>.value(
            value: mapProvider.determinePosition(context), initialData: () {}),
        ChangeNotifierProvider.value(value: mapProvider),
        Provider(create: (context) => PageNotifier()),
      ],
      child: Consumer<MapProvider>(
        builder: (_, pro, __) {
          print("iori ${pro.mapNotifier}");
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: Stack(
              children: [
                if (pro.mapNotifier == NotifierState.loading)
                 const Align(child: CustomLoader()),
                if (pro.mapNotifier == NotifierState.loaded)
                GoogleMap(
                  markers: pro.getMarkers,
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  onMapCreated: pro.mapController,
                  mapType: MapType.terrain,
                  initialCameraPosition: pro.initialCameraPosition(),
                  zoomControlsEnabled: false,
                ),
                if (pro.mapNotifier == NotifierState.loaded)
                const _MapJobScrollView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MapJobScrollView extends StatelessWidget {
  const _MapJobScrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<MapProvider, PageNotifier>(
      builder: (context, pro, notifier, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
           padding: EdgeInsets.symmetric(vertical: 5),
            height: AppConfig.of(context).appHeight(13.0),
            width: double.infinity,
            child: PageView.builder(
              controller: notifier.pageController,
              scrollDirection: Axis.horizontal,
              itemCount: pro.jobList.length,
              onPageChanged: (page) {
                pro.upDateCameraNewPosition(
                    double.parse(pro.jobList[page].lat!),
                    double.parse(pro.jobList[page].long!));
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        margin: EdgeInsets.only(left: AppConfig.of(context).appWidth(15),),
                          width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              pro.jobList[index].task,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(pro.jobList[index].jobNo.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13)),
                            Text(pro.jobList[index].date,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColorLight,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff055E9E).withOpacity(0.3),
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3),
                            ]),
                      ),
                    ),
                    Positioned(top: AppConfig.of(context).appWidth(1),
                      bottom: AppConfig.of(context).appWidth(1),
                      left: AppConfig.of(context).appWidth(4),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image(
                            height: AppConfig.of(context).appWidth(20.0),
                            width: AppConfig.of(context).appWidth(25.0),
                            image: NetworkImage(pro.jobList[index].image!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
