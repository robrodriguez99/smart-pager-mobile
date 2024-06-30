import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class MenuView extends StatefulWidget {
  final String menu;

  const MenuView({Key? key, required this.menu}) : super(key: key);
  @override
  State<MenuView> createState() => _MenuState();
}

class _MenuState extends State<MenuView> {
  bool _isLoading = true;
  late PDFDocument _pdf;

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromURL(widget.menu);

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
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: SPColors.activeBlack,
            size: 30,
          ),
        ),
        title: const CustomText(
          text: 'Menú',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: _pdf,
                  zoomSteps: 1,
                  maxScale: 2.0,
                )),
    );
  }
}
