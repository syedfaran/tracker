import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/presentation/pages/detail_page/lowerSection.dart';
import 'package:flutter_app/presentation/pages/detail_page/upperSection.dart';
import 'package:slimy_card/slimy_card.dart';

class DetailPage extends StatelessWidget {
  final JobListModel? mainJob;

  const DetailPage({Key? key, this.mainJob}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mainJob!.category!,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 30, fontWeight: FontWeight.w100),
        ),
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
        child: _SlimyWidget(
          list: mainJob!.jobs,
          mainJob: mainJob,
        ),
      ),
    );
  }
}

class _SlimyWidget extends StatelessWidget {
  final List<Jobs>? list;
  final JobListModel? mainJob;

  const _SlimyWidget({Key? key, this.list, this.mainJob}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list!.map((job) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SlimyCard(
            footerColor: Colors.lime,
            color: Theme.of(context).primaryColorLight,
            width: AppConfig.of(context).appWidth(85),
            topCardHeight: AppConfig.of(context).appWidth(46),
            bottomCardHeight: 300,
            borderRadius: 15,
            topCardWidget: UpperContent(job: job, cate: mainJob),
            bottomCardWidget: LowerContent(job: job),
            slimeEnabled: true,
          ),
        );
      }).toList(),
    );
  }
}
