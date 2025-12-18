import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bhvnczdawzgyljukdvvi.supabase.co', //Project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJodm5jemRhd3pneWxqdWtkdnZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwNzA1NzIsImV4cCI6MjA4MTY0NjU3Mn0.-igzqfDqtE8glX99I41IuLs7JoHOZ-yz0tpP44Etu84', //API Key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase Image Test',
      home: const HomePage(),
    );
  }
}
