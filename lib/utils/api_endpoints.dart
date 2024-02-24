// ignore_for_file: unused_field, library_private_types_in_public_api

class API {
  static const String baseUrl =
      'https://tradeco-api-wyk7a4jpva-et.a.run.app/api/v1';

  static _AuthEndpoints authEndpoints = _AuthEndpoints();
  static _UserEndpoints userEndpoints = _UserEndpoints();
  static _ProjectEndpoints projectEndpoints = _ProjectEndpoints();
  static _BookmarkEndpoints bookmarkEndpoints = _BookmarkEndpoints();
  static _TipEndpoints tipEndpoints = _TipEndpoints();
  static _PostEndpoints postEndpoints = _PostEndpoints();
  static _WasteEndpoints wasteEndpoints = _WasteEndpoints();
  static _MessageEndpoints messageEndpoints = _MessageEndpoints();
}

class _AuthEndpoints {
  final String register = '/auth/register';
}

class _UserEndpoints {
  final String updateInstagram = '/user/instagram';
  final String updateLocation = '/user/location';
  final String deleteOne = '/user';
}

class _ProjectEndpoints {
  final String findAll = '/projects';
  String findOne(int id) => '/projects/$id';
}

class _BookmarkEndpoints {
  final String findAll = '/bookmarks/projects';
  final String createOne = '/bookmarks/project';
  String deleteOne(int id) => '/bookmarks/projects/$id';
}

class _TipEndpoints {
  final String findAll = '/tips';
  String findOne(int id) => '/tips/$id';
  final String randomTips = '/tips/random';
}

class _PostEndpoints {
  final String findAll = '/posts';
  final String createOne = '/post';
}

class _WasteEndpoints {
  final String findAll = '/wastes';
  final String createOne = '/waste';
  String deleteOne(int id) => '/wastes/$id';
  final String getSuggestion = '/wastes/project-suggestions';
}

class _MessageEndpoints {
  String findAll(int userId) => '/messages/$userId';
  final String createOne = '/message';
}
