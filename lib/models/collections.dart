import '../constants.dart';
import 'collection.dart';

List<List<T>> paginate<T>(List<T> list, int pageLength) {
  List<List<T>> pages = [];
  for (int i = 0; i < list.length; i += pageLength) {
    int end = (i + pageLength < list.length) ? i + pageLength : list.length;
    pages.add(list.sublist(i, end));
  }
  return pages;
}

class Collections {
  final List<Collection> collections;
  late final List<List<Collection>> pages;
  Collections(this.collections) {
    pages = paginate(collections, Constants.collectionsPerPage);
  }
  int get pageMax => pages.length;

  List<Collection> page(int pageNum) {
    if (pageNum > pageMax) {
      throw Exception("Invalid page");
    }
    return pages[pageNum];
  }

  bool get isEmpty => collections.isEmpty;
  bool get isNotEmpty => collections.isNotEmpty;
}
