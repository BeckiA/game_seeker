import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_seeker/features/gaming/presentation/pages/gaming_home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init(); // Initialize the "glue"
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAWG Flutter DDD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GamingHomePage(), // We will create this next
    );
  }
}
