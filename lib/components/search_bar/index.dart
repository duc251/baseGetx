// import 'package:flutter/material.dart';
// import 'package:lh_nvtt_fe/constants/app_colors.dart';
// import 'package:lh_nvtt_fe/constants/app_size_device.dart';
// import 'package:lh_nvtt_fe/constants/app_spacing.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

// Widget buildFloatingSearchBar(BuildContext context, FloatingSearchBarController controller) {
//   // final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
//   return FloatingSearchBar(
//     controller: controller,
//     hint: 'Tìm kiếm...',
//     scrollPadding: const EdgeInsets.only(top: 16),
//     transitionDuration: const Duration(milliseconds: 800),
//     transitionCurve: Curves.easeInOut,
//     physics: const BouncingScrollPhysics(),
//     // axisAlignment: isPortrait ? 0.0 : -1.0,
//     openAxisAlignment: 0.0,
//     width: widthDevice(context),
//     shadowColor: AppColors.whiteColor,
//     debounceDelay: const Duration(milliseconds: 500),
//     backdropColor: Color.fromARGB(0, 255, 255, 255),
//     elevation: 0,
//     border: BorderSide(color: AppColors.borderColor_4),
//     borderRadius: BorderRadius.circular(sp12),
//     padding: EdgeInsets.symmetric(vertical: 4),
//     height: 56,
//     margins: EdgeInsets.all(0),
//     iconColor: AppColors.greyColor,
//     onQueryChanged: (query) {
//       print(1);
//       // Call your model, bloc, controller here.
//     },
//     onKeyEvent: (value) {
//       print(value);
//     },
//     onFocusChanged: (isFocused) {
//       print(isFocused);
//     },
//     // Specify a custom transition to be used for
//     // animating between opened and closed stated.
//     transition: CircularFloatingSearchBarTransition(),
//     actions: [
//       FloatingSearchBarAction(
//         showIfOpened: false,
//         child: CircularButton(
//           icon: const Icon(
//             Icons.account_box_outlined,
//             color: AppColors.greyColor,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       FloatingSearchBarAction.searchToClear(
//         showIfClosed: false,
//       ),
//     ],
//     builder: (_, transition) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Material(
//           color: Colors.white,
//           elevation: 4.0,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: Colors.accents.map((color) {
//               return InkWell(
//                 onTap: () {
//                   controller.close();
//                 },
//                 child: Container(height: 112, color: color),
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     },
//   );
// }
