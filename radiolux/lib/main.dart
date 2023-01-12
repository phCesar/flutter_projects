import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacementNamed('/home');
        });
      }
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
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.black])),
          child: Center(
            child: FadeTransition(
              opacity: _animation,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'assets/icons/skull.gif',
              ),
            ),
          ),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          _buildOption(context, 'Anatomia', () {
            Navigator.of(context).pushNamed('/anatomia');
          }),
          SizedBox(height: 30),
          _buildOption(context, 'Patologia', () {
            Navigator.of(context).pushNamed('/patologia');
          }),
          SizedBox(height: 30),
          _buildOption(context, 'Teste de hipótese', () {
            Navigator.of(context).pushNamed('/teste_de_hipotese');
          }),
          SizedBox(height: 30),
          _buildOption(context, 'Quizz', () {
            Navigator.of(context).pushNamed('/quizz');
          }),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, Function onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 8),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
    );
  }
}