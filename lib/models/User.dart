import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'cityId')
  int? cityId;
  @JsonKey(name: 'regionId')
  int? regionId;
  @JsonKey(name: 'fullName')
  final String? fullName;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password')
  final String? password;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'authType')
  final String? authType;
  @JsonKey(name: 'favorites')
  List<int>? favorites;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'birthDate')
  final String? birthDate;
  @JsonKey(name: 'apiToken')
  final String? apiToken;

  UserModel({
    this.id,
    this.cityId,
    this.regionId,
    @required this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.avatarUrl,
    this.favorites,
    this.authType,
    this.gender,
    this.birthDate,
    this.apiToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
