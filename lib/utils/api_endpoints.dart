// ignore_for_file: unused_field, library_private_types_in_public_api

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
  String register = '/auth/register';
}

class _ProjectEndpoints {
  String findAll = '/projects';
  String findOne(int id) => '/projects/$id';
}

class _BookmarkEndpoints {
  String findAll = '/bookmarks/projects';
  String createOne = '/bookmarks/project';
  String deleteOne(int id) => '/bookmarks/projects/$id';
}

class _TipEndpoints {
  String findAll = '/tips';
  String findOne(int id) => '/tips/$id';
}

class _PostEndpoints {
  String findAll = '/posts';
  String createOne = '/post';
}

class _WasteEndpoints {
  String shareWaste = '/wastes/share';
  String getSuggestion = '/wastes/project-suggestions';
}
