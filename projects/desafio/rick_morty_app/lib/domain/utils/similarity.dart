/// Calcula o índice de Jaccard entre dois conjuntos.
///
/// Retorna um valor entre 0.0 (nenhuma similaridade) e 1.0 (conjuntos idênticos).
double jaccardIndex<T>(Set<T> a, Set<T> b) {
  if (a.isEmpty && b.isEmpty) return 1.0;
  final intersectionCount = a.intersection(b).length;
  final unionCount = a.union(b).length;

  return unionCount == 0 ? 0.0 : intersectionCount / unionCount;
}