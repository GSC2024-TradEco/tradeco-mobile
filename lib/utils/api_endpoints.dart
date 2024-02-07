class ApiEndpoints {
  static const String baseUrl = 'http://10.0.0.2/api/v1';
}

class AuthEndpoints {
  static const String register = 'auth/register';
}

class ProjectEndpoints {
  static const String findAll = '/projects';
  static String findOne(int id) => '/projects/$id';
}

class BookmarkEndpoints {
  static const String findAll = '/bookmarks/projects';
  static const String createOne = '/bookmarks/project';
  static String deleteOne(int id) => '/bookmarks/projects/$id';
}

class TipEndpoints {
  static const String findAll = '/tips';
  static String findOne(int id) => '/tips/$id';
}

class PostEndpoints {
  static const String findAll = '/posts';
  static const String createOne = '/post';
}

class WasteEndpoints {
  static const String shareWaste = '/wastes/share';
  static const String getSuggestion = '/wastes/project-suggestions';
}
