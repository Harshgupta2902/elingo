class VideoLinksModel {
  VideoLinksModel({
    Trending? trending,
    List<MainList>? mainList,
  }) {
    _trending = trending;
    _mainList = mainList;
  }

  VideoLinksModel.fromJson(dynamic json) {
    _trending = json['trending'] != null ? Trending.fromJson(json['trending']) : null;
    if (json['mainList'] != null) {
      _mainList = [];
      json['mainList'].forEach((v) {
        _mainList?.add(MainList.fromJson(v));
      });
    }
  }

  Trending? _trending;
  List<MainList>? _mainList;

  Trending? get trending => _trending;

  List<MainList>? get mainList => _mainList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_trending != null) {
      map['trending'] = _trending?.toJson();
    }
    if (_mainList != null) {
      map['mainList'] = _mainList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MainList {
  MainList({
    String? name,
    List<Data>? data,
  }) {
    _name = name;
    _data = data;
  }

  MainList.fromJson(dynamic json) {
    _name = json['name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  String? _name;
  List<Data>? _data;

  String? get name => _name;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    num? sNo,
    String? topic,
    String? videoLink,
    String? thumbnail,
  }) {
    _sNo = sNo;
    _topic = topic;
    _videoLink = videoLink;
    _thumbnail = thumbnail;
  }

  Data.fromJson(dynamic json) {
    _sNo = json['S.No'];
    _topic = json['Topic'];
    _videoLink = json['video_link'];
    _thumbnail = json['thumbnail'];
  }

  num? _sNo;
  String? _topic;
  String? _videoLink;
  String? _thumbnail;

  num? get sNo => _sNo;

  String? get topic => _topic;

  String? get videoLink => _videoLink;

  String? get thumbnail => _thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['S.No'] = _sNo;
    map['Topic'] = _topic;
    map['video_link'] = _videoLink;
    map['thumbnail'] = _thumbnail;
    return map;
  }
}

class Trending {
  Trending({
    String? name,
    List<Data>? data,
  }) {
    _name = name;
    _data = data;
  }

  Trending.fromJson(dynamic json) {
    _name = json['name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  String? _name;
  List<Data>? _data;

  String? get name => _name;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
