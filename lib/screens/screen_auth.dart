import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:iit_360/providers/auth_provider.dart';
import 'package:iit_360/screens/screen_home_guest.dart';
import 'package:iit_360/widgets/delayed_animation.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth";

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
      // backgroundColor: Color(0xFF9575CD),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            children: [
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: FlutterLogo(
                      size: 50.0,
                    ),
                    radius: 50.0,
                  ),
                ),
              ),
              DelayedAnimation(
                child: Text(
                  "hi there,",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  "I am IIT-360!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Your New Personal",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "Companion of IIT-DU",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(
                height: 100.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap:
                      Provider.of<AuthProvider>(context, listen: false).onLogin,
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(GuestHomeScreen.routeName);
                  },
                  child: Text(
                    "I am a Guest".toUpperCase(),
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ),
                delay: delayedAmount + 5000,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'IITian',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8185E2),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
