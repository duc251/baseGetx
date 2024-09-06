// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../constants/constans.dart';
// import '../database/app_local_directory.dart';
// import 'en_us.dart';
// import 'vi_vn.dart';

// class LocaleString extends Translations {
//   static Locale get locale {
//     var languageCode = json.decode(
//             CounterStorage.instance.readCounter)[0] ?? 'vi';
//     var countryCode = json.decode(
//             CounterStorage.instance.readCounter)[1] ?? 'VN';
//     return Locale(languageCode, countryCode);
//   }

//   static void setLanguage(Locale locale) async {
//     if (Get.locale?.languageCode != locale.languageCode) {
//       Get.updateLocale(locale);
//       var language = jsonEncode('${{
//         "${PrefKeys.LANGUAGE_CODE}": locale.languageCode,
//         "${PrefKeys.COUNTRY_CODE}": locale.countryCode,
//       }}');
//       CounterStorage.instance.writeCounter(language);
//     }
//   }

//   static const List locales = [
//     {
//       'name': 'English',
//       'locale': Locale('en', 'US'),
//       PrefKeys.LANGUAGE_CODE: 'en',
//       PrefKeys.COUNTRY_CODE: 'US'
//     },
//     {
//       'name': 'Tiếng Việt',
//       'locale': Locale('vi', 'VN'),
//       PrefKeys.LANGUAGE_CODE: 'vi',
//       PrefKeys.COUNTRY_CODE: 'VN'
//     },
//   ];

//   @override
//   Map<String, Map<String, String>> get keys => {
//         'en_US': en_US,
//         'vi_VN': vi_VN,
//       };
// }
