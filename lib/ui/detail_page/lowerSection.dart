import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/job_list_model.dart';

class LowerContent extends StatelessWidget {
  final Jobs? job;
  const LowerContent({Key? key, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
          RichText(
            text: TextSpan(
              text: "Task : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.task,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: "Detail : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.detail,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: "Location : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.location,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: "Date : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.date,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: "Time : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.time,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: "Task : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: job!.task,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20.0,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
