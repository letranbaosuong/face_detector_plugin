
---
Để tải một package Flutter lên pub.dev, bạn cần thực hiện các bước sau:
1. Chuẩn bị package của bạn

Đảm bảo pubspec.yaml của bạn có đầy đủ thông tin:
yamlname: face_detector_plugin
description: "Plugin phát hiện khuôn mặt cho Flutter sử dụng API native."
version: 0.0.1
homepage: https://github.com/letranbaosuong/face_detector_plugin.git
repository: https://github.com/letranbaosuong/face_detector_plugin.git
issue_tracker: https://github.com/letranbaosuong/face_detector_plugin/issues

Thêm license vào file LICENSE
Viết README.md chi tiết
Thêm ví dụ trong thư mục example/
Chạy flutter pub publish --dry-run để kiểm tra lỗi

2. Tạo tài khoản và xác minh

Truy cập pub.dev và đăng nhập bằng tài khoản Google
Xác minh danh tính bằng cách làm theo hướng dẫn trên pub.dev

3. Xuất bản package

Chạy dart pub login trong terminal và làm theo hướng dẫn
Sau khi đăng nhập, chạy flutter pub publish

4. Quản lý phiên bản

Sau khi xuất bản, bạn có thể cập nhật phiên bản trong pubspec.yaml
Chạy flutter pub publish để xuất bản phiên bản mới

Lưu ý quan trọng:

Tên package phải là duy nhất trên pub.dev
Điểm chất lượng cao hơn sẽ giúp package của bạn dễ được tìm thấy
Tuân thủ quy ước đặt tên và hướng dẫn của pub.dev về định dạng
Nhớ cập nhật CHANGELOG.md khi phát hành phiên bản mới
Package phải tương thích với các phiên bản Flutter đã nêu trong pubspec.yaml

Bạn có thể tham khảo thêm tài liệu chính thức: https://dart.dev/tools/pub/publishing

---
Mở file LICENSE trong package của bạn
Thay thế nội dung TODO bằng một giấy phép thực sự (ví dụ: MIT, BSD, Apache 2.0)
Ví dụ về một giấy phép MIT phổ biến:

MIT License

Copyright (c) 2025 [Tên của bạn]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Lưu file và chạy lại lệnh flutter pub publish

Nếu bạn không chắc chắn nên chọn loại giấy phép nào, MIT là một lựa chọn phổ biến cho các package mã nguồn mở vì nó đơn giản và cho phép việc sử dụng lại rộng rãi.