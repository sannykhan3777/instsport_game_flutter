import 'package:flutter/material.dart';
import 'package:instsport/screens/gameplay_screen.dart';
import 'package:instsport/screens/setting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int scoreee;

  HomeScreen({Key key, this.scoreee}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int top1;
  int top2;
  int top3;

  setScore() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int score_1 = _pref.getInt('score_1') ?? 0; // 50
    int score_2 = _pref.getInt('score_2') ?? 0; // 40
    int score_3 = _pref.getInt('score_3') ?? 0; // 30

    if (widget.scoreee > score_1) {
      _pref.setInt('score_1', (widget.scoreee));
      _pref.setInt('score_2', (score_1));
      _pref.setInt('score_3', (score_2));
    } else if ((widget.scoreee > score_2) && (widget.scoreee < score_1)) {
      _pref.setInt('score_2', (widget.scoreee));
      _pref.setInt('score_3', (score_2));
    } else if ((widget.scoreee > score_3) && (widget.scoreee < score_2)) {
      _pref.setInt('score_3', (widget.scoreee));
    }
  }

  getScore() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int score_1 = _pref.getInt('score_1') ?? 0; // 50
    int score_2 = _pref.getInt('score_2') ?? 0; // 40
    int score_3 = _pref.getInt('score_3') ?? 0; // 30

    // List<int> _list = [score_1, score_2, score_3];
    setState(() {
      top1 = score_1;
      top2 = score_2;
      top3 = score_3;
    });

    print(top1);
    print(top2);
    print(top3);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initPlayer();
    setScore();
    getScore();
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
            padding: EdgeInsets.fromLTRB(45.0, 50.0, 45.0, 0.0),
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
                  top: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "top_results".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40.0,
                          color: Color(0xFFFFFFFF),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                Positioned(
                    top: 60,
                    child: PointsRow(
                      t1: top1,
                      t2: top2,
                      t3: top3,
                    )),
                Positioned(
                  top: 120.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => GamePlayScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/rectangle2.png",
                              width: 500,
                              height: 110.0,
                            ),
                            Text(
                              "play".tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200.0,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          audioCache.play("touch.mp3");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              "assets/rectangle3.png",
                              width: 500,
                              height: 110.0,
                            ),
                            Text(
                              "settings".tr(),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // top: -10,
            child: Image.asset(
              "assets/vector.png",
              width: width,
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

class PointsRow extends StatelessWidget {
  final int t1;
  final int t2;
  final int t3;

  const PointsRow({Key key, this.t1, this.t2, this.t3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE8B82F),
              radius: 18,
              child: Text(
                "1",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "$t1",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "points".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
          ],
        ),
        SizedBox(
          width: 60.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFD1D1D1),
              radius: 18,
              child: Text(
                "2",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "$t2",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "points".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
          ],
        ),
        SizedBox(
          width: 60.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFD3551F),
              radius: 18,
              child: Text(
                "3",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "$t3",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "points".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0),
            ),
          ],
        ),
      ],
    );
  }
}
