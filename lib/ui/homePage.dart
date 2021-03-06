import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/DataProvider/joblistProvider.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/data/model/user_model.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/proFirebase/databaseService.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/route_generator.dart';
import 'package:flutter_app/ui/g_map/map_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: UserData(uid: 'loading', name: 'loading', email: 'loading'),
      value: DatabaseService(uid: context.read<User>().uid).userData,
      child: Scaffold(
        appBar: AppBar(
          title: UserName(),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: ()async {
              context.read<AuthProvider>().signOutUser().then((value) {
                context.read<LoginRegisterProvider>().eventToState(LoginEvent.login);
              });
              //this will do  exit app as we are not using navigation
             // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapPage()));
              },
              child: Text(
                AppString.start,
                style: TextStyle(
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(height: AppConfig.of(context).appHeight(10)),
            Container(
              width: double.infinity,
              height: AppConfig.of(context).appHeight(38.0),
              child: Consumer<JobListProvider>(
                builder: (_, notifier, __) {
                  if (notifier.state == NotifierState.loading) {
                    return Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  } else {
                    return notifier.jobList.fold(
                        (failure) => Align(
                            alignment: Alignment.center,
                            child: Text(failure.message)),
                        (jobList) => _BottomCardView(
                              jobList: jobList,
                            ));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


class UserName extends StatelessWidget {
  const UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<UserData>(context);
    return Text(
      pro.name,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 30, fontWeight: FontWeight.w100),
    );
  }
}

class _BottomCardView extends StatelessWidget {
  final List<JobListModel>? jobList;

  const _BottomCardView({Key? key, this.jobList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobList!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detailPage',
                  arguments: ScreenArguments(data: jobList![index]));
            },
            child: Container(
              width: AppConfig.of(context).appWidth(45),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(jobList![index].category,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 20)),
                  ),
                  Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 0.3,
                      indent: 50),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getCounter(jobList![index].jobs!.length),
                        itemBuilder: (context, ind) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(jobList![index].jobs![ind].task,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(fontSize: 16))),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  int getCounter(int index) {
    if (index > 5)
      return 5;
    else
      return index;
  }
}
