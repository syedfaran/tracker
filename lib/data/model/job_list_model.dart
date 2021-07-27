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
  int? jobNo;
  String? task;
  String? detail;
  String? time;
  String? date;
  String? location;
  String? lat;
  String? long;
  Jobs({this.task, this.detail, this.time, this.date, this.location,this.jobNo});

  Jobs.fromJson(Map<String, dynamic> json) {
    jobNo = json['jobNumber'];
    task = json['task'];
    detail = json['detail'];
    time = json['time'];
    date = json['date'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobNumber'] = this.jobNo;
    data['task'] = this.task;
    data['detail'] = this.detail;
    data['time'] = this.time;
    data['date'] = this.date;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
