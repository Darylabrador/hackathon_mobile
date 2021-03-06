import 'package:flutter/material.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

class CustomScrollIndicator extends StatefulWidget {
  final ScrollController scrollController;
  const CustomScrollIndicator({Key? key, required this.scrollController})
      : super(key: key);

  @override
  _CustomScrollIndicatorState createState() => _CustomScrollIndicatorState();
}

class _CustomScrollIndicatorState extends State<CustomScrollIndicator> {
  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        ScrollIndicator(
          scrollController: widget.scrollController,
          width: 150,
          height: 5,
          indicatorWidth: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          indicatorDecoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
