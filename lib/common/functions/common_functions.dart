import 'package:base_lhe/base_lhe.dart';

SelectModel? findExportItemSelect(
  List<SelectModel> listSelect,
  dynamic condition,
) {
  return listSelect.cast<SelectModel?>().firstWhere(
        (e) => e?.value[1] == condition,
        orElse: () => null,
      );
}

SelectModel? findItemSelect(
  List<SelectModel> listSelect,
  dynamic condition,
) {
  return listSelect.cast<SelectModel?>().firstWhere(
        (e) => e?.value == condition,
        orElse: () => null,
      );
}
