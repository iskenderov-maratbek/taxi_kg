import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class SegmentedForm extends StatefulWidget {
  const SegmentedForm(
      {super.key,
      required this.tabItems,
      required this.sizedBox,
      required this.items,
      required this.selectedIndex});

  @override
  State<SegmentedForm> createState() => _SegmentedFormState();
  final double sizedBox;
  final Function selectedIndex;
  final Map<int, String> tabItems;
  final List<Widget> items;
}

class _SegmentedFormState extends State<SegmentedForm> {
  int? _sliding = 0;
  late Map<int, Widget> newTabItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newTabItems.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logBuild('Меню выбора почты и телефона');
    newTabItems = widget.tabItems.map(
      (key, value) => MapEntry<int, Widget>(
        key,
        SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: _sliding == key ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    return Column(
      children: [
        CupertinoSlidingSegmentedControl(
          backgroundColor: Colors.black,
          thumbColor: Colors.yellow[700]!,
          children: newTabItems,
          groupValue: _sliding,
          onValueChanged: (isTapped) {
            Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                _sliding = isTapped;
                widget.selectedIndex(_sliding!);
              });
            });
          },
        ),
        SizedBox(height: widget.sizedBox),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: widget.items[_sliding!],
        )
      ],
    );
  }
}
