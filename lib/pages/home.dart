import 'package:flightwithanimations/components/fight_form.dart';
import 'package:flightwithanimations/components/fight_timeline.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum FlightView {
  form,
  timeline,
}

class _HomeState extends State<Home> {
  FlightView flightView = FlightView.form;

  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  void _onFormPressed() {
    setState(() {
      flightView = FlightView.form;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final headerHeight = _size.height * 0.32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE04148),
                      Color(0xFFD85774),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Text(
                        'Air Asia',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          HeaderButton(title: 'One way', selected: false),
                          HeaderButton(title: 'Round', selected: false),
                          HeaderButton(title: 'Multicity', selected: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: headerHeight / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                            child: TabButton(title: 'Flight', selected: true)),
                        Expanded(
                            child: TabButton(title: 'Train', selected: false)),
                        Expanded(
                            child: TabButton(title: 'Bus', selected: false)),
                      ],
                    ),
                    Expanded(
                      child: flightView == FlightView.form
                          ? FlightForm(
                              onTap: _onFlightPressed,
                            )
                          : FlightTimeLine(
                              onTap: _onFormPressed,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TabButton({Key? key, required this.title, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(color: selected ? Colors.black : Colors.grey),
            ),
          ),
          if (selected)
            Container(
              height: 2,
              child: Divider(color: Colors.red),
            ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({Key? key, required this.title, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: selected ? Colors.white : null,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: selected ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
