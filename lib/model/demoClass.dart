class Demo{
  final String? task;
  final List<String>? taskList;
  const Demo({this.task,this.taskList});
}




const List<Demo?> getList = [
  Demo(task: 'Delivery',taskList: ['place 1','place 2','place 3','place 4','place 5','place 6']),
  Demo(task: 'plumbing',taskList: ['place 1','place 2','place 3']),
  Demo(task: 'Maintaince',taskList: ['place 1','place 2','place 3','place 4']),
  Demo(task: 'Pick Up',taskList: ['place 1','place 2','place 3','place 4','place 5','place 6']),
  Demo(task: 'Task Day 5',taskList: ['place 1','place 2',]),
  Demo(task: 'Task Day 6',taskList: ['place 1','place 2','place 3','place 4','place 5',]),
];