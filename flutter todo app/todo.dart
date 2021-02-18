class Todo {
  int _id;
  int _priority;
  String _title;
  String _date;
  String _description;

  // Constructors
  Todo(this._title, this._priority, this._date, [this._description]); //square brackets are optional parameters
  Todo.withId(this._id, this._title, this._priority, this._date, [this._description]);

  // Getters
  int get id => _id;
  int get priority => _priority;
  String get title => _title; 
  String get date => _date;
  String get description => _description;

  // Setters
  set priority(int newPriority) {
    if (newPriority > 0 && newPriority <= 3){
      _priority = newPriority;
    }
  }

  set title(String newTitle) {
    if (newTitle.length <= 255){
      _title = newTitle;
    }
  }

  set date (String newDate) {
    _date = newDate;
  }

  set description(String newDescription) {
    if (newDescription.length <= 255){
      _description = newDescription;
    }
  }

  Map <String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null){
      map["id"] = _id;
    }
    map["priority"] = _priority;
    map["title"] = _title;
    map["date"] = _date;
    map["description"] = _description;

    return map;
  }

  // Named constructor
  Todo.fromObject(dynamic o) {
    this._id = o["id"];
    this.priority = o["priority"];
    this.title = o["title"];
    this._date = o["date"];
    this.description = o["description"];
  }

}