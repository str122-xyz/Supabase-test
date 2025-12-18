import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'MASUKKAN_PROJECT_URL_DISINI', //Todo project url
    anonKey: 'MASUKKAN_ANON_PUBLIC_KEY_DISINI', //Todo public key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Supabase Image Test', home: const HomePage());
  }
}
