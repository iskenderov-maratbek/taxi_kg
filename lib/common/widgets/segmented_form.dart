import 'package:flutter/cupertino.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

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
    newTabItems = widget.tabItems.map(
      (key, value) => MapEntry<int, Widget>(
        key,
        SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: secondaryText(value, color: _sliding == key ? AppColors.black : AppColors.white),
          ),
        ),
      ),
    );
    return Column(
      children: [
        CupertinoSlidingSegmentedControl(
          backgroundColor: AppColors.black,
          thumbColor: AppColors.yellow,
          children: newTabItems,
          groupValue: _sliding,
          onValueChanged: (isTapped) {
            Future.delayed(const Duration(milliseconds: 100), () {
              setState(
                () {
                  _sliding = isTapped;
                  widget.selectedIndex(isTapped);
                },
              );
            });
          },
        ),
        SizedBox(height: widget.sizedBox),
        widget.items[_sliding ?? 0]
      ],
    );
  }
}
