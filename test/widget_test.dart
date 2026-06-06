import 'package:flutter_test/flutter_test.dart';
import 'package:simbiotiktask/main.dart';
import 'package:simbiotiktask/views/splash/splash_screen.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HireHubApp());

    // Verify that SplashScreen is in the widget tree on launch
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
