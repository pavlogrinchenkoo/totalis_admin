List<String> getTitlesCustom({required List<dynamic>? items}) {
  if (items != null && items.isNotEmpty) {
    final first = items.first.toJson();
    final keys = <String>[];
    keys.addAll(first.keys);

    return keys;
  } else {
    return [];
  }
}

String getFileExtension(String fileName) {
  try {
    return ".${fileName.split('.').last}";
  } catch (e) {
    return '';
  }
}
