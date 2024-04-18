class CollectionKeys {
  static final CollectionKeys _instance = CollectionKeys._internal();

  factory CollectionKeys() {
    return _instance;
  }

  CollectionKeys._internal();

  String get usersKey => 'users';
  String get firstName => 'first_name';
  String get lastName => 'last_name';
  String get email => 'email';
  String get id => 'id';
  String get createdAt => 'created_at';
}
