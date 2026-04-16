import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/core/network/client_http.dart';
import 'package:product_app/data/datasources/product_cache_datasource.dart';
import 'package:product_app/data/datasources/product_remote_datasource.dart';
import 'package:product_app/data/repositories/product_repository_impl.dart';

import 'package:product_app/main.dart';
import 'package:product_app/presentation/viewmodels/product_viewmodel.dart';

void main() {
  testWidgets('exibe botao para abrir tela de produtos', (
    WidgetTester tester,
  ) async {
    final client = HttpClient();
    final remote = ProductRemoteDatasource(client);
    final cache = ProductCacheDatasource();
    final repository = ProductRepositoryImpl(remote, cache);
    final viewModel = ProductViewModel(repository);

    await tester.pumpWidget(MyApp(viewModel: viewModel));

    expect(find.text('Abrir tela de produtos'), findsOneWidget);
  });
}
