import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_slider/flutter_volume_slider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Color color1 = Colors.white;
  Color color2 = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  AudioPlayer player;
  AudioCache audioCache;

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 15.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/rectangle2.png",
                            width: 500,
                            height: 150,
                          ),
                          Text(
                            "sound".tr(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Positioned(
                  top: 135.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          FlutterVolumeSlider(
                            display: Display.HORIZONTAL,
                            sliderActiveColor: Color(0xFFE8B82F),
                            sliderInActiveColor: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/rectangle2.png",
                            width: 500,
                            height: 150,
                          ),
                          Text(
                            "language".tr(),
                            style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 300,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            audioCache.play("touch.mp3");
                            setState(() {
                              color1 = Colors.grey;
                              color2 = Colors.white;
                            });
                            return context.locale = Locale('ru', '');
                          },
                          child: Text(
                            "РУССКИЙ",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                color: color1),
                          )),
                      SizedBox(
                        width: 30.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            audioCache.play("touch.mp3");
                            setState(() {
                              color2 = Colors.grey;
                              color1 = Colors.white;
                            });
                            return context.locale = Locale('en', '');
                          },
                          child: Text(
                            "ENGLISH",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic,
                                color: color2),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
              ],
            ),
          ),
          Positioned(
            child: Image.asset(
              "assets/vector.png",
              width: width,
            ),
          ),
          Positioned(
            top: 0.0,
            left: 10.0,
            child: GestureDetector(
              onTap: () {
                audioCache.play("touch.mp3");
                Navigator.pop(context);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/rectangle.png",
                    width: 140,
                    height: 130,
                  ),
                  Align(
                    child: Icon(
                      Icons.arrow_back,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 1.0,
            child: Image.asset(
              "assets/vector2.png",
              width: width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ]),
      ),
    );
  }
}
