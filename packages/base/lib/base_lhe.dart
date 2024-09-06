library base_lhe;

import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

/// A Calculator.
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// Constants
part 'src/constants/color.dart';
part 'src/constants/spacing.dart';
part 'src/constants/typography.dart';
part 'src/constants/size_device.dart';
part 'src/constants/assets_path.dart';

// Components
part 'src/components/base_select.dart';
part 'src/components/base_container.dart';
part 'src/components/base_button.dart';
part 'src/components/base_scaffold.dart';
part 'src/components/base_appBar.dart';
part 'src/components/base_select_advanced/view.dart';
part 'src/components/base_infinite_scroll.dart';
part 'src/components/base_popup_noti.dart';
part 'src/components/base_search_bar.dart';
part 'src/components/base_help_desk/bubble_button.dart';
part 'src/components/base_help_desk/floating_chat_button.dart';
part 'src/components/base_help_desk/support_help_desk.dart';
part 'src/components/base_multi_select_box.dart';
part 'src/components/base_check_box.dart';
part 'src/components/two_button_box.dart';

// Models
part 'src/models/select.dart';

// Enum
part 'src/enums/select.dart';
part 'src/enums/status_noti.dart';

// Controller
part 'src/components/base_select_advanced/controller.dart';

// Util
part 'src/utils/fetchPage.dart';
