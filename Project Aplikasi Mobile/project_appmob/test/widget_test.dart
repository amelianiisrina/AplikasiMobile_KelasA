
import 'package:flutter_test/flutter_test.dart';
import 'package:project_appmob/main.dart';

void main() {
  testWidgets('Project Appmob menampilkan halaman login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProjectAppmob());

    expect(find.text('Selamat Datang!'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
