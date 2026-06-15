# Product App — Flutter + API REST

Aplicativo Flutter desenvolvido como projeto acadêmico para a disciplina de Desenvolvimento Mobile. O objetivo é demonstrar na prática o consumo de uma API REST, autenticação com JWT, navegação entre telas e boas práticas de arquitetura em camadas.

## Funcionalidades

- Login com autenticação via API (`dummyjson.com/auth`)
- Listagem de produtos com imagem, preço e estoque
- Tela de detalhes de cada produto
- Marcar/desmarcar produtos como favoritos (em memória durante a sessão)
- Logout e proteção de rotas — telas acessíveis apenas com sessão ativa

## API utilizada

[DummyJSON](https://dummyjson.com) — API pública gratuita para testes, sem necessidade de cadastro.

| Endpoint | Descrição |
|---|---|
| `POST /auth/login` | Autenticação e geração de token JWT |
| `GET /auth/me` | Dados do usuário autenticado |
| `GET /products` | Lista todos os produtos |
| `GET /products/:id` | Detalhes de um produto |

**Credenciais de teste:**

```
Usuário: emilys
Senha:   emilyspass
```

## Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.11
- Dart >= 3.11
- Android Studio / VS Code com extensão Flutter
- Emulador Android/iOS ou dispositivo físico

Verifique se o ambiente está configurado:

```bash
flutter doctor
```

## Como rodar

```bash
# 1. Entre na pasta do projeto Flutter
cd product_app

# 2. Instale as dependências
flutter pub get

# 3. Execute o app (com um emulador/dispositivo conectado)
flutter run
```

Para escolher um dispositivo específico:

```bash
flutter devices          # lista os dispositivos disponíveis
flutter run -d <id>      # roda no dispositivo desejado
```

Para build de produção:

```bash
flutter build apk        # Android
flutter build ios        # iOS (requer macOS)
```

## Estrutura de pastas

```
lib/
├── main.dart
├── models/          # Entidades de dados (Product, AuthUser)
├── services/        # Chamadas HTTP (AuthService, ProductService)
├── session/         # Estado de sessão e favoritos em memória
├── pages/           # Telas principais (Login, Listagem, Detalhe)
└── widgets/         # Componentes reutilizáveis
```

---

## Questões sobre Arquitetura

### 1. Em qual camada foi implementado o mecanismo de cache? Por que essa decisão é adequada?

O mecanismo de cache foi implementado na **camada de dados** (`data/`), mais especificamente na classe `ProductCacheDatasource` (`data/datasources/product_cache_datasource.dart`).

Essa decisão é adequada porque a camada de dados é a única responsável por saber *de onde* os dados vêm — seja da rede, de um banco local ou de memória. O cache é uma estratégia de acesso a dados, não uma regra de negócio. Ao mantê-lo na camada de dados, o `ProductRepositoryImpl` pode encapsular toda a lógica de fallback (tentar a rede, salvar no cache, usar o cache se a rede falhar) sem expor esses detalhes para as camadas superiores. O `ViewModel` e a interface continuam chamando `repository.getProducts()` sem saber nada sobre a existência do cache, preservando a separação de responsabilidades.

---

### 2. Por que o ViewModel não deve realizar chamadas HTTP diretamente?

O `ViewModel` não deve realizar chamadas HTTP diretamente pelos seguintes motivos:

- **Violação da separação de responsabilidades**: o `ViewModel` é responsável por gerenciar o estado da UI e expor dados à interface. Se ele também fizer chamadas HTTP, passa a acumular responsabilidades de infraestrutura que não lhe pertencem.
- **Alto acoplamento**: o `ViewModel` ficaria diretamente dependente de detalhes de implementação (URL, biblioteca HTTP, formato de resposta), dificultando qualquer mudança futura na fonte de dados.
- **Dificuldade de testes**: chamadas HTTP diretas tornam o `ViewModel` impossível de testar sem acesso à rede real. Com a dependência no contrato abstrato `ProductRepository`, basta injetar um mock nos testes.
- **Inversão de dependência**: na arquitetura proposta, o `ViewModel` depende de uma abstração (`ProductRepository`), não de uma implementação concreta. Isso mantém o fluxo de dependências correto — das camadas externas para as internas, nunca o contrário.

---

### 3. O que poderia acontecer se a interface acessasse diretamente o DataSource?

Se a interface (`ProductPage`) acessasse o `ProductRemoteDatasource` ou o `ProductCacheDatasource` diretamente, as consequências seriam:

- **Acoplamento total entre UI e infraestrutura**: a interface passaria a conhecer detalhes como URLs, tokens HTTP e estrutura de `ProductModel`, que são preocupações exclusivas da camada de dados.
- **Bypass das regras de negócio e de orquestração**: toda a lógica do `ProductRepositoryImpl` (tentar rede, salvar cache, usar fallback, lançar `Failure`) seria ignorada. A interface teria que reimplementar essa lógica, espalhando responsabilidades pelo código.
- **Dados crus chegando à UI**: o `DataSource` retorna `ProductModel` (um DTO com lógica de JSON), não a entidade de domínio `Product`. A interface receberia objetos inadequados para a camada de apresentação.
- **Impossibilidade de trocar a implementação**: se a fonte de dados mudasse (ex.: trocar REST por GraphQL), seria necessário alterar diretamente os Widgets, quebrando o princípio aberto/fechado.
- **Testes inviáveis**: testar a UI exigiria subir toda a camada de rede, impedindo testes unitários isolados.
