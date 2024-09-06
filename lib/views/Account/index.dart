import 'package:flutter/src/widgets/framework.dart';

import '../../common/base/base_layout.dart';
import '../../features/account/views/index_view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseLayout('Chi tiết tài khoản của tôi', AccountView());
  }
}
