import 'package:flutter/material.dart';

class JobDescriptionTextWidget extends StatelessWidget {
  final String? fieldName;
  final String? fieldValue;
  const JobDescriptionTextWidget({Key? key, this.fieldName, this.fieldValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "$fieldName: ",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 20, color: Color(0xff9C9C9D)),
        children: [
          TextSpan(
              text: fieldValue,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 20.0,
              )),
        ],
      ),
    );
  }
}