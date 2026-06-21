class AppConstants {
  static const String supabaseBaseUrl =
      "https://tlkyqfrgpdrwkbvjicsl.supabase.co/storage/v1/object/public/hee/";

  static const String artistFolder = "artist";
  static const String songFolder = "song";
  static const String albumFolder = "album";

  static String getImageUrl(String folder, String fileName) {
    return "$supabaseBaseUrl$folder/$fileName";
  }
}
