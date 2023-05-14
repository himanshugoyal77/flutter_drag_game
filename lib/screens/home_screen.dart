import 'dart:ffi';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dragndrop/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as Math;
import 'package:lottie/lottie.dart' as lottie;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  String correctList = '';

  final List _animals = [
    "assets/lion1.png",
    "assets/monkey1.png",
    "assets/dog.png",
  ];

  final List _animalNames = [
    "Lion",
    "Monkey",
    "Dog",
  ];

  List _selectFromLetters = [
    ['l', 'i', 'o', 'n', 'h', 'e', 't'],
    ['m', 'o', 'n', 'k', 'e', 'y', 'p'],
    ['d', 'u', 'c', 'k', 'a', 'e', 't'],
  ];

  final List _copySelectFromLetters = [
    ['l', 'i', 'o', 'n', 'h', 'e', 't'],
    ['m', 'o', 'n', 'k', 'e', 'y', 'p'],
    ['d', 'o', 'g', 'k', 'a', 'e', 't'],
  ];
  int score = 0;

  @override
  Widget build(BuildContext context) {
    var _random = Math.Random(_selectFromLetters.length);

    return Scaffold(
        backgroundColor: Color(0xffF0F0F0),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF0F0F0),
          leading:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          title: Text("Level 1",
              style: GoogleFonts.pressStart2p(
                  color: Colors.red.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.normal)),
          centerTitle: true,
          actions: const [
            Icon(Icons.audiotrack_sharp, color: Colors.black),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What animal is this?",
                style: GoogleFonts.audiowide(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _selectFromLetters = _copySelectFromLetters;
                      correctList = '';
                    });
                  },
                  children: [
                    for (var i = 0; i < _animals.length; i++)
                      Column(
                        children: [
                          Image.asset(
                            _animals[i],
                            height: 220,
                            width: 220,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 120,
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  for (var j = 0;
                                      j < _animalNames[i].length;
                                      j++)
                                    DragTarget<String>(builder:
                                        (context, selectedList, rejectedData) {
                                      return Container(
                                        margin: j != 1
                                            ? const EdgeInsets.all(5)
                                            : const EdgeInsets.all(2),
                                        height: 55,
                                        width: 55,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all()),
                                        child: Center(
                                          child: Text(
                                            correctList.length > j
                                                ? correctList[j].toUpperCase()
                                                : ''.toString().toUpperCase(),
                                            style: GoogleFonts.pressStart2p(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  colors[_random.nextInt(15)],
                                            ),
                                          ),
                                        ),
                                      );
                                    }, onWillAccept: (data) {
                                      print(data);
                                      return true;
                                    }, onLeave: (data) {
                                      print("onLeave");
                                      final player = AudioPlayer();
                                      player.play(AssetSource('defeat.mp3'));
                                    }, onAccept: (data) {
                                      final player = AudioPlayer();

                                      if (data ==
                                          _animalNames[i][j]
                                              .toString()
                                              .toLowerCase()) {
                                        player.play(AssetSource('jump.mp3'));
                                        setState(() {
                                          _selectFromLetters[i].removeWhere(
                                              (element) =>
                                                  element == data.toString());
                                        });

                                        if (i == _animals.length - 1 &&
                                            j == _animalNames[i].length - 1) {
                                          player.play(AssetSource('win.mp3'));
                                          showCupertinoDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title:
                                                      Text("Congratulations!"),
                                                  content: Column(
                                                    children: [
                                                      const Text(
                                                          "You have completed the game!"),
                                                      lottie.Lottie.network(
                                                          'https://assets3.lottiefiles.com/packages/lf20_eXccgKjr0V.json',
                                                          height: 200),
                                                    ],
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                        child: Text("OK"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ],
                                                );
                                              });
                                        }

                                        if (correctList.length ==
                                            _animalNames[i].length - 1) {
                                          setState(() {
                                            score += 10;
                                          });
                                          final player = AudioPlayer();
                                          player.play(AssetSource('jump.mp3'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  padding: EdgeInsets.all(8),
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  content: Text(
                                                      'You are correct! 🎉: +10')));
                                          _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              curve: Curves.easeIn);
                                        }

                                        setState(() {
                                          // correctList = '';
                                          correctList += data;
                                        });
                                        print("correctList: $correctList");
                                      } else {
                                        //player.play(AssetSource('defeat.mp3'));
                                      }
                                    }),
                                ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Drag the letters to the box below to form the word',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 30,
                            runSpacing: 10,
                            children: [
                              for (var j = 0;
                                  j < _selectFromLetters[i].length;
                                  j++)
                                BuildDrag(
                                    selectFromLetters: _selectFromLetters,
                                    i: i,
                                    j: j),
                            ]..shuffle(_random),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  //  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Text(
                    'Score: ',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    score.toString(),
                    style: GoogleFonts.pressStart2p(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }
}

class BuildDrag extends StatelessWidget {
  const BuildDrag({
    super.key,
    required List selectFromLetters,
    required this.i,
    required this.j,
  }) : _selectFromLetters = selectFromLetters;

  final List _selectFromLetters;
  final int i;
  final int j;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: _selectFromLetters[i][j],
      feedback: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors[Math.Random().nextInt(12)],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          color: Colors.transparent,
          child: Text(
            _selectFromLetters[i][j],
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
      childWhenDragging: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
        color: colors[Math.Random().nextInt(12)],
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: colors[Math.Random().nextInt(12)],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _selectFromLetters[i][j],
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
        color: colors[Math.Random().nextInt(12)],
        child: Container(
          margin: const EdgeInsets.all(2), // margin
          padding: const EdgeInsets.all(8),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: colors[Math.Random().nextInt(12)],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              _selectFromLetters[i][j],
              style: GoogleFonts.pressStart2p(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
