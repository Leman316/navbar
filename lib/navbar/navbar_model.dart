import 'package:flutter/material.dart';
import 'package:navbar/navbar/navbar_builder.dart';

class BarItem {
  /// Selected or active icon must be filled icon and complementary to inactive icon.
  final Icon filledIcon;

  /// Normal or inactive icon must be outlined icon and complementary to active icon.
  final Icon outlinedIcon;
  final String title;
  BarItem({
    required this.title,
    required this.filledIcon,
    required this.outlinedIcon,
  });
}

class WaterDropPainter extends CustomPainter {
  final Color color;

  WaterDropPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.cubicTo(
      size.width * 0.239841,
      size.height * 0.06489535,
      size.width * 0.285956,
      size.height * 0.4886860,
      size.width * 0.42016,
      size.height * 0.8271512,
    );
    path.cubicTo(
      size.width * 0.467771,
      size.height * 0.9466628,
      size.width * 0.530574,
      size.height * 0.9472209,
      size.width * 0.578344,
      size.height * 0.8285814,
    );
    path.cubicTo(
        size.width * 0.7185669,
        size.height * 0.4786744,
        size.width * 0.757325,
        size.height * 0.06629070,
        size.width * 0.999682,
        0);
    path.lineTo(0, 0);
    path.close();

    Paint fillColor = Paint()..style = PaintingStyle.fill;

    fillColor.color = color;
    canvas.drawPath(path, fillColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BuildFallingDrop extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double itemWidth;

  const BuildFallingDrop({
    required this.width,
    required this.height,
    required this.color,
    required this.itemWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: UnconstrainedBox(
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            size: Size.zero,
            painter: WaterDropPainter(color),
          ),
        ),
      ),
    );
  }
}

class IconClipper extends CustomClipper<Rect> {
  final double radius;

  IconClipper({required this.radius});

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class WaterDropNavBar extends StatelessWidget {
  final Color backgroundColor;
  final OnButtonPressCallback onItemSelected;
  final int selectedIndex;
  final List<BarItem> barItems;
  final Color waterDropColor;
  final Color inactiveIconColor;
  final double iconSize;
  final double? bottomPadding;

  const WaterDropNavBar({
    required this.barItems,
    required this.selectedIndex,
    required this.onItemSelected,
    this.bottomPadding,
    this.backgroundColor = Colors.white,
    this.waterDropColor = const Color(0xFF5B75F0),
    this.iconSize = 28,
    Color? inactiveIconColor,
    Key? key,
  })  : inactiveIconColor = inactiveIconColor ?? waterDropColor,
        assert(barItems.length > 1, 'You must provide minimum 2 bar items'),
        assert(barItems.length < 5, 'Maximum bar items count is 4'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BuildNavBar(
      itmes: barItems,
      backgroundColor: backgroundColor,
      selectedIndex: selectedIndex,
      onItemSelected: onItemSelected,
      dropColor: waterDropColor,
      iconSize: iconSize,
      inactiveIconColor: inactiveIconColor,
      bottomPadding: bottomPadding,
    );
  }
}
