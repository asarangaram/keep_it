// ignore_for_file: public_member_api_docs, sort_constructors_first

class Tag  {
  int? id;
  String label;
  String? description;
  Tag({
    this.id,
    required this.label,
    this.description,
  });

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  Tag copyWith({
    int? id,
    String? label,
    String? description,
  }) {
    return Tag(
      id: id ?? this.id,
      label: label ?? this.label,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'Tag(id: $id, label: $label, description: $description)';

  @override
  bool operator ==(covariant Tag other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.label == label &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ description.hashCode;
}
