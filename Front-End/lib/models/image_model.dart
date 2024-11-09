import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class UnsplashImage {
  String id;
  String slug;
  String? title;

  @JsonKey(name: "full")
  String urlFullSize;

  @JsonKey(name: "small")
  String urlSmallSize;

  UnsplashImage(
      {required this.id,
      required this.slug,
      this.title,
      required this.urlFullSize,
      required this.urlSmallSize});

  factory UnsplashImage.fromJson(Map<String, dynamic> json) =>
      _$UnsplashImageFromJson(json);

  Map<String, dynamic> toJson() => _$UnsplashImageToJson(this);
}
