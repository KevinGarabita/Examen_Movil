abstract interface class Handler<U, T> {
  Future<T> execute(U input);
}
