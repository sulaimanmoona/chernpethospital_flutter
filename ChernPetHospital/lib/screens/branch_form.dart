import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class search_branch extends StatefulWidget {
  const search_branch({super.key});

  @override
  State<search_branch> createState() => _search_branchState();
}

class _search_branchState extends State<search_branch> {
  List Lst_branch = [];

  @override
  void initState() {
    super.initState();
    _loadbranch();
  }

  Future<void> _loadbranch() async {
    String url = "${root_url}selectbranch.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_branch = json.decode(Response.body);
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Branch Info",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: const [],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bkbg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(12),
            //       border: Border.all(
            //           width: 1,
            //           color: Color.fromRGBO(11, 189, 180, 1),
            //           style: BorderStyle.solid)),
            //   child: Center(
            //     child: AspectRatio(
            //       aspectRatio: 1,
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 5),
            //       ),
            //     ),
            //   ),
            // ),
            //   const SizedBox(height: 5),
            Expanded(
              child: Scrollbar(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: Lst_branch.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          trailing: const Icon(Icons.phone), // Icon on the left
                          title: Text(Lst_branch[index]["branchname"]),
                          subtitle: Text(
                            Lst_branch[index]["branchaddress"] +
                                ' ' +
                                Lst_branch[index]["branchtel"],
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => _makePhoneCall(
                            Lst_branch[index]["branchtel"],
                          ), // Replace with your desired phone number
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
