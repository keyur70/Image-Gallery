import 'dart:convert';

GetImageListModel getImageListModelFromJson(String str) =>
    GetImageListModel.fromJson(json.decode(str));

class GetImageListModel {
  List<Hit> hits;

  GetImageListModel({
    required this.hits,
  });

  factory GetImageListModel.fromJson(Map<String, dynamic> json) =>
      GetImageListModel(
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );
}

class Hit {
  String pageUrl;
  String previewUrl;
  String webformatUrl;
  String largeImageUrl;
  int views;
  int likes;
  String userImageUrl;

  Hit({
    required this.pageUrl,
    required this.previewUrl,
    required this.webformatUrl,
    required this.largeImageUrl,
    required this.views,
    required this.likes,
    required this.userImageUrl,
  });

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        pageUrl: json["pageURL"],
        previewUrl: json["previewURL"],
        webformatUrl: json["webformatURL"],
        largeImageUrl: json["largeImageURL"],
        views: json["views"],
        likes: json["likes"],
        userImageUrl: json["userImageURL"],
      );
}
