
class User {

  String _email, _password, _tokenID;

  User(this._email, this._password, this._tokenID);

  get tokenID => _tokenID;

  set tokenID(value) {
    _tokenID = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

}