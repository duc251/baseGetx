class Category {
  int? categoryId;
  String? categoryName;
  dynamic categoryCode;

  Category({this.categoryId, this.categoryName, this.categoryCode});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json['category_id'] as int?,
        categoryName: json['category_name'] as String?,
        categoryCode: json['category_code'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'category_id': categoryId,
        'category_name': categoryName,
        'category_code': categoryCode,
      };
}
