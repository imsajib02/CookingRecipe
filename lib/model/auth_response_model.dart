
class AuthResponseModel {

  String response;
  String message;
  Result result;

  AuthResponseModel({this.response, this.message, this.result});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {

    response =  json['response'];
    message = json['message'] == null ? null : json["message"];
    result =  json['result'] == null ? null : Result.fromJson(json["result"]);
  }
}


class Result {

  String token;

  Result({this.token});

  Result.fromJson(Map<String, dynamic> json) {

    token = json['token'];
  }
}