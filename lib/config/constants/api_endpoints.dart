/// All API base URLs and path constants used across the app.
///
/// Never hardcode API URLs in services — always reference this file.
class ApiEndpoints {
  ApiEndpoints._();

  // ─── Firebase Cloud Functions ──────────────────────────────────────
  static const String cloudFunctionsBase =
      'https://us-central1-threadsense-app.cloudfunctions.net';
  static const String getRecommendations =
      '$cloudFunctionsBase/getRecommendations';
  static const String refreshTrending = '$cloudFunctionsBase/refreshTrending';

  // ─── Google Shopping Content API ───────────────────────────────────
  static const String googleShoppingBase =
      'https://shoppingcontent.googleapis.com/content/v2.1';

  // ─── ShopStyle Collective API (alternative) ────────────────────────
  static const String shopStyleBase = 'https://api.shopstyle.com/api/v2';
  static const String shopStyleProducts = '$shopStyleBase/products';
  static const String shopStyleCategories = '$shopStyleBase/categories';

  // ─── Rakuten Affiliate API ─────────────────────────────────────────
  static const String rakutenBase =
      'https://api.linksynergy.com/linklocator/1.0';
}
