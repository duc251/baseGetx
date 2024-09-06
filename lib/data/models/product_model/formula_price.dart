class FormulaPrice {
  int? price;
  String? unitCode;

  FormulaPrice({this.price, this.unitCode});

  factory FormulaPrice.fromJson(Map<String, dynamic> json) => FormulaPrice(
        price: json['price'] as int?,
        unitCode: json['unit_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'price': price,
        'unit_code': unitCode,
      };
}
