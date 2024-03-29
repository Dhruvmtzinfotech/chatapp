import 'package:flutter/cupertino.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor = const Color(0xFF646b7f),
    this.flashingCircleDarkColor = const Color(0xFF333333),
    this.flashingCircleBrightColor = const Color(0xff3c4a72),
  });
  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late Animation<double> _indicatorSpaceAnimation;

  @override
  void initState() {
    super.initState();
    _appearanceController = AnimationController(
      vsync: this,
    );
    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      reverseCurve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    ).drive(Tween<double>(
      begin: 0.0,
      end: 60.0,
    ));
    if (widget.showIndicator) {
      _showIndicator();
    }
  }
  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }
  @override
  void dispose() {
    _appearanceController.dispose();
    super.dispose();
  }
  void _showIndicator() {
    _appearanceController
      ..duration = Duration(milliseconds: 750)
      ..forward();
  }
  void _hideIndicator() {
    _appearanceController
      ..duration = Duration(microseconds: 750)
      ..reverse();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _indicatorSpaceAnimation,
      builder: (context, child) {
        return SizedBox(
          height: _indicatorSpaceAnimation.value,
        );
      },
    );
  }
}


