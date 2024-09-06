class Collaborator {
  int? id;
  String? collaboratorsName;
  int? accountId;
  String? domain;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userCreated;
  int? userUpdated;

  Collaborator({
    this.id,
    this.collaboratorsName,
    this.accountId,
    this.domain,
    this.createdAt,
    this.updatedAt,
    this.userCreated,
    this.userUpdated,
  });

  factory Collaborator.fromJson(Map<String, dynamic> json) => Collaborator(
        id: json['id'] as int?,
        collaboratorsName: json['collaborators_name'] as String?,
        accountId: json['account_id'] as int?,
        domain: json['domain'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        userCreated: json['user_created'] as int?,
        userUpdated: json['user_updated'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'collaborators_name': collaboratorsName,
        'account_id': accountId,
        'domain': domain,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_created': userCreated,
        'user_updated': userUpdated,
      };
}
