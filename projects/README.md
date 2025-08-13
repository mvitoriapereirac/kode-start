# Rick and Morty App

Um aplicativo Flutter que consome a API do Rick and Morty, que conta com listagem de personagens paginada com scroll infinito e pull-to-refresh, algoritmo de recomendações com base em similaridade de personagens e funcionalidade de eleger personagens favoritos.

## 📋 Sobre o Projeto

Este projeto foi desenvolvido seguindo fielmente a [documentação oficial de arquitetura do Flutter](https://docs.flutter.dev/app-architecture), implementando uma arquitetura em camadas com foco na separação de responsabilidades e manutenibilidade do código.

Alguns dos princípios discutidos na documentação e aplicados no projeto:
- Arquitetura intencional;
- Princípio arquitetural de separação de camadas e divisão clara de responsabilidades;
- Adoção de arquitetura recomendada pelo time do Flutter;
- MVVM e gerenciamento de estado
- Injeção de dependência

## 🏗️ Arquitetura

O projeto segue uma arquitetura em camadas bem definida:

### Camadas da Aplicação

```
lib/
├── domain/           # Camada de Domínio (Entidades e Contratos)
├── data/            # Camada de Dados (Implementações e APIs)
├── ui/              # Camada de Apresentação (Widgets e ViewModels)
└── routing/         # Configuração de Rotas
```

### Domain Layer
- **Entidades**: Modelos de domínio (`Character`, etc.)
- **Repositórios**: Contratos/interfaces abstratas
- **ViewModels**: Lógica de negócio e estado da UI

### Data Layer
- **Repositórios**: Implementações concretas dos contratos de domínio
- **APIs**: Comunicação com serviços externos (Rick and Morty API)
- **Storage**: Persistência local (SharedPreferences)

### UI Layer
- **Screens**: Páginas da aplicação
- **Widgets**: Componentes reutilizáveis
- **ViewModels**: Gerenciamento de estado com ChangeNotifier

## ⚠️ Nota Arquitetural

> **Importante**: Este projeto replica um padrão presente na documentação oficial do Flutter onde abstrações de repository (camada de domínio) estendem `ChangeNotifier` (conceito de UI). Embora funcional e, em muitos casos, suficiente, isso tecnicamente quebra a separação de responsabilidades, pois a camada de domínio não deveria conhecer conceitos da camada de apresentação. Em projetos enterprise, seria mais apropriado usar BLoC ou uma implementação de ViewModel que não dependa diretamente do framework.

## 🛠️ Tecnologias e Ferramentas

### Principais Dependencies
- **go_router**: Navegação declarativa e type-safe
- **provider**: Gerenciamento de estado e injeção de dependência
- **shared_preferences**: Persistência local de dados
- **http**: Comunicação com APIs REST

### Padrões de Projeto Implementados

#### 1. Injeção de Dependência
```dart
// Configuração no main.dart
MultiProvider(
  providers: [
    Provider<CharacterRepository>(
      create: (_) => CharacterRepositoryImpl(),
    ),
    Provider<FavoritesRepository>(
      create: (_) => FavoritesRepositoryImpl(),
    ),
    ChangeNotifierProvider<CharactersViewModel>(
      create: (context) => CharactersViewModel(
        characterRepo: context.read<CharacterRepository>(),
        favoritesRepo: context.read<FavoritesRepository>(),
      ),
    ),
  ],
  child: MyApp(),
)
```

#### 2. Singleton Pattern
Implementado no serviço de API para garantir uma única instância durante o ciclo de vida da aplicação.

#### 3. Repository Pattern
Abstração da camada de dados com contratos bem definidos:

```dart
abstract class CharacterRepository {
  Future<ApiResult<List<Character>>> getCharactersList(int? page);
  Future<ApiResult<Character>> getCharacterById(String id);
}
```

## 🚀 Funcionalidades

### 1. Carregamento Lazy e Paginado
- **Infinite Scroll**: Carregamento automático ao chegar no final da lista
- **Pagination**: Implementação eficiente de paginação da API
- **Pull to Refresh**: Atualização da lista puxando para baixo
- **Loading States**: Indicadores visuais durante carregamentos

### 2. Sistema de Favoritos
- Persistência local usando SharedPreferences
- Toggle de favoritos em tempo real
- Filtro dedicado para visualizar apenas favoritos
- Sincronização de estado entre diferentes telas

### 3. Algoritmo de Similaridade
Implementação do **Coeficiente de Jaccard** para calcular similaridade entre personagens, com base na interseção de episódios em que aparecem.

### 4. Navegação Robusta
- **Go Router**: Navegação type-safe e declarativa
- **Deep Linking**: Suporte a navegação por URLs
- **Route Management**: Organização clara das rotas da aplicação

## 🎨 Interface do Usuário

### Características do Design
- **Custom Components**: Componentes reutilizáveis e consistentes
- **Orientadas a design**: Fortemente baseada no protótipo informado no Figma (preocupação com fidedignidade de ícones, dimensões e tamanhos).


### Componentes Principais
- `CharacterCard`: Card reutilizável para exibição de personagens
- `CustomTabSwitch`: Alternador entre personagens: "Todos" e "Favoritos"
- `AppBarComponent`: AppBar customizada e consistente
- `ErrorMessageComponent`: Tratamento visual de erros

## 🔄 Fluxo de Dados

```
API → Repository → ViewModel → UI
 ↓
SharedPreferences (Favoritos)
```

1. **API Layer**: Faz requisições para a Rick and Morty API
2. **Repository**: Processa dados e aplica regras de negócio
3. **ViewModel**: Gerencia estado e notifica mudanças
4. **UI**: Reage às mudanças de estado e atualiza interface

## 📱 Funcionalidades Implementadas

- ✅ Lista de personagens com scroll infinito
- ✅ Detalhes do personagem
- ✅ Sistema de favoritos persistente
- ✅ Filtro por favoritos
- ✅ Pull to refresh
- ✅ Carregamento paginado
- ✅ Algoritmo de personagens relacionados
- ✅ Navegação fluida entre telas
- ✅ Tratamento de erros
- ✅ Estados de loading

## 🛡️ Tratamento de Erros

O aplicativo implementa tratamento de erros:
- **Network Errors**: Tratamento de falhas de conectividade
- **API Errors**: Handling de erros da API externa
- **User Feedback**: Informação de indisponibilidade disponível para usuário

## 🔧 Como Executar

1. **Clone o repositório**
```bash
git clone [url-do-repositorio]
cd rick_morty_app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**
```bash
flutter run
```

## 📚 Estrutura de Pastas Detalhada

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── domain/                      # Camada de Domínio
│   ├── character.dart           # Entidade Character
│   ├── character_repository.dart # Contrato do repositório
│   └── favorites_repository.dart # Contrato de favoritos
│   └── episode_repository.dart # Contrato de episodios
│   └── ... (outros elementos)
├── data/                        # Camada de Dados
│   ├── character_repo.dart
│   └── favorites_repo.dart
│   └── ... (outros elementos)
│   └── ... api_service.dart
├── ui/                          # Camada de Apresentação
│   ├── characters_list/         # Tela de lista
│   ├── character_details/       # Tela de detalhes
│   ├── character_details/       # Tela de detalhes
│   └── ... (outros elementos)
│   └── core/                    # Componentes compartilhados
└── routing/                     # Configuração de rotas
    └── router.dart
```

## 🎯 Próximas Implementações

- [ ] Busca por personagens
- [ ] Filtros avançados (status, espécie, gênero)
- [ ] Modo offline com cache
- [ ] Animações de transição
- [ ] Testes unitários e de widget

## 📋 Considerações Técnicas

### Performance
- **Lazy Loading**: Carregamento sob demanda
- **Image Caching**: Cache automático de imagens
- **State Management**: Otimização de rebuilds

### Escalabilidade
- **Clean Architecture**: Facilita manutenção e extensão
- **Dependency Injection**: Desacoplamento entre camadas
- **Repository Pattern**: Abstração da camada de dados

---

**Desenvolvido seguindo as diretrizes oficiais de arquitetura do Flutter com foco em clean code e separação de responsabilidades.**