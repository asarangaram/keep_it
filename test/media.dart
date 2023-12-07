// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../lib/data/db.dart';

class Media extends DBRow {
  final String path;
  final String? ref;

  static String tableName = 'Media';
  static String tableColumns = """
                path TEXT NOT NULL UNIQUE,
                ref TEXT,
                """;

  Media({
    super.id,
    required this.path,
    this.ref,
  });

  Media copyWith({
    String? path,
    String? ref,
  }) {
    return Media(
      path: path ?? this.path,
      ref: ref ?? this.ref,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'ref': ref,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['id'] as int?,
      path: map['path'] as String,
      ref: map['ref'] != null ? map['ref'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) =>
      Media.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Media(id: $id, path: $path, ref: $ref)';

  @override
  bool operator ==(covariant Media other) {
    if (identical(this, other)) return true;

    return other.path == path && other.ref == ref;
  }

  @override
  int get hashCode => path.hashCode ^ ref.hashCode;
}
