class UsernameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Tên đăng nhập không được để trống";
    } else if (value.contains('@')) {
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return "Email không hợp lệ";
      }
    } else {
      return null;
    }
  }
}