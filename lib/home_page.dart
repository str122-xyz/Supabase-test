import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _publicImageUrl;
  bool _isUploading = false;
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _pickAndUploadToPublicBucket() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() => _isUploading = true);

    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${picked.name}';
      final filePath = 'uploads/$fileName';

      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        await supabase.storage
            .from('bucket_images')
            .uploadBinary(
              filePath,
              bytes,
              fileOptions: const FileOptions(contentType: 'image/*'),
            );
      } else {
        final file = File(picked.path);
        await supabase.storage.from('bucket_images').upload(filePath, file);
      }

      final publicUrl = supabase.storage
          .from('bucket_images')
          .getPublicUrl(filePath);

      setState(() {
        _publicImageUrl = publicUrl;
      });
    } catch (e) {
      debugPrint('Error Upload: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed Upload: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), actions: const []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: []),
      ),
    );
  }
}
