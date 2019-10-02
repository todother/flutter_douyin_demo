import 'package:json_annotation/json_annotation.dart';
part 'PostsModel.g.dart';

@JsonSerializable()
class PostsModel extends Object {
  String postsID;
  String postsContent;
  String postsMaker;
  DateTime postsMakeDate;
  int postsPicCount;
  int postsReaded;
  int postsLoved;
  String postsPics;
  String makerName;
  String makerID;
  String picsSimpPath;
  String picsPath;
  String whenPosts;
  String makerPhoto;
  double latitude;
  double longitude;
  String postsLocation;
  String postsType;
  int postsStatus;
  int ifOfficial;
  int ifLY;
  double picsRate;
  bool ifUserLoved;

  PostsModel(this.postsID,this.postsContent,this.postsMaker,this.postsMakeDate,this.postsPicCount,this.postsReaded,this.postsLoved,this.postsPics,this.ifLY
  ,this.ifOfficial,this.ifUserLoved,this.latitude,this.longitude,this.makerID,this.makerName,this.makerPhoto,this.picsPath,this.picsRate,this.picsSimpPath,this.postsLocation,this.postsStatus
  ,this.postsType,this.whenPosts);


  factory PostsModel.fromJson(Map<String, dynamic> json) => _$PostsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}