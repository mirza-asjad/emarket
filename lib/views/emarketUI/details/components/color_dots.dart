import 'package:flutter/material.dart';
import 'package:emarket/views/emarketUI/components/rounded_icon_btn.dart';
import 'package:emarket/views/emarketUI/constants.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
  }) : super(key: key);

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int itemofPurchase = 1;
  int selectedColor = 3;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            colors.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: ColorDot(
                color: colors[index],
                isSelected: index == selectedColor,
              ),
            ),
          ),
          const Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (itemofPurchase != 1) itemofPurchase--;
              });
            },
          ),
          const SizedBox(width: 20),
          Text(itemofPurchase.toString()),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                itemofPurchase++;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
