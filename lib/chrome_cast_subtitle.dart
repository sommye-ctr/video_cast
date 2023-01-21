// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChromeCastSubtitle {
  /// Unique id for subtitle track.
  final double id;

  /// Name of subtitle track.
  final String name;

  /// Source of subtitle track.
  final String source;

  /// Language of subtitle track. Eg en-US
  final String language;
  ChromeCastSubtitle({
    required this.id,
    required this.name,
    required this.source,
    required this.language,
  });

  ChromeCastSubtitle copyWith({
    double? id,
    String? name,
    String? source,
    String? language,
  }) {
    return ChromeCastSubtitle(
      id: id ?? this.id,
      name: name ?? this.name,
      source: source ?? this.source,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'source': source,
      'language': language,
    };
  }

  factory ChromeCastSubtitle.fromMap(Map<String, dynamic> map) {
    return ChromeCastSubtitle(
      id: map['id'] as double,
      name: map['name'] as String,
      source: map['source'] as String,
      language: map['language'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChromeCastSubtitle.fromJson(String source) =>
      ChromeCastSubtitle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChromeCastSubtitle(id: $id, name: $name, source: $source, language: $language)';
  }

  @override
  bool operator ==(covariant ChromeCastSubtitle other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.source == source &&
        other.language == language;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ source.hashCode ^ language.hashCode;
  }
}
