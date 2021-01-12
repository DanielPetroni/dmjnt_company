import 'package:dmjnt_company/Screens/Login/login_screen.dart';
import 'package:dmjnt_company/controllers/userController.dart';
import 'package:dmjnt_company/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class EditUserScreen extends StatefulWidget {
  EditUserScreen({this.user});
  User user;
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

bool isReadPassword = true;
bool isReadNewPassword = true;
TextEditingController oldpasswordcontroller = TextEditingController();
TextEditingController newpasswordcontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();
var numbercontroller = new MaskedTextController(mask: '00.00.00000000-0');

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.user.numbercard);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _formKey,
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.09),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Meus dados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/images/setting.svg",
                  height: size.height * 0.4,
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: widget.user.numbercard,
                          hintStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),
                      keyboardType: TextInputType.number,
                    )),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              hintText: widget.user.name,
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
                          obscureText: isReadPassword,
                          controller: oldpasswordcontroller,
                          decoration: InputDecoration(
                              hintText: 'Senha atual',
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      IconButton(
                          icon: Icon(isReadPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isReadPassword = !isReadPassword;
                            });
                          })
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
                          obscureText: isReadNewPassword,
                          controller: newpasswordcontroller,
                          decoration: InputDecoration(
                              hintText: 'Nova senha',
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      IconButton(
                          icon: Icon(isReadNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isReadNewPassword = !isReadNewPassword;
                            });
                          })
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Atualizar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  onTap: () {
                    UserController().update(
                        id: widget.user.id,
                        password: oldpasswordcontroller.text,
                        newPassword: newpasswordcontroller.text,
                        onSucess: (value) {
                          setState(() {
                            oldpasswordcontroller.text = "";
                            newpasswordcontroller.text = "";
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Column(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/confirmado.svg",
                                            height: size.height * .2,
                                          ),
                                          SizedBox(height: 5),
                                          Text('Dados atualizados!'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text(
                                              "Fechar",
                                              style:
                                                  TextStyle(color: kPrimaryColor),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ]);
                                });
                          });
                        },
                        onFail: (value) {
                          oldpasswordcontroller.text = "";
                          newpasswordcontroller.text = "";
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Column(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/erro.svg",
                                          height: size.height * .2,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          value["message"],
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                          child: Text(
                                            "Fechar",
                                            style:
                                                TextStyle(color: kPrimaryColor),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ]);
                              });
                        });
                  },
                ),
                GestureDetector(
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Deslogar',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
