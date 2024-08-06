import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class PageBuilder extends StatefulWidget {
  const PageBuilder({super.key, required this.child, this.canPop = true,autoscroll=true});

  @override
  State<PageBuilder> createState() => _PageBuilderState();
  final bool canPop;
  final Widget child;
}

class _PageBuilderState extends State<PageBuilder> {
  @override
  Widget build(BuildContext context) {
    logBuild('Постройка страницы по шаблону');
    return PopScope(
      canPop: widget.canPop,
      child: GestureDetector(
        // onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
