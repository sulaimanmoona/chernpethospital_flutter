import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/screens/appointment_form.dart';
import 'package:ChernPetHospital/screens/branch_form.dart';
import 'package:ChernPetHospital/screens/charts_view_form.dart';
import 'package:ChernPetHospital/screens/login_form.dart';
import 'package:ChernPetHospital/screens/newproduct_form.dart';
import 'package:ChernPetHospital/screens/search_product.dart';
import 'package:flutter/material.dart';
import 'package:ChernPetHospital/screens/search_customer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform; // For platform-specific logic

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> grid_listname = [
    "Sales",
    "Patient",
    "Appointment",
    "Inventory",
    "New Product",
    "Branch",
    // "Count Stock",
  ];

  void logout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const login();
        },
      ),
    );
  }

  Future<void> _openFacebookPage(String pageId, String pageUri) async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl =
          'fb://profile/$pageId'; // For iOS, profiles and pages use 'profile'
    } else {
      fbProtocolUrl = 'fb://page/$pageId'; // For Android, pages use 'page'
    }
    String fallbackUrl =
        'https://www.facebook.com/$pageUri'; // e.g., 'https://www.facebook.com/yourpagename'

    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      // Check if the native app can be launched
      if (await canLaunchUrl(fbBundleUri)) {
        await launchUrl(fbBundleUri);
      } else {
        // Fallback to opening in a browser
        await launchUrl(
          Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Handle any errors during launch
      print('Could not launch Facebook: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Chern Pet Hospital",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
        automaticallyImplyLeading: false,
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
            Expanded(
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: grid_listname.map((gridTitle) {
                  return GestureDetector(
                    child: Card(
                      margin: const EdgeInsets.all(20.0),
                      child: getCardByTitle(gridTitle),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      if (gridTitle == "Inventory" &&
                          glo_Lst_user_authorize[0]["user_authorize"][0] ==
                              "1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const search_product();
                            },
                          ),
                        );
                      } else if (gridTitle == "Sales" &&
                          glo_Lst_user_authorize[0]["user_authorize"][1] == "1")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CardSwiperExample();
                            },
                          ),
                        );
                      else if (gridTitle == "New Product" &&
                          glo_Lst_user_authorize[0]["user_authorize"][2] == "1")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const new_product();
                            },
                          ),
                        );
                      else if (gridTitle == "Appointment" &&
                          glo_Lst_user_authorize[0]["user_authorize"][3] == "1")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const AppointmentForm();
                            },
                          ),
                        );
                      else if (gridTitle == "Patient" &&
                          glo_Lst_user_authorize[0]["user_authorize"][4] == "1")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const search_customer();
                            },
                          ),
                        );
                      else if (gridTitle == "Branch" &&
                          glo_Lst_user_authorize[0]["user_authorize"][5] == "1")
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const search_branch();
                            },
                          ),
                        );
                    },
                  );
                }).toList(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text(
                  ' Contact',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path:
                              'chernudon@gmail.com', // Replace with the recipient's email
                          query:
                              'subject=Hello&body=This is a test email.', // Optional: subject and body
                        );
                        if (!await launchUrl(params)) {
                          throw 'Could not launch $params';
                        }
                      },
                      icon: const Icon(Icons.email), // The icon to display
                      label: const Text(
                        'Email',
                      ), // The text label for the button
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () => _openFacebookPage(
                        '100083093362493',
                        'chern.udonthani',
                      ),

                      icon: const Icon(Icons.facebook), // The icon to display
                      label: const Text(
                        'Facebook',
                      ), // The text label for the button
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Column getCardByTitle(String gridTitle) {
  String img = "";
  if (gridTitle == "Inventory") {
    if (glo_Lst_user_authorize[0]["user_authorize"][0] == "1") {
      img = "assets/images/grid_inventory.png";
    } else {
      img = "assets/images/grid_inventory_disable.png";
    }
  } else if (gridTitle == "Sales") {
    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      img = "assets/images/grid_chart.png";
    } else {
      img = "assets/images/grid_chart_disable.png";
    }
  } else if (gridTitle == "New Product") {
    if (glo_Lst_user_authorize[0]["user_authorize"][2] == "1") {
      img = "assets/images/grid_newproduct.png";
    } else {
      img = "assets/images/grid_newproduct_disable.png";
    }
  } else if (gridTitle == "Appointment") {
    if (glo_Lst_user_authorize[0]["user_authorize"][3] == "1") {
      img = "assets/images/grid_appointment.png";
    } else {
      img = "assets/images/grid_appointment_disable.png";
    }
  } else if (gridTitle == "Patient") {
    if (glo_Lst_user_authorize[0]["user_authorize"][4] == "1") {
      img = "assets/images/grid_customer.png";
    } else {
      img = "assets/images/grid_customer_disable.png";
    }
  } else if (gridTitle == "Branch") {
    if (glo_Lst_user_authorize[0]["user_authorize"][5] == "1") {
      img = "assets/images/grid_branch.png";
    } else {
      img = "assets/images/grid_branch_disable.png";
    }
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(
        child: Container(
          child: Stack(
            children: <Widget>[Image.asset(img, width: 80.0, height: 80.0)],
          ),
        ),
      ),
      Text(
        gridTitle,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
