import '../../common/util/api.dart';
import '../../common/util/base_dio.dart';
import '../models/import_receipt_model.dart';

class ReceiptProvider {
  final _dio = BaseDio().dio();

  Future<List<ReceiptModel>> getImportReceipt(
      Map<String, dynamic> payload) async {
    try {
      var res = await _dio.post(
          '${Api.account}/receipt_import/api/receipt_imports',
          data: payload);

      return (res.data["data"]["results"] as List)
          .map((e) => ReceiptModel.fromJson(e))
          .toList();
    } catch (err) {
      return [];
    }
  }

  Future<List<ReceiptModel>> getExportReceipt(
      Map<String, dynamic> payload) async {
    try {
      var res = await _dio.post(
          '${Api.account}/receipt_export/api/receipt_exports',
          data: payload);

      return (res.data["data"]["results"] as List)
          .map((e) => ReceiptModel.fromJson(e))
          .toList();
    } catch (err) {
      return [];
    }
  }
}
