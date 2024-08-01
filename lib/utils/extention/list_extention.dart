extension ListItarable<E> on Iterable<E> {
  E? firstWhereNull(bool Function(E element) test, {E? Function()? orElse}) {
    for (E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
}
