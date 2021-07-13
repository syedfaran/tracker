import 'package:flutter/material.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/helper/theme/app_theme.dart';
import 'package:flutter_app/model/demoClass.dart';
import 'package:flutter_app/route_generator.dart';
import 'package:flutter_app/ui/detail_page.dart';
import 'package:flutter_app/ui/g_map/map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: AppString.task,
              style: Theme.of(context).textTheme.headline1,
              children: [
                TextSpan(
                    text: AppString.list,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 38.0, color: Color(0xff9C9C9D))),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff055E9E),
                textStyle: Theme.of(context).textTheme.bodyText1),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            },
            child: Text(
              AppString.start,
              style: TextStyle(
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: AppConfig.of(context).appHeight(10),
          ),
          Container(
              width: double.infinity,
              height: AppConfig.of(context).appHeight(38.0),
              child: _BottomCardView())
        ],
      ),
    );
  }
}

class _BottomCardView extends StatelessWidget {
  const _BottomCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: getList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detailPage',
                  arguments: ScreenArguments(data: getList[index]));
            },
            child: Container(
              width: AppConfig.of(context).appWidth(35),
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff055E9E).withOpacity(0.3),
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3),
                ],
              ),
              //color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      getList[index]!.task!,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 0.3,
                    indent: 50,
                  ),
                  Column(
                    children: getList[index]!.taskList!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
