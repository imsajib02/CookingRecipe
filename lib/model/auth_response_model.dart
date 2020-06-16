import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {

  @JsonKey(name: "response")
  String response;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "result")
  Result result;

  AuthResponseModel(this.response, this.message, this.result);

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}

@JsonSerializable()
class Result {

  @JsonKey(name: "token")
  String token;

  Result(this.token);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}