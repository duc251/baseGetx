import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formatMMssDDMMYYYY {
    ///convert time utc to local
    final datetime = this;
    final newDate = datetime.add(const Duration(hours: 7));
    DateFormat vietnamFormat = DateFormat('hh:mm a dd/MM/yyyy', 'vi_VN');
    return vietnamFormat.format(newDate);
  }

  String get formatDDMMYYYY {
    return DateFormat("dd-MM-yyyy").format(this);
  }

  String get formatDDMMYYYYHHmm {
    return DateFormat("dd/MM/yyyy hh:mm").format(this);
  }
}
