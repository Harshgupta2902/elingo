class FlashCardDataModel {
  FlashCardDataModel({
  this.status,
  this.postdata,
  this.response,
  this.words,});

  FlashCardDataModel.fromJson(dynamic json) {
  status = json['status'];
  postdata = json['postdata'];
  response = json['response'];
  if (json['words'] != null) {
  words = [];
  json['words'].forEach((v) {
  words?.add(Words.fromJson(v));
  });
  }
  }
  num? status;
  String? postdata;
  String? response;
  List<Words>? words;

  Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['status'] = status;
  map['postdata'] = postdata;
  map['response'] = response;
  if (words != null) {
  map['words'] = words?.map((v) => v.toJson()).toList();
  }
  return map;
  }

  }

  class Words {
  Words({
  this.id,
  this.title,
  this.meaning,
  this.synonyms,
  this.antonyms,
  this.exampleSentence,
  this.audio,});

  Words.fromJson(dynamic json) {
  id = json['id'];
  title = json['title'];
  meaning = json['meaning'];
  synonyms = json['synonyms'] != null ? json['synonyms'].cast<String>() : [];
  antonyms = json['antonyms'] != null ? json['antonyms'].cast<String>() : [];
  exampleSentence = json['example_sentence'];
  audio = json['audio'];
  }
  num? id;
  String? title;
  String? meaning;
  List<String>? synonyms;
  List<String>? antonyms;
  String? exampleSentence;
  String? audio;

  Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['id'] = id;
  map['title'] = title;
  map['meaning'] = meaning;
  map['synonyms'] = synonyms;
  map['antonyms'] = antonyms;
  map['example_sentence'] = exampleSentence;
  map['audio'] = audio;
  return map;
  }

  }
//  ------------------------  x x x x -----------------------------


class GetFlashCardListData {
  GetFlashCardListData({
    num? status,
    String? response,
    List<CategoryNameList>? categoryNameList,}){
    _status = status;
    _response = response;
    _categoryNameList = categoryNameList;
  }

  GetFlashCardListData.fromJson(dynamic json) {
    _status = json['status'];
    _response = json['response'];
    if (json['CategoryNameList'] != null) {
      _categoryNameList = [];
      json['CategoryNameList'].forEach((v) {
        _categoryNameList?.add(CategoryNameList.fromJson(v));
      });
    }
  }
  num? _status;
  String? _response;
  List<CategoryNameList>? _categoryNameList;

  num? get status => _status;
  String? get response => _response;
  List<CategoryNameList>? get categoryNameList => _categoryNameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['response'] = _response;
    if (_categoryNameList != null) {
      map['CategoryNameList'] = _categoryNameList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CategoryNameList {
  CategoryNameList({
    String? categoryName,
    String? title,
    String? suFlashCardDataModelTitle,}){
    _categoryName = categoryName;
    _title = title;
    _suFlashCardDataModelTitle = suFlashCardDataModelTitle;
  }

  CategoryNameList.fromJson(dynamic json) {
    _categoryName = json['categoryName'];
    _title = json['title'];
    _suFlashCardDataModelTitle = json['suFlashCardDataModel_title'];
  }
  String? _categoryName;
  String? _title;
  String? _suFlashCardDataModelTitle;

  String? get categoryName => _categoryName;
  String? get title => _title;
  String? get suFlashCardDataModelTitle => _suFlashCardDataModelTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = _categoryName;
    map['title'] = _title;
    map['suFlashCardDataModel_title'] = _suFlashCardDataModelTitle;
    return map;
  }

}