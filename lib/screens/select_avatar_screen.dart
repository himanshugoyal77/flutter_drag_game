import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dragndrop/controllers/avatar_controller.dart';
import 'package:flutter_dragndrop/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

const profileIcons = [
  'assets/profile/p1.png',
  'assets/profile/p2.png',
  'assets/profile/p4.png',
  'assets/profile/p5.png',
];

class AvatarScreen extends StatefulWidget {
  AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final avatarController = AvatarController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 3,
            ),
            Text(
              "Select Avatar",
              style: GoogleFonts.audiowide(
                fontSize: 25,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedBuilder(
                animation: avatarController,
                builder: (context, child) {
                  return Visibility(
                    // visible: isClicked ? false : true,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: profileIcons
                          .map((e) => GestureDetector(
                                onTap: () {
                                  final audioPlayer = AudioPlayer();
                                  audioPlayer.play(AssetSource('click.mp3'));
                                  avatarController.setProfile(e);
                                  avatarController.setSelectedIndex(
                                      profileIcons.indexOf(e));
                                },
                                child: Hero(
                                  tag: e,
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.bounceInOut,
                                    scale: avatarController.selectedIndex ==
                                            profileIcons.indexOf(e)
                                        ? 1.1
                                        : 1,
                                    child: Container(
                                      width: 75,
                                      height: 75,
                                      clipBehavior: Clip.hardEdge,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: avatarController
                                                          .selectedIndex ==
                                                      profileIcons.indexOf(e)
                                                  ? Colors.teal
                                                  : Colors.white,
                                              width: 2),
                                          color:
                                              avatarController.selectedIndex ==
                                                      profileIcons.indexOf(e)
                                                  ? Colors.teal
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          // image: DecorationImage(
                                          //     image: AssetImage(e), fit: BoxFit.cover),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0, 1),
                                                spreadRadius: 1,
                                                blurRadius: 2),
                                          ]),
                                      child: CircleAvatar(
                                        // height: 70,
                                        // width: 70,
                                        // padding: const EdgeInsets.all(5),
                                        // clipBehavior: Clip.hardEdge,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(50),
                                        // ),
                                        child: Image.asset(
                                          e,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }),
            const Spacer(
              flex: 2,
            ),
            !isClicked
                ? ElevatedButton(
                    onPressed: () {
                      if (avatarController.selectedIndex != -1) {
                        setState(() {
                          isClicked = true;
                        });

                        Future.delayed(const Duration(seconds: 0), () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                      opacity: animation,
                                      child: AvatarFinal(
                                        selectedIndex:
                                            avatarController.selectedIndex,
                                      ));
                                },
                              ));
                        });
                      } else {
                        const snackdemo = SnackBar(
                          content: Text('Plaease select an avatar'),
                          backgroundColor: Colors.teal,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              side: BorderSide(color: Colors.teal))),
                    ),
                    child: Container(
                        width: 100,
                        height: 50,
                        child: const Center(
                          child: Text("Next ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        )))
                : Center(
                    child: Lottie.network(
                        height: 100,
                        width: 100,
                        'https://assets6.lottiefiles.com/private_files/lf30_nsqfzxxx.json'),
                  ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarFinal extends StatefulWidget {
  final selectedIndex;
  AvatarFinal({super.key, required this.selectedIndex});

  @override
  State<AvatarFinal> createState() => _AvatarFinalState();
}

// 589, 586, 582, 579, 575, 571, 567, 563, 558, 553, 549, 543, 538, 534, 530, 526, 524, 521, 518, 516, 515, 515, 514, 514, 515, 516, 518, 522, 526, 532, 538, 547, 557, 566, 578, 588, 598, 608, 617, 625, 632, 638, 643, 646, 649, 650, 651, 652, 652, 652, 652, 652, 651, 650, 648, 646, 645, 644, 643, 643, 643, 644, 644, 644, 644, 644, 644

class _AvatarFinalState extends State<AvatarFinal> {
  double start = 0;

  double end = 0;
  double prev = 550;
  List Numbers = [];
  List Numbers2 = [];
  List five = [
    -48.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    1.0,
    0.0,
    9.0,
    -1.0,
    -3.0,
    0.0,
    0.0,
    -2.0,
    0.0,
    -3.0,
    1.0,
    -1.0,
    0.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    0.0,
    -1.0,
    2.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    2.0,
    0.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    1.0,
    -1.0,
    3.0,
    -2.0,
    1.0,
    -2.0,
    0.0,
    -2.0,
    1.0,
    0.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    0.0,
    1.0,
    0.0,
    -1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    -1.0,
    1.0
  ];
  List seven = [
    -29.0,
    0.0,
    1.0,
    -1.0,
    0.0,
    2.0,
    -2.0,
    2.0,
    -1.0,
    0.0,
    -1.0,
    -1.0,
    1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    1.0,
    0.0,
    -1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    1.0,
    0.0,
    0.0,
    0.0,
    1.0,
    -1.0,
    2.0,
    -1.0,
    2.0,
    2.0,
    -2.0,
    1.0,
    0.0,
    2.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    -1.0,
    -1.0,
    0.0,
    0.0,
    -1.0,
    -1.0,
    -1.0,
    -1.0,
    0.0,
    -1.0,
    -1.0,
    1.0,
    -1.0,
    0.0,
    0.0,
    0.0
  ];

  int count7 = 0;
  int count5 = 0;
  @override
  Widget build(BuildContext context) {
    final avatarController = AvatarController();
    print("Avatar index: ${avatarController.selectedIndex}");
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: avatarController,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  // color: Colors.teal,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Lottie.network(
                            'https://assets3.lottiefiles.com/packages/lf20_MOKbwLAuBp.json'),
                      ),
                      Center(
                        child: Hero(
                          tag: profileIcons[widget.selectedIndex],
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.bounceInOut,
                            scale: 1,
                            child: CircleAvatar(
                              radius: 70,
                              child: Image.asset(
                                profileIcons[widget.selectedIndex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You are all set!",
                  style: GoogleFonts.audiowide(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onPanStart: (details) {
                    setState(() {
                      start = details.globalPosition.dx;
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      end = details.globalPosition.dy.ceilToDouble();
                      Numbers.add(
                          (details.globalPosition.dy.ceilToDouble().abs() -
                                  prev)
                              .abs());
                      prev = details.globalPosition.dy.ceilToDouble().abs();
                    });

                    //  print(details.delta.dx);
                  },
                  onPanEnd: (details) {
                    for (int i = 1; i < Numbers.length; i++) {
                      Numbers2.add((Numbers[i] - Numbers[i - 1]));
                    }
                    print(Numbers2);
                    for (int i = 0; i < Numbers2.length; i++) {
                      if (seven.contains(Numbers2[i])) {
                        count7++;
                      } else if (five.contains(Numbers2[i])) {
                        count5++;
                      } else {
                        print("No match");
                      }
                    }
                    print("Count 7: $count7");
                    print("Count 5: $count5");
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.teal,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


//[-29.0, 0.0, 1.0, -1.0, 0.0, 2.0, -2.0, 2.0, -1.0, 0.0, -1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 0.0, 1.0, 0.0, -1.0, 1.0, 0.0, 0.0, 0.0, -1.0, 1.0, 0.0, 0.0, 0.0, 1.0, -1.0, 2.0, -1.0, 2.0, 2.0, -2.0, 1.0, 0.0, 2.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, -1.0, -1.0, 0.0, 0.0, -1.0, -1.0, -1.0, -1.0, 0.0, -1.0, -1.0, 1.0, -1.0, 0.0, 0.0, 0.0]
//[-48.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, -1.0, 0.0, 0.0, 1.0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, -1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 0.0, 0.0, 1.0, -1.0, 1.0, 1.0, 0.0, 9.0, -1.0, -3.0, 0.0, 0.0, -2.0, 0.0, -3.0, 1.0, -1.0, 0.0, -1.0, 0.0, 0.0, 0.0, -1.0, 0.0, 1.0, -1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, -1.0, 1.0, -1.0, 1.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, -1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 0.0, 0.0, 1.0, -1.0, 1.0, -1.0, 0.0, 1.0, 0.0, -1.0, 2.0, -1.0, 0.0, 1.0, -1.0, 2.0, 0.0, -1.0, 1.0, -1.0, 1.0, 0.0, 0.0, 0.0, 1.0, -1.0, 1.0, 1.0, -1.0, 3.0, -2.0, 1.0, -2.0, 0.0, -2.0, 1.0, 0.0, -1.0, 1.0, -1.0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 1.0, -1.0, 1.0, 0.0, 1.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0, -1.0, 1.0, -1.0, 0.0, -1.0, 1.0]