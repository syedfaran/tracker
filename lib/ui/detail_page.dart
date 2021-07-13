import 'package:flutter/material.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/model/demoClass.dart';

class DetailPage extends StatelessWidget {
  final Demo? demo;
  const DetailPage({Key? key, this.demo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(demo!.task,style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 30,fontWeight: FontWeight.w100),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: AppConfig.of(context).appHeight(100),
        width: AppConfig.of(context).appWidth(100),
        child: Center(
          child: Text('detail Page'),
        ),
      ),
    );
  }
}