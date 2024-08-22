class ApiEndPoints {
  static final String baseUrl =
      'https://festive-clarke.93-51-37-244.plesk.page/api/v1';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerUser = '/register';
  final String loginUser = '/login';
  final String authUser = '/user';
  final String logoutUser = '/logout';
}
