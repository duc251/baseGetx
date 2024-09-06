import 'category.dart';
import 'formula_price.dart';

class ProductModel {
  int? formulaId;
  int? systemProductId;
  int? systemFormulaId;
  int? productId;
  String? formulaName;
  String? systemKey;
  String? statusCode;
  String? productName;
  dynamic productCode;
  String? description;
  bool? formulaStatus;
  List<Category>? category;
  List<FormulaPrice>? formulaPrice;
  List<String>? image;

  ProductModel({
    this.formulaId,
    this.systemProductId,
    this.systemFormulaId,
    this.productId,
    this.formulaName,
    this.systemKey,
    this.statusCode,
    this.productName,
    this.productCode,
    this.description,
    this.formulaStatus,
    this.category,
    this.formulaPrice,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        formulaId: json['formula_id'] as int?,
        systemProductId: json['system_product_id'] as int?,
        systemFormulaId: json['system_formula_id'] as int?,
        productId: json['product_id'] as int?,
        formulaName: json['formula_name'] as String?,
        systemKey: json['system_key'] as String?,
        statusCode: json['status_code'] as String?,
        productName: json['product_name'] as String?,
        productCode: json['product_code'] as dynamic,
        description: json['description'] as String?,
        formulaStatus: json['formula_status'] as bool?,
        category: (json['category'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        formulaPrice: (json['formula_price'] as List<dynamic>?)
            ?.map((e) => FormulaPrice.fromJson(e as Map<String, dynamic>))
            .toList(),
        image: json['image'] as List<String>?,
      );

  Map<String, dynamic> toJson() => {
        'formula_id': formulaId,
        'system_product_id': systemProductId,
        'system_formula_id': systemFormulaId,
        'product_id': productId,
        'formula_name': formulaName,
        'system_key': systemKey,
        'status_code': statusCode,
        'product_name': productName,
        'product_code': productCode,
        'description': description,
        'formula_status': formulaStatus,
        'category': category?.map((e) => e.toJson()).toList(),
        'formula_price': formulaPrice?.map((e) => e.toJson()).toList(),
        'image': image,
      };
}
