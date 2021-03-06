import 'package:flutter/material.dart';
import 'package:flutter_app/customWidget/customRText.dart';
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
          JobDescriptionTextWidget(fieldName: 'Category',fieldValue: cate!.category),
          const SizedBox(height: 10,),
          JobDescriptionTextWidget(fieldName: 'Task',fieldValue: job!.task)
        ],
      ),
    );
  }
}



