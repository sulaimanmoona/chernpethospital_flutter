import 'dart:convert';
import 'package:ChernPetHospital/connect_db/save_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ChernPetHospital/widget/button_style.dart';

class Config_server extends StatefulWidget {
  const Config_server({super.key});

  @override
  State<Config_server> createState() => _Config_serverState();
}

class _Config_serverState extends State<Config_server> {
  bool passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController config_server = TextEditingController();
  TextEditingController config_user = TextEditingController();
  TextEditingController config_pass = TextEditingController();
  TextEditingController config_port = TextEditingController();
  List<dynamic> config_arr = [];

  Future test_connect() async {
    String url = "http://127.0.0.1:8080/bkphp/connect.php";

    final Response = await http.post(
      Uri.parse(url),
      body: {
        // 'test_server': config_server.text,
        // 'test_user': config_user.text,
        // 'test_pass': config_pass.text,
        // 'test_port': config_port.text,
      },
    );

    var data = json.decode(Response.body);
    if (data == "Disconnect") {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("BKAPP"),
          content: const Text("Disconnect"),
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
    } else if (data == "Connected") {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("BKAPP"),
          content: const Text("Connected"),
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
    }
  }

  void show_config() async {
    save_hive hiveService = save_hive();
    var hivevalues = await hiveService.read();

    config_arr = hivevalues;

    config_server.text = config_arr[0];
    config_user.text = config_arr[1];
    config_pass.text = config_arr[2];
    config_port.text = config_arr[3];
  }

  @override
  void initState() {
    show_config();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Server Configuration",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Text("${config_arr.toString()}"),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "",
                labelText: "Server :",
                //   helperText: "10.0.0.1",
                helperStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: false,
                filled: true,
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  return null;
                }
              },
              controller: config_server,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                //     hintText: "User",
                labelText: "User :",
                //   helperText: "Root",
                helperStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: false,
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  return null;
                }
              },
              controller: config_user,
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: passwordVisible,
              decoration: InputDecoration(
                //      hintText: "Password",
                labelText: "Password :",
                //    helperText: "Password must contain special character",
                helperStyle: const TextStyle(color: Colors.green),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
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
              controller: config_pass,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                //      hintText: "Port",
                labelText: "Port :",
                //    helperText: "3306",
                helperStyle: TextStyle(color: Colors.green),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else {
                  return null;
                }
              },
              controller: config_port,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      test_connect();
                    },
                    child: const Text('Test Connect'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        // Navigator.pop(context);
                      }

                      save_hive hiveService = save_hive();

                      await hiveService.delete(0);
                      await hiveService.delete(0);
                      await hiveService.delete(0);
                      await hiveService.delete(0);

                      await hiveService.create(config_server.text);
                      await hiveService.create(config_user.text);
                      await hiveService.create(config_pass.text);
                      await hiveService.create(config_port.text);

                      // save_config_hive hiveService = save_config_hive();
                      // await hiveService.update(0, config_server.text);

                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("BKAPP"),
                          content: const Text("Success"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("Save!!"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Save Config'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
