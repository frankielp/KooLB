class Renter {
  // Constructor
  String _name, _username, _email, _fb;
  DateTime _dob;

  String get name => _name;
  set name(String name) {
    _name = name;
  }

  String get username => _username;
  set username(String username) {
    _username = username;
  }

  String get email => _email;
  set email(String email) {
    _email = email;
  }

  String get fb => _fb;
  set fb(String fb) {
    _fb = fb;
  }

  String get name => _name;
  set name(String name) {
    _name = name;
  }

  //Function
  Renter(this._name, this._username, this._email, this._fb, this._dob);
}
