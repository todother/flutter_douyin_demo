// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsModel _$PostsModelFromJson(Map<String, dynamic> json) {
  return PostsModel(
    json['postsID'] as String,
    json['postsContent'] as String,
    json['postsMaker'] as String,
    json['postsMakeDate'] == null
        ? null
        : DateTime.parse(json['postsMakeDate'] as String),
    json['postsPicCount'] as int,
    json['postsReaded'] as int,
    json['postsLoved'] as int,
    json['postsPics'] as String,
    json['ifLY'] as int,
    json['ifOfficial'] as int,
    json['ifUserLoved'] as bool,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
    json['makerID'] as String,
    json['makerName'] as String,
    json['makerPhoto'] as String,
    json['picsPath'] as String,
    (json['picsRate'] as num)?.toDouble(),
    json['picsSimpPath'] as String,
    json['postsLocation'] as String,
    json['postsStatus'] as int,
    json['postsType'] as String,
    json['whenPosts'] as String,
  );
}

Map<String, dynamic> _$PostsModelToJson(PostsModel instance) =>
    <String, dynamic>{
      'postsID': instance.postsID,
      'postsContent': instance.postsContent,
      'postsMaker': instance.postsMaker,
      'postsMakeDate': instance.postsMakeDate?.toIso8601String(),
      'postsPicCount': instance.postsPicCount,
      'postsReaded': instance.postsReaded,
      'postsLoved': instance.postsLoved,
      'postsPics': instance.postsPics,
      'makerName': instance.makerName,
      'makerID': instance.makerID,
      'picsSimpPath': instance.picsSimpPath,
      'picsPath': instance.picsPath,
      'whenPosts': instance.whenPosts,
      'makerPhoto': instance.makerPhoto,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'postsLocation': instance.postsLocation,
      'postsType': instance.postsType,
      'postsStatus': instance.postsStatus,
      'ifOfficial': instance.ifOfficial,
      'ifLY': instance.ifLY,
      'picsRate': instance.picsRate,
      'ifUserLoved': instance.ifUserLoved,
    };
