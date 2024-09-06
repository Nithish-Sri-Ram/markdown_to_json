import 'dart:convert';

/// Corrects a markdown string with improper JSON format (like single quotes)
/// and converts it to a proper JSON object.
///
/// [input] is the malformed JSON string.
/// Returns a `Map<String, dynamic>` representing the corrected JSON data.
Map<String, dynamic> convertMarkdownToJson(String input) {
  // Step 1: Replace single quotes in the keys and values with double quotes
  String correctedMarkdown = input
      .replaceAllMapped(RegExp(r"'(\w+)':"), (match) => '"${match[1]}":') // Replace single-quoted keys
      .replaceAllMapped(RegExp(r": '([^']*)'"), (match) => ': "${match[1]}"'); // Replace single-quoted values

  // Step 2: Fix escaped single quotes to regular single quotes
  correctedMarkdown = correctedMarkdown.replaceAll(r"\'", "'");

  // Step 3: Try to decode the corrected string as JSON
  Map<String, dynamic> markdownJson = {};
  try {
    markdownJson = jsonDecode(correctedMarkdown);
    print('Decoded JSON: $markdownJson');
  } catch (e) {
    print('Error decoding markdown: $e');
  }

  return markdownJson;
}


//Explaination
// The function replaces single-quoted keys and values with double quotes, which is required by JSON.
// It also handles escaped single quotes (\') by replacing them with regular single quotes.
// The corrected string is then decoded using jsonDecode.
// The function returns the decoded JSON as a Map<String, dynamic> or prints an error if decoding fails.
