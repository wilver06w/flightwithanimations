import 'package:flutter/material.dart';

const _airplaneSize = 30.0;
const _dontSize = 18.0;

class FlightTimeLine extends StatefulWidget {
  final VoidCallback onTap;

  const FlightTimeLine({Key? key, required this.onTap}) : super(key: key);

  @override
  State<FlightTimeLine> createState() => _FlightTimeLineState();
}

class _FlightTimeLineState extends State<FlightTimeLine> {
  bool animated = false;
  bool animateCards = false;

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });

    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateCards = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      final centerDot = constraints.maxWidth / 2 - _dontSize / 2;
      print(constraints);
      return Stack(
        children: [
          AnimatedPositioned(
            left: constraints.maxWidth / 2 - _airplaneSize / 2,
            top: animated ? 20 : constraints.maxHeight - _airplaneSize - 10,
            bottom: 0.0,
            duration: const Duration(milliseconds: 400),
            child: const AircraftAndLine(),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            left: centerDot,
            top: animated ? 80 : constraints.maxHeight,
            child: TimelineDot(
              selected: true,
              displayCard: animateCards,
              delay: const Duration(milliseconds: 300),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            right: constraints.maxHeight / 2 - _dontSize / 2,
            top: animated ? 140 : constraints.maxHeight,
            child: TimelineDot(
              left: true,
              displayCard: animateCards,
              delay: Duration(milliseconds: 600),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            left: centerDot,
            top: animated ? 200 : constraints.maxHeight,
            child: TimelineDot(
              displayCard: animateCards,
              delay: const Duration(milliseconds: 900),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            right: centerDot,
            top: animated ? 260 : constraints.maxHeight,
            child: TimelineDot(
              selected: true,
              displayCard: animateCards,
              left: true,
              delay: const Duration(milliseconds: 1200),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.check),
              onPressed: initAnimation,
            ),
          ),
        ],
      );
    });
  }
}

class AircraftAndLine extends StatelessWidget {
  const AircraftAndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: [
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
            child: Container(
              width: 5,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}

class TimelineDot extends StatefulWidget {
  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  const TimelineDot({
    Key? key,
    this.selected = false,
    this.displayCard = false,
    this.left = false,
    this.delay = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<TimelineDot> createState() => _TimelineDotState();
}

class _TimelineDotState extends State<TimelineDot> {
  bool animated = false;

  void _animateWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimelineDot oldWidget) {
    _animateWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.grey.shade200,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('JFK + ORY'),
          ),
        ),
        builder: (context, value, child) {
          return Transform.scale(
            alignment:
                widget.left ? Alignment.centerRight : Alignment.centerLeft,
            scale: value,
            child: child,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (animated && widget.left) ...[
          Container(
            color: Colors.grey.shade200,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('JFK + ORY'),
            ),
          ),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey.shade400,
          ),
        ],
        Container(
          height: _dontSize,
          width: _dontSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: widget.selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          Container(
            width: 10,
            height: 1,
            color: Colors.grey.shade400,
          ),
          _buildCard(),
        ],
      ],
    );
  }
}
