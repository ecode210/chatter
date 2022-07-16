class Chatter {
  Chatter({
    String? id,
    String? fullName,
    String? email,
    Map<dynamic, Messages>? messages,
  }) {
    _id = id;
    _fullName = fullName;
    _email = email;
    _messages = messages;
  }

  Chatter.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _email = json['email'];
    if (json['messages'] != null) {
      _messages = {};
      json['messages'].forEach((k, v) {
        _messages?[k] = Messages.fromJson(v);
      });
    }
  }
  String? _id;
  String? _fullName;
  String? _email;
  Map<dynamic, Messages>? _messages;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  Map<dynamic, Messages>? get messages => _messages;
}

class Messages {
  Messages({
    User? user,
  }) {
    _user = user;
  }

  Messages.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;

  User? get user => _user;
}

class User {
  User({
    Time? time,
  }) {
    _time = time;
  }

  User.fromJson(dynamic json) {
    _time = json['time'] != null ? Time.fromJson(json['time']) : null;
  }
  Time? _time;

  Time? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_time != null) {
      map['time'] = _time?.toJson();
    }
    return map;
  }
}

class Time {
  Time({
    bool? isSender,
    String? message,
  }) {
    _isSender = isSender;
    _message = message;
  }

  Time.fromJson(dynamic json) {
    _isSender = json['is_sender'];
    _message = json['message'];
  }
  bool? _isSender;
  String? _message;

  bool? get isSender => _isSender;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_sender'] = _isSender;
    map['message'] = _message;
    return map;
  }
}
