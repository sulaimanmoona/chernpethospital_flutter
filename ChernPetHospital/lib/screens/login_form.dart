import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/screens/home_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChernPetHospital/widget/button_style.dart';
import 'package:package_info_plus/package_info_plus.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool passwordVisible = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController user_name = TextEditingController();
  TextEditingController pass_word = TextEditingController();

  String _packageInfoText = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> get_userauthorize() async {
    String url = "${root_url}selectuser.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'user_name': user_name.text,
          'user_pass': pass_word.text,
        },
      ),
    );
    if (Response.statusCode == 200) {
      setState(() {
        glo_Lst_user_authorize = json.decode(Response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const home();
            },
          ),
        );
      });
      glo_username = user_name.text;
      glo_branchstock = glo_Lst_user_authorize[0]["branchstock"];
    }
  }

  Future check_userpass_login() async {
    String url = "${root_url}login.php";

    final Response = await http.post(
      Uri.parse(url),
      body: {'user_name': user_name.text, 'user_pass': pass_word.text},
    );

    var data = json.decode(Response.body);
    if (data == "UserLost") {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Chern Pet Hospital"),
          content: const Text("User not found!!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      get_userauthorize();
    }
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return "$version ($buildNumber)"; // Or display separately
  }

  Future<void> _loadAppVersion() async {
    String version = await _getAppVersion();
    setState(() {
      _packageInfoText = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bkbg.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              //    shrinkWrap: true,s
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text(
                      'Chern Pet Hospital',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'To continue using this app',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text(
                      'Please login first.',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 30),

                    AutofillGroup(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else {
                                  return null;
                                }
                              },
                              controller: user_name,
                              autofillHints: const [AutofillHints.username],
                            ),
                          ),
                          const SizedBox(height: 20),

                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else {
                                  return null;
                                }
                              },
                              controller: pass_word,
                              autofillHints: const [AutofillHints.password],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: () {
                              TextInput.finishAutofillContext();
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                              }

                              check_userpass_login();
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            style: raisedButtonStyle,
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              ' Exit ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          'ver.$_packageInfoText',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
