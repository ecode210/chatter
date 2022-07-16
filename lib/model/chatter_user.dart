class ChatterUser {
  ChatterUser({
    String? id,
    String? fullName,
    String? email,
    Map? messages,
  }) {
    _id = id;
    _fullName = fullName;
    _email = email;
    _messages = messages;
  }

  ChatterUser.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _email = json['email'];
    if (json['messages'] != null) {
      _messages = {};
      json['messages'].forEach((k, v) {
        _messages?[k] = v;
      });
    }
  }
  String? _id;
  String? _fullName;
  String? _email;
  Map? _messages;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  Map? get messages => _messages;
}
