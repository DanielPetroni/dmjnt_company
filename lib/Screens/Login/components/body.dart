import 'package:dmjnt_company/Screens/HomePage/homePage.dart';
import 'package:dmjnt_company/constants.dart';
import 'package:dmjnt_company/controllers/userController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

bool isRead = true;
TextEditingController passwordcontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();
var numbercontroller = new MaskedTextController(mask: '00.00.00000000-0');

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Background(
            child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                "assets/images/login.svg",
                height: size.height * 0.3,
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: kPrimaryColorLight,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: numbercontroller,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Digite o numero do seu cartão",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none),
                    keyboardType: TextInputType.number,
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: kPrimaryColorLight,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        obscureText: isRead,
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: "Digite sua senha",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          isRead ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isRead = !isRead;
                        });
                      },
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Entrar',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                onTap: () {
                  UserController().login(
                      numbercard: numbercontroller.text,
                      password: passwordcontroller.text,
                      onFail: (e) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              e,
                              textAlign: TextAlign.center,
                            )));
                      },
                      onSucess: (user) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => Homepage(user: user)),
                            (Route<dynamic> route) => false);
                      });
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
