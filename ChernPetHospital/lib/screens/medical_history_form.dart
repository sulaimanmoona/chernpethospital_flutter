import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/screens/attachfileview_form.dart';
import 'package:ChernPetHospital/screens/medical_history_detail_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedicalHistory extends StatefulWidget {
  final String AnimalID, AnimalNote;

  const MedicalHistory({
    Key? key,
    required this.AnimalID,
    required this.AnimalNote,
  }) : super(key: key);

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  List Lst_visit = [];
  List Lst_attachfile = [];

  Future<void> _loadVisit() async {
    String url = "${root_url}selectvisit.php";

    final Response = await http.post(
      Uri.parse(url),

      body: {'pet_id': widget.AnimalID},
    );

    if (Response.statusCode == 200) {
      setState(() {
        Lst_visit = json.decode(Response.body);
      });
    }
  }

  Future<void> _loadAttachFile() async {
    String url = "${root_url}selectattachfile.php";

    final Response = await http.post(
      Uri.parse(url),

      body: {'pet_id': widget.AnimalID},
    );

    if (Response.statusCode == 200) {
      setState(() {
        Lst_attachfile = json.decode(Response.body);
      });
    }
  }

  void initState() {
    super.initState();
    _loadVisit();
    _loadAttachFile();
  }

  Widget _getimage(int picindex) {
    if (Lst_attachfile[picindex]["extension"] == 'pdf') {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => attachfileview(
                FilePath:
                    root_url +
                    Lst_attachfile[picindex]["filename"] +
                    '.' +
                    Lst_attachfile[picindex]["extension"],
                FileExtension: Lst_attachfile[picindex]["extension"],
              ),
            ),
          );
        },
        child: Image.asset('assets/images/pdf.jpg', fit: BoxFit.cover),
      );
    } else if (Lst_attachfile[picindex]["extension"] == 'doc' ||
        Lst_attachfile[picindex]["extension"] == 'docx') {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => attachfileview(
                FilePath:
                    root_url +
                    Lst_attachfile[picindex]["filename"] +
                    '.' +
                    Lst_attachfile[picindex]["extension"],
                FileExtension: Lst_attachfile[picindex]["extension"],
              ),
            ),
          );
        },
        child: Image.asset('assets/images/doc.jpg', fit: BoxFit.cover),
      );
    } else if (Lst_attachfile[picindex]["extension"] == 'xls' ||
        Lst_attachfile[picindex]["extension"] == 'xlsx') {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => attachfileview(
                FilePath:
                    root_url +
                    Lst_attachfile[picindex]["filename"] +
                    '.' +
                    Lst_attachfile[picindex]["extension"],
                FileExtension: Lst_attachfile[picindex]["extension"],
              ),
            ),
          );
        },
        child: Image.asset('assets/images/xls.jpg', fit: BoxFit.cover),
      ); //
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => attachfileview(
                FilePath:
                    root_url +
                    Lst_attachfile[picindex]["filename"] +
                    '.' +
                    Lst_attachfile[picindex]["extension"],
                FileExtension: Lst_attachfile[picindex]["extension"],
              ),
            ),
          );
        },
        child: Image.network(
          root_url +
              Lst_attachfile[picindex]["filename"] +
              '.' +
              Lst_attachfile[picindex]["extension"],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            ); // Placeholder while loading
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: Icon(Icons.error),
            ); // Placeholder for errors
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Medical History',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          // 2. Place the TabBar in the 'bottom' property of the AppBar.
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.note_alt_outlined), text: 'Note'),
              Tab(icon: Icon(Icons.date_range), text: 'Visit Date'),
              Tab(icon: Icon(Icons.folder_copy_outlined), text: 'Attachment'),
            ],
          ),
        ),
        // 3. Use TabBarView in the body to display content for each tab.
        body: TabBarView(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Card(
                  child: SingleChildScrollView(
                    // Makes the child scrollable
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [Text(widget.AnimalNote)]),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: ListView.builder(
                itemCount: Lst_visit.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/date.png",
                            ),
                          ),
                          title: Text(
                            'Date: ' + Lst_visit[index]["visit_date"],
                          ),
                          subtitle: Text(
                            'Doctor: ' + Lst_visit[index]["doctor"],
                          ),
                          trailing: Icon(Icons.description_sharp),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return visitdetail(
                                    VisitID: Lst_visit[index]["visit_id"],
                                    PetID: Lst_visit[index]["pet_id"],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Number of items on the cross axis (columns)
                  crossAxisSpacing: 10, // Spacing between items horizontally
                  mainAxisSpacing: 10, // Spacing between items vertically
                  childAspectRatio:
                      1.0, // The ratio of the cross-axis extent to the main-axis extent
                ),
                itemCount: Lst_attachfile.length,
                itemBuilder: (BuildContext context, int index) {
                  return _getimage(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
