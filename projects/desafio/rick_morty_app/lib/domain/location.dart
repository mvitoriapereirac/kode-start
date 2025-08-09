class Location {
  late final int _id;
  final String name; 
  final String url;

  Location({required this.name, required this.url});

  int getId() {
    return _id;
  }

  String getName() {
    return name;
  }

  /// Define o valor do campo privado [_id].
  ///
  /// Se o parâmetro [id] for fornecido (não nulo), o valor será atribuído diretamente a [_id].
  /// Caso contrário, o método chama [_setIdFromUrl()] para tentar extrair o ID a partir da [url].
  ///
  /// Exemplo:
  /// ```dart
  /// location.setId(5);      // Define _id como 5
  /// location.setId(null);   // Extrai o ID da url e define _id com esse valor
  /// ```
  void setId(int? id) {
    if (id == null) {
      _setIdFromUrl();
      return;
    }
    _id = id;
  }

  /// Define o valor de [id] extraindo o número presente no final da [url].
  ///
  /// Este método utiliza uma expressão regular para encontrar um ou mais
  /// dígitos no final da [url]. Se encontrar, converte para inteiro e atribui a [id];
  /// caso contrário, define [id] como `0`.
  ///
  /// **Exemplo:**
  /// ```dart
  /// final loc = Location(url: 'https://rickandmortyapi.com/api/location/12');
  /// loc.setIdFromUrl(); // id será 12
  /// ```
  void _setIdFromUrl() {
    final match = RegExp(r'(\d+)$').firstMatch(url);
    if (match != null) {
      _id = int.parse(match.group(1)!);
      return;
    }

     //Valor inválido para evitar null exceptions do Dart
    _id = 0;
  }

  /// Cria uma instância de [Location] a partir de um [Map] retornado pela API.
  ///
  /// O parâmetro [map] deve conter pelo menos as chaves `'url'` e `'name'`, utilizadas para
  /// inicializar o objeto. A chave `'id'` é opcional neste momento
  /// e, caso esteja presente, será atribuída imediatamente.
  ///
  /// Se `'id'` não for fornecido, ele poderá ser definido
  /// posteriormente por meio de [setId].
  static fromMap(Map<String, dynamic> map) {
    var location = Location(url: map['url'], name: map['url']);

    //Método preparado para receber valor null no parâmetro
    location.setId(map['id']); 
    
    return location;
  }

}