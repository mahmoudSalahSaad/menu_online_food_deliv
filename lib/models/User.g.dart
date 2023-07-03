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

    phoneNumber: json['phoneNumber'] ,
    avatarUrl: json['avatarUrl'] ,
    favorites: (json['favorites'] as List).map((e) => e as int).toList(),
    authType: json['authType'] ,
    gender: json['gender'] ,
    birthDate: json['birthDate'] as String,
    apiToken: json['apiToken'],
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'cityId': instance.cityId,
      'regionId': instance.regionId,
      'fullName': instance.fullName,
      'email': instance.email,

      'phoneNumber': instance.phoneNumber,
      'avatarUrl': instance.avatarUrl,
      'authType': instance.authType,
      'favorites': instance.favorites,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'apiToken': instance.apiToken,
    };
