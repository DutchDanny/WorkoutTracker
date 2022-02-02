import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workout_tracker/util/StringTool.dart';
import 'package:workout_tracker/util/objectbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileSettingsWidget extends StatefulWidget {
  late ObjectBox objectbox;
  ProfileSettingsWidget({Key? key, required this.objectbox,}) : super(key: key);

  @override
  State createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettingsWidget> {

  ImagePicker picker = ImagePicker();
  TextEditingController nameController = new TextEditingController();
  File? img_file;
  Image? img;

  @override
  void initState() {
    super.initState();
    String initName = widget.objectbox.getPref("user_name");
    nameController.text = initName != null ? initName : "";
    getUserImage();
  }

  getUserImage() async {
    String? profileImage = widget.objectbox.getPref('profile_image');
    if(profileImage == null)
      return;

    img = imageFromBase64String(profileImage);
    setState(() {});
  }

  Future<Null> _cropImage(String path) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
        ]
            : [
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        /*
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        */
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.amberAccent,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      setState(() {
        img_file = croppedFile;
        img = Image.file(img_file!);
      });
    }
  }

  void getImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image == null)
      return;
    _cropImage(image.path);
  }

  void saveChanges()
  {
    if(nameController.text.trim().isEmpty) {
      final snackBar = SnackBar(
        content: const Text('Please enter your name'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if(img_file != null)
    {
      String profile_image = base64toString(img_file!.readAsBytesSync());
      widget.objectbox.setPref("profile_image", profile_image);
    }

    widget.objectbox.setPref("user_name", nameController.text);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.05),
                expandedHeight: 100.0,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Edit Profile'),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child:Center(
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CircleAvatar(
                                radius: 63,
                               backgroundColor: Colors.amberAccent,
                               child: CircleAvatar(
                                 radius: 60,
                                 child: ClipOval(
                                   child: (img != null)
                                       ? img!
                                       : null,
                                 ),
                                ),
                              ),
                              Container(
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 2,
                                      offset: Offset(0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  iconSize: 16,
                                  onPressed: (){
                                    getImage();
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text("Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  title: new Row(
                                    children: <Widget>[
                                      new Flexible(
                                          child: new TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              border:InputBorder.none,
                                            ),
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          color: Theme.of(context).colorScheme.primary,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                    onTap:(){
                                      saveChanges();
                                    },
                                    title: Text("Save Changes",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                )
                              ]
                          )
                      ),// Save Bu
                    ]),
              ),
            ],
          ),
        )
    );
  }
}