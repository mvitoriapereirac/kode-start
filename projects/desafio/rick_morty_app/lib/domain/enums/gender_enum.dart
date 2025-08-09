enum Gender {
  male('Male'), 
  female('Female'),
  genderless('Genderless'),
  unknown('unknown');

  final String value;
  const Gender(this.value);

  static Gender fromString(String? str) {
    if (str == null) return Gender.unknown;

    return Gender.values.firstWhere(
      (g) => g.value.toLowerCase() == str.toLowerCase(),
      orElse: () => Gender.unknown,
    );
  }
}