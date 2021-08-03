import 'package:flutter/material.dart';
import 'package:flutter_app/model/JobListModel.dart';
import 'package:flutter_app/ui/appUtil/AppString.dart';
import 'package:flutter_app/ui/pages/detail_page/DetailPage.dart';
import 'package:flutter_app/ui/pages/googlemapPage/GoogleMapPage.dart';
import 'package:flutter_app/ui/pages/HomePage.dart';
import 'package:flutter_app/ui/pages/Wrapper.dart';


class RouteObservers {
  static RouteObserver<dynamic> routeObserver = RouteObserver<PageRoute>();
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    ScreenArguments arguments;
    if (settings.arguments != null)
      arguments = settings.arguments as ScreenArguments;
    else {
      arguments = ScreenArguments();
    }
    print(arguments.data.toString());
    switch (settings.name) {
      case AppRouteString.initialPage:
        return MaterialPageRoute(
          builder: (context) => const Wrapper(),
        );
      case AppRouteString.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRouteString.detailPage:
        if (arguments.data is JobListModel) {
          return MaterialPageRoute(
              builder: (context) => DetailPage(mainJob: arguments.data));
        } else {
          return _errorRoute();
        }
      case AppRouteString.mapPage:
        return MaterialPageRoute(builder: (context) => const MapPage());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

// class RouteAwareWidget extends StatefulWidget {
//   final String name;
//   final Widget? child;
//
//   RouteAwareWidget(this.name, {@required this.child});
//
//   @override
//   State<RouteAwareWidget> createState() => RouteAwareWidgetState();
// }
//
// class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     RouteObservers.routeObserver.subscribe(this, ModalRoute.of(context));
//   }
//
//   @override
//   void dispose() {
//     RouteObservers.routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPush() {
//     print('didPush ${widget.name}');
//     // App.rootContext = context;
//   }
//
//   @override
//   // Called when the top route has been popped off, and the current route shows up.
//   void didPopNext() {
//     print('didPopNext ${widget.name}');
//     // App.rootContext = context;
//   }
//
//   @override
//   Widget build(BuildContext context) => widget.child!;
// }

class ScreenArguments<T> {
  final int? tab;
  final Widget? currentPage;
  final String? message;
  final bool? flag;
  final T? data;
  final T? secondData;

  const ScreenArguments(
      {this.tab,
      this.currentPage,
      this.message,
      this.data,
      this.secondData,
      this.flag});
}
