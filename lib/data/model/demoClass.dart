class Demo{
  final String? category;
  final List<Wicked?>? taskList;
  const Demo({this.category,this.taskList});
}


const List<Demo?> getList = [
  Demo(category: 'Delivery',taskList: getWickedListDelivery),
  Demo(category: 'Sales',taskList: getWickedListPlumbing),
  Demo(category: 'Maintenance',taskList: getWickedListMaintenance),
];


class Wicked{
  final String? job;
  final String? task;
  final String? detail;
  final String? location;
  final String? date;
  final String? time;
  const Wicked(this.job, this.task, this.detail, this.location, this.date, this.time);
}

const List<Wicked?> getWickedListDelivery= [
  Wicked('Delivery/job 1', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('Delivery/job 2', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('Delivery/job 5', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('Delivery/job 5', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
];
const List<Wicked?> getWickedListPlumbing= [
  Wicked('sales/job 1', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('sales/job 2', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('sales/job 3', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('sales/job 4', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
  Wicked('sales/job 5', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),
];
const List<Wicked?> getWickedListMaintenance= [
  Wicked('Maintenance/job 1', 'abstract Detail', 'long detail', 'karacho', '7/14/2021', '1:05'),

];