import 'package:meta/meta.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'court_test.g.dart';

class CourtList {
  List<Court> court;

  CourtList({@required this.court});

  CourtList.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      court = List<Court>();
      json['results'].forEach((c) {
        court.add(Court.fromJson(c));
      });
    }
  }
}

class Court {
  Geometry geometry;
  String icon;
  String id;
  String name;
  List<Photos> photos;
  String placeId;
  PlusCode plusCode;
  double rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;

  Court(
      {this.geometry,
      this.icon,
      this.id,
      this.name,
      this.photos,
      this.placeId,
      this.plusCode,
      this.rating,
      this.reference,
      this.scope,
      this.types,
      this.userRatingsTotal,
      this.vicinity});

  Court.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    rating = json['rating'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode.toJson();
    }
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['scope'] = this.scope;
    data['types'] = this.types;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['vicinity'] = this.vicinity;
    return data;
  }
}

class PlusCode {
  dynamic compoundCode;
  dynamic globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class Geometry {
  Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['location'] = this.location;
    return data;
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Photos {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

// @JsonSerializable()
// class Court {
//   Geometry geometry;
//   String icon;
//   String id;
//   String name;
//   List<Photos> photos;
//   String placeId;
//   PlusCode plusCode;
//   double rating;
//   String reference;
//   String scope;
//   List<String> types;
//   int userRatingsTotal;
//   String vicinity;

//   Court(
//       {this.geometry,
//       this.icon,
//       this.id,
//       this.name,
//       this.photos,
//       this.placeId,
//       this.plusCode,
//       this.rating,
//       this.reference,
//       this.scope,
//       this.types,
//       this.userRatingsTotal,
//       this.vicinity});

//   factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);

//   Map<String, dynamic> toJson() => _$CourtToJson(this);
// }
