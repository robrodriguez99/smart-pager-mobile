import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart'; // Import QR code scanning package

class BottomNav extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  final GlobalKey qrKey =
      GlobalKey(debugLabel: 'QR'); // Create a GlobalKey for QR code scanner

  BottomNav(this.onItemTapped, this.selectedIndex, {required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 90,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 90),
            painter: BNBCustomPainter(),
          ),
          SizedBox(
            width: size.width,
            height: 90,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 90),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Open QR scanner on button press
                      _startScan(context);
                    },
                    backgroundColor: SPColors.primary,
                    elevation: 0.1,
                    child: const Icon(
                      Icons.qr_code,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildNavItem(Icons.home, "Inicio", 0,
                            selectedIndex, onItemTapped),
                      ),
                      Expanded(
                        child: _buildNavItem(Icons.wb_twilight, "Turno", 1,
                            selectedIndex, onItemTapped),
                      ),
                      const Expanded(
                        flex: 1,
                        child:
                            SizedBox(), // Empty SizedBox with flex to create spacing
                      ),
                      Expanded(
                        child: _buildNavItem(Icons.notifications,
                            "Notificaciones", 2, selectedIndex, onItemTapped),
                      ),
                      Expanded(
                        child: _buildNavItem(Icons.person, "Perfil", 3,
                            selectedIndex, onItemTapped),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String text, int index, int selectedIndex,
      Function(int) onTap) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                selectedIndex == index ? SPColors.primary : SPColors.darkGray,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color:
                  selectedIndex == index ? SPColors.primary : SPColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  // Function to start QR code scanning
  void _startScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRView(
          key: qrKey,
          onQRViewCreated: (controller) =>
              _onQRViewCreated(controller, context), // Pass context here
        ),
      ),
    );
  }

  // Callback for when QR code is detected
  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    controller.scannedDataStream.listen((scanData) {
      GoRouter.of(context).push('/restaurant');
    });
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = SPColors.lightGray
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
