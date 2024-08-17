import 'package:flutter/material.dart';

/// `CustomButton` adalah widget tombol kustom yang dapat digunakan di seluruh aplikasi.
/// Tombol ini memungkinkan pengembang untuk menentukan teks, ukuran, dan fungsi yang akan dijalankan ketika tombol ditekan.
class CustomButton extends StatelessWidget {
  // Konstruktor untuk `CustomButton`. Parameter `text` wajib diisi,
  // sementara `onPressed`, `height`, dan `width` opsional.
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height = 52,
    this.width = double.infinity,
  });

  final Function()? onPressed;
  final String text;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
