import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
class BottomNav extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const BottomNav(this.onItemTapped, this.selectedIndex, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomePainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: (){},
              backgroundColor: SPColors.primary,
              elevation: 0.1,
              child: const Icon(Icons.qr_code, color: Colors.white,),
            ),
          ),
          SizedBox(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                     onItemTapped(0);
                  },
                  icon: Icon(Icons.home, color: selectedIndex == 0 ? Colors.black : Colors.grey),
                ),
                IconButton(
                  onPressed: () { onItemTapped(1); },
                  icon: Icon(Icons.search, color: selectedIndex == 1 ? Colors.black : Colors.grey),
                ),
                Container(width: size.width*.20,),
                IconButton(
                  onPressed: () { onItemTapped(2); },
                  icon: Icon(Icons.notifications, color: selectedIndex == 2 ? Colors.black : Colors.grey),
                ),
                IconButton(
                  onPressed: () {
                     onItemTapped(3); 
                  },
                  icon: Icon(Icons.person, color: selectedIndex == 3 ? Colors.black : Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width , 20);
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
