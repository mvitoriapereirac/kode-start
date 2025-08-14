enum Status {
  alive('Alive'),
  dead('Dead'),
  unknown('unknown');

  final String value;
  const Status(this.value);

  static Status fromString(String? str) {
    if (str == null) return Status.unknown;

    return Status.values.firstWhere(
      (g) => g.value.toLowerCase() == str.toLowerCase(),
      orElse: () => Status.unknown,
    );
  }
}