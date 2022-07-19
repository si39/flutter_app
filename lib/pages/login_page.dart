
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_sim/controllers/login_controller.dart' show LoginController;
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  //final LoginController _controller = LoginController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                Color.fromARGB(255, 148, 253, 165),
                Color.fromARGB(255, 88, 156, 99),
                Color.fromARGB(255, 36, 83, 44),
                Color.fromARGB(255, 8, 36, 19),
              ],
              stops: const [0.1, 0.4, 0.7, 0.9],
            )),
        padding: EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on,
                size: MediaQuery.of(context).size.height * 0.3), //icone
            TextField(
              decoration: InputDecoration(
                label: Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                label: Text('Senha', style: TextStyle(color: Colors.white),),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
              child: Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
