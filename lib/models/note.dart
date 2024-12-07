class Note {
  late int _id;
  late String _title;
  late num _value;
  late String _date;
  late int _quem;

  Note(this._id, this._title, this._value, this._date, this._quem);

  int get id => _id;

  String get title => _title;

  num get value => _value;

  String get date => _date;

  int get quem => _quem;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set value(num newValue) {
    if (newValue > 0) {
      this._value = newValue;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set quem(int newQuem) {
    if (newQuem >= 1 && newQuem <= 2) {
      this._quem = newQuem;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['value'] = _value;
    map['date'] = _date;
    map['quem'] = _quem;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _value = map['value'];
    _date = map['date'];
    _quem = map['quem'];
  }
}
