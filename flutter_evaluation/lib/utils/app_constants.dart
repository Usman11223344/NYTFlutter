class AppConstants {
  // App Name
  static const String appName = 'New York Times';

  // App Key
  static const String appKey = 'U7uMcUHvSKyhgAc8u34c1z630sFfBfTz';

  // Base URL
  static const String baseURL = 'https://api.nytimes.com/svc/';

  // API Version
  static const String version = "v2/";

  // API End Points
  static const String sharedURI =
      '${AppModules.mostPopular}$version/shared/1/facebook.json';
  static const String emailedURI =
      '${AppModules.mostPopular}$version/emailed/1.json';
  static const String viewedURI =
      '${AppModules.mostPopular}$version/viewed/7.json';
  static const String searchURI =
      '${AppModules.search}$version/articlesearch.json';

  // sharePreference
  static const String token = 'token';
  static const String theme = 'theme';
}

class AppModules {
  static const String mostPopular = 'mostpopular/';
  static const String search = 'search/';
}
