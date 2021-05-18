class videoModel {
  int id;
  List<Movies> tailer;

  videoModel({this.id, this.tailer});

  videoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      tailer = new List<Movies>();
      json['results'].forEach((v) {
        tailer.add(new Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.tailer != null) {
      data['results'] = this.tailer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Movies(
      {this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}
