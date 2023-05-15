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
                    visible: isClicked ? false : true,
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
                                        color: avatarController.selectedIndex ==
                                                profileIcons.indexOf(e)
                                            ? Colors.teal
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(50),
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
                              ))
                          .toList(),
                    ),
                  );
                }),
            Visibility(
              visible: isClicked ? true : false,
              child: LottieBuilder.network(
                  'https://assets3.lottiefiles.com/packages/lf20_nhjrntqo.json'),
            ),
            Spacer(
              flex: 2,
            ),
            ElevatedButton(
                onPressed: () {
                  if (avatarController.selectedIndex != -1) {
                    setState(() {
                      isClicked = true;
                    });
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
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
                    child: Center(
                      child: Text("Next ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ))),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
