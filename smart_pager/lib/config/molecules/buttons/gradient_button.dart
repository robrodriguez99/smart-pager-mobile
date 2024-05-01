import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';

class GradientButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final Color? textColor;
  final double? width, height, fontSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final IconData? icon; // Nuevo parámetro para el icono

  const GradientButton({
    Key? key,
    this.text,
    this.onPressed,
    this.gradientColors,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.borderRadius,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.icon, // Inicialización del nuevo parámetro
  }) : super(key: key);

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.maxFinite,
      height: widget.height ?? 52,
      child: GestureDetector(
        onTapDown: (details) {
          setState(() {
            _isPressed = true;
          });
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        onTapUp: (details) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: _isPressed
                  ? (
                      widget.gradientColors != null ? 
                      [
                        widget.gradientColors![0].withOpacity(0.8),
                        widget.gradientColors![1].withOpacity(0.8),
                      ]
                      :
                      [
                        SPColors.primary.withOpacity(0.8),
                        SPColors.primary.withOpacity(0.8),
                      ]                   
                    )
                  : widget.gradientColors ?? [SPColors.primary, SPColors.primary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.icon != null) // Verifica si el icono es nulo
                    Icon(
                      widget.icon, // Usa el icono proporcionado
                      color: widget.textColor ?? Colors.white,
                    ),
                  if (widget.icon != null) // Agrega espacio solo si el icono no es nulo
                    SizedBox(width: 10),
                  Text(
                    widget.text ?? "",
                    textAlign: widget.textAlign ?? TextAlign.center,
                    maxLines: widget.maxLines ?? 1,
                    style: GoogleFonts.roboto(
                      color: widget.textColor ?? Colors.white,
                      fontSize: widget.fontSize ?? 16,
                      fontWeight: widget.fontWeight ?? FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
