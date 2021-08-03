import 'package:flutter/material.dart';
import 'package:flutter_app/model/jobListModel.dart';
import 'package:flutter_app/ui/widgets/customRText.dart';

class LowerContent extends StatelessWidget {
  final Jobs? job;

  const LowerContent({Key? key, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          JobDescriptionTextWidget(
            fieldName: 'Task',
            fieldValue: job!.task,
          ),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(
            fieldName: 'Detail',
            fieldValue: job!.detail,
          ),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(
            fieldName: 'Location',
            fieldValue: job!.location,
          ),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(
            fieldName: 'Date',
            fieldValue: job!.date,
          ),
          const SizedBox(height: 10),
          JobDescriptionTextWidget(
            fieldName: 'Time',
            fieldValue: job!.time,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
