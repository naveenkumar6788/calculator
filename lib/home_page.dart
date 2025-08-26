import 'package:calculator/buttons.dart';
import 'package:calculator/functionality.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Flutter Calculator")),backgroundColor: Colors.blueAccent,),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 6, right: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                Functionality.myInput,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              children:
                  Buttons.allButtons
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize:
                                  e != "0"
                                      ? Size(screenwidth * .22, 60)
                                      : Size(screenwidth * .46, 60),
                              backgroundColor:
                                  Buttons.topRowbuttons.contains(e)
                                      ? Colors.grey
                                      : Buttons.operatorButtons.contains(e)
                                      ? Colors.orangeAccent
                                      : Colors.grey.shade900,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            onPressed: () {
                              Functionality.appendInput(e, setState);
                            },
                            child: Text(
                              e,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
