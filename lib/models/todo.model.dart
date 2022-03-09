class Todo {
  String title = '';
  bool done = false;

  Todo(this.title, this.done);

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['done'] = done;
    return data;
  }
}
