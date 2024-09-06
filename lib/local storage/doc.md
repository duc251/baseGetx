packege : shared_preferences: ^2.0.15,

Chức năng để tạo 1 bộ lưu trữ local storage dùng để lưu trữ 1 số data quan trọng (token, ...)
Để dùng được thì trong file main.dart cần phải chạy {
    AppSharedPreference._internal();
} trong lúc runApp()

Mục đích của câu lệnh này là khởi tạo file dữ liệu 1 lần và khi sử dụng file này sẽ luôn tồn tại để ta truy xuất dữ liệu
Dữ liệu này sẽ không mất đi khi ta tắt app hay ngắt app, chỉ khi xoá app thì dữ liệu này mới bị mất đi
