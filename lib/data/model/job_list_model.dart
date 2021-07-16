class JobListModel {
  String? category;
  List<Jobs>? jobs;

  JobListModel({this.category, this.jobs});

  JobListModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? task;
  String? detail;
  String? time;
  String? date;
  String? location;

  Jobs({this.task, this.detail, this.time, this.date, this.location});

  Jobs.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    detail = json['detail'];
    time = json['time'];
    date = json['date'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['detail'] = this.detail;
    data['time'] = this.time;
    data['date'] = this.date;
    data['location'] = this.location;
    return data;
  }
}
