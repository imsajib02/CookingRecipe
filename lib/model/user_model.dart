
class User {

  String _email, _password, _tokenID;

  User();

  User.loginData(String email, String password) {

    this._email = email;
    this._password = password;
  }

  User.fromResponse(String email, String password, String tokenID) {

    this._email = email;
    this._password = password;
    this._tokenID = tokenID;
  }

  get tokenID => _tokenID;

  set tokenID(value) {
    _tokenID = value;
  }

  get password => _password;

  set password(value) {
    _password = value;
  }

  get email => _email;

  set email(String value) {
    _email = value;
  }

}