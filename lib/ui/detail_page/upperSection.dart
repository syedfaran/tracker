import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/job_list_model.dart';

class UpperContent extends StatelessWidget {
  final Jobs? job;
  final JobListModel? cate;

  const UpperContent({Key? key, this.job, this.cate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Category : ",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
              children: [
                TextSpan(
                    text: cate!.category,
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
