import 'package:flutter/material.dart';
import 'package:flutter_app/customWidget/customRText.dart';
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
          const SizedBox(height: 25),
          JobDescriptionTextWidget(fieldName:'Task',fieldValue: job!.task,),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(fieldName:'Detail',fieldValue: job!.detail,),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(fieldName:'Location',fieldValue: job!.location,),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(fieldName:'Date',fieldValue: job!.date,),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(fieldName:'Time',fieldValue: job!.time,),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
