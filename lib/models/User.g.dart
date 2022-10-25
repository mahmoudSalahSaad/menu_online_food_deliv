// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    cityId: json['cityId'] as int,
    regionId: json['regionId'] as int,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    phoneNumber: json['phoneNumber'] as String,
    avatarUrl: json['avatarUrl'] as String,
    favorites: (json['favorites'] as List)?.map((e) => e as int)?.toList(),
    authType: json['authType'] as String,
    gender: json['gender'] as String,
    birthDate: json['birth_date'] as String,
    apiToken: json['api_token'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'cityId': instance.cityId,
      'regionId': instance.regionId,
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'avatarUrl': instance.avatarUrl,
      'authType': instance.authType,
      'favorites': instance.favorites,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'apiToken': instance.apiToken,
    };
