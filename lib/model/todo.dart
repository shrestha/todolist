class Todo {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

  Todo(this._title, this._description, this._priority, this._date);
  Todo.withId(
      this._id, this._title, this._description, this._priority, this._date);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length < 255) _title = newTitle;
  }

  set description(String newDescription) {
    if (newDescription.length < 255) _description = newDescription;
  }

  set priority(int newPriority) {
    if (newPriority > 0 && newPriority < 3) _priority = newPriority;
  }

  set date(String newDate) {
    _date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Todo.fromObject(dynamic o) {
    _id = o["id"];
    _title = o["title"];
    _description = o["description"];
    _date = o["date"];
    _priority = o["priority"];
  }
}
