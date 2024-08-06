import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class CustomButton extends StatefulWidget {
  final EdgeInsets padding;
  final void Function() onTap;
  final List<Widget> children;
  final Color color;
  final Color borderColor;

  const CustomButton({
    super.key,
    required this.padding,
    required this.onTap,
    required this.children,
    required this.color,
    this.borderColor = AppColors.transparent,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTapped = false;

  onTapTimer() {
    if (!_isTapped) {
      _isTapped = true;
      widget.onTap();
      Future.delayed(const Duration(seconds: 1), () {
        _isTapped = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isTapped,
      child: GestureDetector(
        onTap: onTapTimer,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: widget.borderColor),
          ),
          padding: widget.padding,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}
