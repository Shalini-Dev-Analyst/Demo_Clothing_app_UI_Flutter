import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// ignore: unused_import
import 'package:s_apparels_clothes/View/Login%20Screen%20/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home Screen/homescreen.dart';
import '../Initial Screen/initialscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _revealAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();

    // Navigate after delay
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool loggedIn = prefs.getBool('loggedIn') ?? false;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, animation, __) {
            return FadeTransition(
              opacity: animation,
              child: loggedIn ? Homescreen() : Initialscreen(),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BG IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/bgs/3a114ea5aab334ab577a6d04f4dd64bc.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // LOGO + LOADER
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _revealAnimation,
                  builder: (context, child) {
                    return ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                          ],
                          stops: [
                            0.0,
                            1 - _revealAnimation.value,
                            1 - _revealAnimation.value,
                            1.0,
                          ],
                        ).createShader(rect);
                      },
                      child: child,
                    );
                  },
                  child: Image.asset(
                    "assets/logo/Logo-02.png",
                    width: 130,
                  ),
                ),
                const SizedBox(height: 25),
                LoadingAnimationWidget.flickr(
                  leftDotColor: const Color(0xFFE3263A),
                  rightDotColor: const Color(0xFF00458C),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
