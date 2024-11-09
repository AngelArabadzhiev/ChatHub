// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnsplashImage _$UnsplashImageFromJson(Map<String, dynamic> json) =>
    UnsplashImage(
      id: json['id'] as String,
      slug: json['slug'] as String,
      title: json['title'] as String?,
      urlFullSize: json['urls']['full'] as String,
      urlSmallSize: json['urls']['small'] as String,
    );

Map<String, dynamic> _$UnsplashImageToJson(UnsplashImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'title': instance.title,
      'full': instance.urlFullSize,
      'small': instance.urlSmallSize,
    };
