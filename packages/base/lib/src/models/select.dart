part of base_lhe;

class SelectModel {
  String label;
  dynamic value;
  String? subTitle;
  String? img;
  bool isSelected;

  SelectModel({
    required this.label,
    required this.value,
    this.subTitle,
    this.img,
    this.isSelected = false,
  });

  factory SelectModel.fromJson(Map<String, dynamic> json) => SelectModel(
        label: json['label'],
        value: json['value'],
        subTitle: json['subTile'],
        img: json['img'],
      );

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};

    data['label'] = label;
    data['value'] = value;

    return data;
  }
}
