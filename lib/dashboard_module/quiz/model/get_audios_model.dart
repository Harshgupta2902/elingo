class GetAudiosModel {
  GetAudiosModel({
      List<Verbs>? verbs,}){
    _verbs = verbs;
}

  GetAudiosModel.fromJson(dynamic json) {
    if (json['verbs'] != null) {
      _verbs = [];
      json['verbs'].forEach((v) {
        _verbs?.add(Verbs.fromJson(v));
      });
    }
  }
  List<Verbs>? _verbs;

  List<Verbs>? get verbs => _verbs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_verbs != null) {
      map['verbs'] = _verbs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Verbs {
  Verbs({
      String? baseForm, 
      String? pastSimple, 
      String? pastParticiple, 
      AudioUrls? audioUrls,}){
    _baseForm = baseForm;
    _pastSimple = pastSimple;
    _pastParticiple = pastParticiple;
    _audioUrls = audioUrls;
}

  Verbs.fromJson(dynamic json) {
    _baseForm = json['baseForm'];
    _pastSimple = json['pastSimple'];
    _pastParticiple = json['pastParticiple'];
    _audioUrls = json['audioUrls'] != null ? AudioUrls.fromJson(json['audioUrls']) : null;
  }
  String? _baseForm;
  String? _pastSimple;
  String? _pastParticiple;
  AudioUrls? _audioUrls;

  String? get baseForm => _baseForm;
  String? get pastSimple => _pastSimple;
  String? get pastParticiple => _pastParticiple;
  AudioUrls? get audioUrls => _audioUrls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['baseForm'] = _baseForm;
    map['pastSimple'] = _pastSimple;
    map['pastParticiple'] = _pastParticiple;
    if (_audioUrls != null) {
      map['audioUrls'] = _audioUrls?.toJson();
    }
    return map;
  }

}

class AudioUrls {
  AudioUrls({
      String? baseForm, 
      String? pastSimple, 
      String? pastParticiple,}){
    _baseForm = baseForm;
    _pastSimple = pastSimple;
    _pastParticiple = pastParticiple;
}

  AudioUrls.fromJson(dynamic json) {
    _baseForm = json['baseForm'];
    _pastSimple = json['pastSimple'];
    _pastParticiple = json['pastParticiple'];
  }
  String? _baseForm;
  String? _pastSimple;
  String? _pastParticiple;

  String? get baseForm => _baseForm;
  String? get pastSimple => _pastSimple;
  String? get pastParticiple => _pastParticiple;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['baseForm'] = _baseForm;
    map['pastSimple'] = _pastSimple;
    map['pastParticiple'] = _pastParticiple;
    return map;
  }

}