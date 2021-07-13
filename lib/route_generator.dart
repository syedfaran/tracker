import 'package:flutter/material.dart';
import 'package:flutter_app/model/demoClass.dart';
import 'package:flutter_app/ui/detail_page.dart';
import 'package:flutter_app/ui/g_map/map_page.dart';
import 'package:flutter_app/ui/homePage.dart';
import 'package:flutter_app/ui/wrapper.dart';

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
      case '/':
        return MaterialPageRoute(
          //call wrapper
          builder: (context) => Wrapper(),
        );
      case '/homepage':
        return MaterialPageRoute(
            builder: (context) =>
                RouteAwareWidget('/homepage', child: HomePage()));
      case '/detailPage':
        return MaterialPageRoute(
            builder: (context) => DetailPage(demo: arguments.data));
      case '/MapPage':
        return MaterialPageRoute(builder: (context) => MapPage());
    }
  }
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget? child;

  RouteAwareWidget(this.name, {@required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObservers.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    RouteObservers.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print('didPush ${widget.name}');
    // App.rootContext = context;
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    print('didPopNext ${widget.name}');
    // App.rootContext = context;
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}

class ScreenArguments<T> {
  final int? tab;
  final Widget? currentPage;
  final String? message;
  final bool? flag;
  final T? data;
  final T? secondData;

  ScreenArguments(
      {this.tab,
      this.currentPage,
      this.message,
      this.data,
      this.secondData,
      this.flag});
}
