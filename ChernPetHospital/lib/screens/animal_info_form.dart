import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ChernPetHospital/app.dart';

class animal_info extends StatefulWidget {
  final String AnimalID,
      AnimalName,
      AnimalType,
      AnimalSex,
      AnimalColor,
      AnimalBreed,
      AnimalMix,
      AnimalDOB,
      AnimalGroup,
      AnimalPic,
      CustomerID,
      CustomerName,
      CustomerSurName,
      CustomerIDCard,
      CustomerTel,
      CustomerTel2,
      CustomerAddress,
      CustomerProvince,
      CustomerPic;

  const animal_info({
    Key? key,
    required this.AnimalID,
    required this.AnimalName,
    required this.AnimalType,
    required this.AnimalSex,
    required this.AnimalColor,
    required this.AnimalBreed,
    required this.AnimalMix,
    required this.AnimalDOB,
    required this.AnimalGroup,
    required this.AnimalPic,

    required this.CustomerID,
    required this.CustomerName,
    required this.CustomerSurName,
    required this.CustomerIDCard,
    required this.CustomerTel,
    required this.CustomerTel2,
    required this.CustomerAddress,
    required this.CustomerProvince,
    required this.CustomerPic,
  }) : super(key: key);

  // final List<card_stless> AnimalSelect;
  // const animal_info({Key? key, required this.AnimalSelect}) : super(key: key);

  //const animal_info({super.key});

  @override
  State<animal_info> createState() => _animal_infoState();
}

class _animal_infoState extends State<animal_info> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController c_pet_id = TextEditingController();
  TextEditingController c_pet_name = TextEditingController();
  TextEditingController c_pet_species = TextEditingController();
  TextEditingController c_pet_sex = TextEditingController();
  TextEditingController c_pet_color = TextEditingController();
  TextEditingController c_pet_breed = TextEditingController();
  TextEditingController c_pet_mix = TextEditingController();
  TextEditingController c_pet_age = TextEditingController();
  TextEditingController c_pet_group = TextEditingController();

  TextEditingController c_cus_id = TextEditingController();
  TextEditingController c_cus_name = TextEditingController();
  TextEditingController c_cus_surname = TextEditingController();
  TextEditingController c_cus_passport = TextEditingController();
  TextEditingController c_cus_tel = TextEditingController();
  TextEditingController c_cus_tel2 = TextEditingController();
  TextEditingController c_cus_address = TextEditingController();
  TextEditingController c_cus_province = TextEditingController();

  String? _selectedSpecies;
  String? _selectedSex;
  String? _selectedGroup;
  String? _selectedBreed;
  String? _selectedMix;
  String? _selectedProvince;
  DateTime? _bday = DateTime.now();
  File? _FileImage;
  File? _FileImageCus;
  final _pickImage = ImagePicker();
  bool _GetImage = false;
  bool _GetImageCus = false;
  List<int> Lst_Bytesimage = [];
  List<int> Lst_BytesimageCus = [];
  String _ProImageNetwork = '';
  String _ProImageNetworkCus = '';
  List Lst_breed = [];
  List Lst_species = [
    'แมว',
    'ม้า',
    'แกะ',
    'โค',
    'แพะ',
    'สุกร',
    'สุนัข',
    'Paririe Dog',
    'Rabbit',
    'Squirrel',
    'Sugar Glider',
    'กระบือ',
    'ช้าง',
  ];
  List Lst_province = [];

  List Lst_sex = ['Male', 'Female'];
  List Lst_group = ['First', 'Exclusive', 'Premier', 'Soidog'];

  @override
  void initState() {
    super.initState();

    c_pet_id.text = widget.AnimalID;
    c_pet_name.text = widget.AnimalName;
    _selectedSpecies = widget.AnimalType;
    _selectedSex = widget.AnimalSex;
    c_pet_color.text = widget.AnimalColor;
    _selectedBreed = widget.AnimalBreed;
    _selectedMix = widget.AnimalMix;
    _bday = DateTime.parse(widget.AnimalDOB);
    _selectedGroup = widget.AnimalGroup;
    _ProImageNetwork = root_url + widget.AnimalPic;

    c_cus_id.text = widget.CustomerID;
    c_cus_name.text = widget.CustomerName;
    c_cus_surname.text = widget.CustomerSurName;
    c_cus_passport.text = widget.CustomerIDCard;
    c_cus_tel.text = widget.CustomerTel;
    c_cus_tel2.text = widget.CustomerTel2;
    c_cus_address.text = widget.CustomerAddress;
    _selectedProvince = widget.CustomerProvince;

    _ProImageNetworkCus = root_url + widget.CustomerPic;

    DateTime now = DateTime.now();
    Duration age = now.difference(_bday!);
    int years = age.inDays ~/ 365;
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);

    c_pet_age.text = '$years y   $months m   $days d';

    _loadprovince();
    _loadBreed();
  }

  pickGallery() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.gallery,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImage = rotatedImage;
      //File(PickedFile.path);
      _GetImage = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();

      setState(() {});
    }
  }

  pickGalleryCus() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.gallery,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImageCus = rotatedImage;
      //File(PickedFile.path);
      _GetImageCus = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();

      setState(() {});
    }
  }

  pickCamera() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.camera,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImage = rotatedImage;
      _GetImage = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();
      setState(() {});
    }
  }

  pickCameraCus() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.camera,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImageCus = rotatedImage;
      _GetImageCus = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();
      setState(() {});
    }
  }

  void getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    ).then((value) {
      setState(() {
        _bday = value!;

        DateTime now = DateTime.now();
        Duration age = now.difference(_bday!);
        int years = age.inDays ~/ 365;
        int months = (age.inDays % 365) ~/ 30;
        int days = ((age.inDays % 365) % 30);

        c_pet_age.text = '$years y   $months m   $days d';
      });
    });
  }

  Future<void> _loadBreed() async {
    String url = "${root_url}selectbreed.php";

    final Response = await http.post(
      Uri.parse(url),

      body: {'species': _selectedSpecies},
    );

    if (Response.statusCode == 200) {
      setState(() {
        Lst_breed = json.decode(Response.body);
      });
    }
  }

  Future<void> _loadprovince() async {
    String url = "${root_url}selectprovince.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_province = json.decode(Response.body);
      });
    }
  }

  Future savePetToDatabase() async {
    String url = "${root_url}saveanimal.php";

    try {
      final Response = await http.post(
        Uri.parse(url),

        body: {
          'c_pet_id': c_pet_id.text,
          'c_pet_name': c_pet_name.text,
          'c_pet_species': c_pet_species.text,
          'c_pet_sex': c_pet_sex.text,
          'c_pet_color': c_pet_color.text,
          'c_pet_breed': c_pet_breed.text,
          'c_pet_mix': c_pet_mix.text,
          'c_pet_dob': '${_bday!.year}-${_bday!.month}-${_bday!.day}',
          'c_pet_group': c_pet_group.text,
        },
      );

      if (Response.statusCode == 200) {
        if (_GetImage == true) {
          uploadImageToPathServer();
        }

        json.decode(Response.body);

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Chern"),
            content: const Text("Save!!"),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                'Failed to Save data. Status code: ${Response.statusCode}',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Network Error'),
            content: Text('An error occurred: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future saveCusToDatabase() async {
    String url = "${root_url}savecustomer.php";

    try {
      final Response = await http.post(
        Uri.parse(url),

        body: {
          'c_cus_id': c_cus_id.text,
          'c_cus_name': c_cus_name.text,
          'c_cus_surname': c_cus_surname.text,
          'c_cus_passport': c_cus_passport.text,
          'c_cus_tel': c_cus_tel.text,
          'c_cus_tel2': c_cus_tel2.text,
          'c_cus_address': c_cus_address.text,
          'c_cus_province': c_cus_province.text,
        },
      );

      if (Response.statusCode == 200) {
        if (_GetImageCus == true) {
          uploadImageToPathServer();
        }

        json.decode(Response.body);

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Chern"),
            content: const Text("Save!!"),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                'Failed to Save data. Status code: ${Response.statusCode}',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Network Error'),
            content: Text('An error occurred: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future uploadImageToPathServer() async {
    String url = "${root_url}uploadimagepath.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _FileImage!.path,
        filename: c_pet_id.text + '.jpg',
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  Future uploadImageToPathServerCus() async {
    String url = "${root_url}uploadimagepath.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _FileImageCus!.path,
        filename: c_cus_id.text + '.jpg',
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Information",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        actions: [],
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bkbg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                readOnly: true,
                                obscureText: false,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Pet ID',
                                ),

                                controller: c_pet_id,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Pet Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: c_pet_name,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers children vertically
                                  children: <Widget>[
                                    Container(
                                      height: 110,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),

                                        image: DecorationImage(
                                          image: _FileImage == null
                                              ? _ProImageNetwork == ''
                                                    ? AssetImage(
                                                        'assets/images/NoImage.png',
                                                      )
                                                    : NetworkImage(
                                                        _ProImageNetwork,
                                                      )
                                              : FileImage(_FileImage!),
                                          fit: BoxFit.contain,
                                          opacity: 0.8,
                                        ),

                                        border: Border.all(
                                          width: 1,
                                          color: Colors.blueAccent,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(width: 5),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 190,
                                  child: DropdownSearch<String>(
                                    selectedItem: _selectedSpecies,

                                    popupProps: PopupProps.menu(
                                      showSearchBox: false,
                                    ),
                                    decoratorProps: DropDownDecoratorProps(
                                      //       baseStyle: TextStyle(color: _ColorPro),
                                      decoration: InputDecoration(
                                        labelText: 'Species',

                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    items: (filter, infiniteScrollProps) =>
                                        Lst_species.cast<String>(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedSpecies = value;
                                        _loadBreed();
                                      });
                                    },

                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please select menu';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: DropdownSearch<String>(
                                                selectedItem: _selectedSex,

                                                popupProps: PopupProps.menu(
                                                  showSearchBox: false,
                                                ),
                                                decoratorProps: DropDownDecoratorProps(
                                                  //       baseStyle: TextStyle(color: _ColorPro),
                                                  decoration: InputDecoration(
                                                    labelText: 'Sex',

                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                items:
                                                    (
                                                      filter,
                                                      infiniteScrollProps,
                                                    ) => Lst_sex.cast<String>(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedSex = value;
                                                  });
                                                },

                                                // validator: (value) {
                                                //   if (value == null ||
                                                //       value.isEmpty) {
                                                //     return 'Please select menu';
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                              ),
                                            ),

                                            const SizedBox(width: 5),

                                            SizedBox(
                                              width: 85,
                                              child: TextFormField(
                                                obscureText: false,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Color',
                                                    ),
                                                // validator: (value) {
                                                //   if (value == null ||
                                                //       value.isEmpty) {
                                                //     return 'Please enter some text';
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                                controller: c_pet_color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.photo_album_rounded,
                                      color: Color.fromARGB(255, 46, 212, 241),
                                      size: 40.0,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickGallery();
                              },
                            ),

                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: DropdownSearch<String>(
                                selectedItem: _selectedBreed,

                                popupProps: PopupProps.menu(
                                  showSearchBox: false,
                                ),

                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    labelText: 'Breed',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                items: (filter, infiniteScrollProps) =>
                                    Lst_breed.cast<String>(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedBreed = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),

                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.photo_camera_rounded,
                                      color: Color.fromARGB(255, 46, 212, 241),
                                      size: 40.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ), // Space between icon and text
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickCamera();
                              },
                            ),

                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: DropdownSearch<String>(
                                selectedItem: _selectedMix,

                                popupProps: PopupProps.menu(
                                  showSearchBox: false,
                                ),

                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    labelText: 'Mix',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                items: (filter, infiniteScrollProps) =>
                                    Lst_breed.cast<String>(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMix = value;
                                  });
                                },

                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please select menu';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                readOnly: true,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Age Y/M/D',
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter some text';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: c_pet_age,
                              ),
                            ),

                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Birth  ${_bday!.day}/${_bday!.month}/${_bday!.year}  ',
                                      selectionColor: Colors.grey,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        getDatePicker();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: DropdownSearch<String>(
                                selectedItem: _selectedGroup,

                                popupProps: PopupProps.menu(
                                  showSearchBox: false,
                                ),
                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    labelText: 'Group',

                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                items: (filter, infiniteScrollProps) =>
                                    Lst_group.cast<String>(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGroup = value;
                                  });
                                },

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select menu';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            const SizedBox(width: 5),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(190, 50),
                                foregroundColor: Colors.white,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  46,
                                  212,
                                  241,
                                ),
                                minimumSize: const Size(88, 36),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );

                                  c_pet_species.text = _selectedSpecies!;
                                  c_pet_sex.text = _selectedSex!;
                                  c_pet_breed.text = _selectedBreed!;
                                  c_pet_mix.text = _selectedMix!;
                                  c_pet_group.text = _selectedGroup!;

                                  savePetToDatabase();
                                }
                              },
                              child: Text(
                                'SAVE PET',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Card(
                  color: Colors.blue[50],
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextFormField(
                                readOnly: true,
                                obscureText: false,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ID',
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter some text';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: c_cus_id,
                              ),
                            ),
                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: c_cus_name,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Centers children vertically
                                  children: <Widget>[
                                    Container(
                                      height: 110,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),

                                        image: DecorationImage(
                                          image: _FileImageCus == null
                                              ? _ProImageNetwork == ''
                                                    ? AssetImage(
                                                        'assets/images/NoImage.png',
                                                      )
                                                    : NetworkImage(
                                                        _ProImageNetworkCus,
                                                      )
                                              : FileImage(_FileImageCus!),
                                          fit: BoxFit.contain,
                                          opacity: 0.8,
                                        ),

                                        border: Border.all(
                                          width: 1,
                                          color: Colors.blueAccent,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(width: 5),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 190,
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'SurName',
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter some text';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    controller: c_cus_surname,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                SizedBox(
                                  width: 190,
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'ID Card/Passport',
                                    ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter some text';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    controller: c_cus_passport,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.photo_album_rounded,
                                      color: const Color.fromARGB(
                                        255,
                                        10,
                                        140,
                                        163,
                                      ),
                                      size: 40.0,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickGalleryCus();
                              },
                            ),

                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Telephone',
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter some text';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: c_cus_tel,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),

                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.photo_camera_rounded,
                                      color: const Color.fromARGB(
                                        255,
                                        10,
                                        140,
                                        163,
                                      ),
                                      size: 40.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ), // Space between icon and text
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickCameraCus();
                              },
                            ),

                            const SizedBox(width: 5),

                            SizedBox(
                              width: 190,
                              child: TextFormField(
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Telephone 2',
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter some text';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                controller: c_cus_tel2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                            ),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter some text';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: c_cus_address,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: DropdownSearch<String>(
                                selectedItem: _selectedProvince,

                                popupProps: PopupProps.menu(
                                  showSearchBox: false,
                                ),
                                decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                    labelText: 'Province',

                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                items: (filter, infiniteScrollProps) =>
                                    Lst_province.cast<String>(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedProvince = value;
                                  });
                                },

                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please select menu';
                                //   } else {
                                //     return null;
                                //   }
                                // },
                              ),
                            ),

                            const SizedBox(width: 5),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(190, 50),
                                foregroundColor: Colors.white,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  10,
                                  140,
                                  163,
                                ),
                                minimumSize: const Size(88, 36),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );

                                  c_cus_province.text = _selectedProvince!;

                                  saveCusToDatabase();
                                }
                              },
                              child: Text(
                                'SAVE CUS.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
