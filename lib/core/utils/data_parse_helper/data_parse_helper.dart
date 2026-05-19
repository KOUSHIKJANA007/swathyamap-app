class DataParseHelper {
  DataParseHelper._();

  static DateTime safeDate(dynamic value) {
    final parsed = DateTime.tryParse(value?.toString() ?? '');
    return parsed ?? DateTime.now();
  }

  static DateTime? getDateOrNull(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  static int safeInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static List<T> safeList<T>(
      dynamic data, {
        T Function(dynamic)? parser,
      }) {
    if (data is List) {
      return data.map<T>((e) {
        if (parser != null) {
          return parser(e);
        }
        return e as T; // fallback cast
      }).toList();
    }
    return [];
  }

  static String normalizeAndCapitalize(String input) {
    if (input.trim().isEmpty) return '';

    // Replace underscores with spaces
    String normalized = input.replaceAll('_', ' ');

    // Split by spaces (handle multiple spaces too)
    List<String> words = normalized.split(RegExp(r'\s+'));

    // Convert each word to Title Case
    List<String> formattedWords = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join back with single space
    return formattedWords.join(' ');
  }
}