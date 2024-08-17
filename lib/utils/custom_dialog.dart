import 'package:flutter/material.dart';

/// `CustomDialog` adalah kelas yang menampilkan
/// dialog sederhana dengan judul, isi, dan tombol 'OK'.
class CustomDialog {
  /// Menampilkan dialog dengan judul dan detail yang diberikan.
  ///
  /// [title] adalah teks yang akan ditampilkan sebagai judul dialog.
  /// [details] adalah teks yang akan ditampilkan sebagai isi/konten dialog.
  static show(
    BuildContext context, {
    required String title,
    required String details,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(details),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
