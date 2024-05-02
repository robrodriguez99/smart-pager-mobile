import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuState();
}

class _MenuState extends State<MenuView> {
  bool _isLoading = true;
  late PDFDocument _pdf;

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromURL(
        'https://www.kindacode.com/wp-content/uploads/2021/07/test.pdf'); //TODO: CHECKEAR CON EMULADOR

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(document: _pdf)),
    );
  }
}