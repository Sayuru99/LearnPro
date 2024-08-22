class ApiEndPoints {
  static final String baseUrl =
      'https://festive-clarke.93-51-37-244.plesk.page/api/v1';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  static _CourseEndPoints courseEndPoints = _CourseEndPoints();
}

class _AuthEndPoints {
  final String registerUser = '/register';
  final String loginUser = '/login';
  final String authUser = '/user';
  final String logoutUser = '/logout';
}

class _CourseEndPoints {
  final String courses = '/courses';
  final String course = '/courses/{course}';
  final String lessons = '/courses/{course}/lessons';
  final String lesson = '/courses/{course}/lessons/{lesson}';
}
