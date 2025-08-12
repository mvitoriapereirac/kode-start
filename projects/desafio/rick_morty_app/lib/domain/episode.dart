class Episode {
  late final int _id; 
  late final String name; 
  final String url;

  Episode({required this.url}) {
    _setIdFromUrl();
  }
  /// Define o valor do campo privado [_id].
  ///
  /// Se o parâmetro [id] for fornecido (não nulo), o valor será atribuído diretamente a [_id].
  /// Caso contrário, o método chama [_setIdFromUrl()] para tentar extrair o ID a partir da [url].
  ///
  /// Exemplo:
  /// ```dart
  /// episode.setId(5);      // Define _id como 5
  /// episode.setId(null);   // Extrai o ID da url e define _id com esse valor
  /// ```
  void setId(int? id) {
    if (id == null) {
      _setIdFromUrl();
      return;
    }
    _id = id;
  }

  void setName(String? name) {
    this.name = name ?? '';
  }

  int? getId() {
    return _id;
  }

  String getName() {
    return name;
  }

  /// Define o valor de [id] extraindo o número presente no final da [url].
  ///
  /// Este método utiliza uma expressão regular para encontrar um ou mais
  /// dígitos no final da [url]. Se encontrar, converte para inteiro e atribui a [id];
  /// caso contrário, define [id] como `0`.
  ///
  /// **Exemplo:**
  /// ```dart
  /// final ep = Episode(url: 'https://rickandmortyapi.com/api/episode/12');
  /// ep.setIdFromUrl(); // id será 12
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

  /// Cria uma instância de [Episode] a partir de um [Map] retornado pela API.
  ///
  /// O parâmetro [map] deve conter pelo menos a chave `'url'`, utilizada para
  /// inicializar o objeto. As chaves `'id'` e `'name'` são opcionais neste momento
  /// e, caso estejam presentes, serão atribuídas imediatamente.
  ///
  /// Se `'id'` e/ou `'name'` não forem fornecidos, eles poderão ser definidos
  /// posteriormente por meio de [setId] e [setName].
  static fromMap(Map<String, dynamic> map) {
    var episode = Episode(url: map['url']);

    int? id = episode.getId();
    if (id == null) {
      episode.setId(map['id']); 
    }
    episode.setName(map['name']);
    
    return episode;
  }
}