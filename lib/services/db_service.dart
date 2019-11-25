import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalgat_courier/models/product.dart';
import 'package:dalgat_courier/models/user.dart';

typedef Query QueryBuilder(CollectionReference collectionReference);

class DBService {
  /// Firestore instance
  static final Firestore _fs = Firestore.instance;

  /// Unfortunately dart doesn't support static inheritance so instead we have to
  /// initialize the class to get its instance methods
  final Map<Type, dynamic> _models = {
    Product: Product(),
    User: User(),
  };

  Future<T> create<T extends DBModel>(T entity) async {
    await _getCollection<T>().document(entity.id).setData(entity.toMap());
    return entity;
  }

  Stream<List<T>> read<T extends DBModel>([QueryBuilder queryBuilder]) {
    var collection = _getCollection<T>();
    var query = queryBuilder != null ? queryBuilder(collection) : collection;

    return query.snapshots().asyncMap<List<T>>((snapshot) => (snapshot.documents
        .map<T>((document) =>
            _model<T>().fromMap({...document.data, 'id': document.documentID}))
        .toList()));
  }

  Future<T> findById<T extends DBModel>(
      {String id, QueryBuilder queryBuilder}) async {
    var document = await _getCollection<T>().document(id).get();

    if (document == null) return null;

    return _model<T>().fromMap({...document.data, 'id': document.documentID});
  }

  Future<void> update<T extends DBModel>(String id, T entity,
      [bool merge = true]) {
    return _getCollection<T>()
        .document(id)
        .setData(entity.toMap(), merge: merge);
  }

  T _model<T extends DBModel>() => _models[T] as T;

  CollectionReference _getCollection<T extends DBModel>() {
    return _fs.collection(_model<T>().collectionName);
  }
}

abstract class DBModel<T> {
  String get collectionName;
  String get id;

  Map<String, dynamic> toMap();
  T fromMap(Map<String, dynamic> map);
}
