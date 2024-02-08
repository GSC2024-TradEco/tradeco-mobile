class API {
  static const String baseUrl = 'http://10.0.0.2/api/v1';
  
  static _AuthEndpoints authEndpoints = _AuthEndpoints();
  static _ProjectEndpoints projectEndpoints = _ProjectEndpoints();
  static _BookmarkEndpoints bookmarkEndpoints = _BookmarkEndpoints();
  static _TipEndpoints tipEndpoints = _TipEndpoints();
  static _PostEndpoints postEndpoints = _PostEndpoints();
  static _WasteEndpoints wasteEndpoints = _WasteEndpoints();
}

class _AuthEndpoints {
  static const String register = '/auth/register';
}

class _ProjectEndpoints {
  static const String findAll = '/projects';
  static String findOne(int id) => '/projects/$id';
}

class _BookmarkEndpoints {
  static const String findAll = '/bookmarks/projects';
  static const String createOne = '/bookmarks/project';
  static String deleteOne(int id) => '/bookmarks/projects/$id';
}

class _TipEndpoints {
  static const String findAll = '/tips';
  static String findOne(int id) => '/tips/$id';
}

class _PostEndpoints {
  static const String findAll = '/posts';
  static const String createOne = '/post';
}

class _WasteEndpoints {
  static const String shareWaste = '/wastes/share';
  static const String getSuggestion = '/wastes/project-suggestions';
}
