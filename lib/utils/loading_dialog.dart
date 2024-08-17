import 'package:flutter/material.dart';

/// `LoadingScreen` adalah kelas yang menyediakan metode untuk menampilkan
/// dan menyembunyikan layar loading (dialog) dengan pesan kustom di aplikasi.
class LoadingScreen {
  // Private constructor untuk mencegah pembuatan instance dari kelas ini.
  LoadingScreen._();

  /// Menampilkan dialog loading dengan pesan kustom yang tidak bisa ditutup
  /// dengan menekan di luar dialog (non-dismissible).
  ///
  /// `text` adalah pesan yang akan ditampilkan di dalam dialog.
  static show(BuildContext context, String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _customDialog(context, text),
          );
        });
  }

  /// Menyembunyikan dialog loading yang sedang ditampilkan.
  static hide(BuildContext context) {
    Navigator.pop(context);
  }

  /// Membangun tampilan dialog kustom yang berisi indikator loading
  /// dan teks pesan.
  ///
  /// [text] adalah pesan yang akan ditampilkan di dalam dialog.
  static _customDialog(BuildContext context, String text) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
