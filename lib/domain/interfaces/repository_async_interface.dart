abstract class RepositoryAsyncInterface<T, R> {
  Future<void> add(T data);
  Future<void> addAll(R data);
  Future<void> update(T data);
  Future<void> deleteById(int id);
  Future<R> getAll();
  Future<T?> getById(int id);
  Future<void> clear();
  Future<bool> isEmpty();
}
