class PlatformListModel {
  String? platform;
  bool? expanded;
  bool? enabled;
  int? option;
  List<Options>? options;

  PlatformListModel(
      {this.platform, this.enabled, this.option, this.options, this.expanded});

  PlatformListModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    enabled = json['is_toggle'];
    expanded = json['is_expanded'];
    option = json['option'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform;
    data['is_toggle'] = enabled;
    data['is_expanded'] = expanded;
    data['option'] = option;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String? title;
  String? description;
  bool? selected;

  Options({this.title, this.selected, this.description});

  Options.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    selected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_selected'] = selected;
    return data;
  }
}
