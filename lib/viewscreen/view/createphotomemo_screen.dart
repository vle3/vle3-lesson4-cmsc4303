// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lesson4/controller/auth_controller.dart';
import 'package:lesson4/controller/storage_controller.dart';
import 'package:lesson4/model/constants.dart';
import 'package:lesson4/model/createphotomemo_screen_model.dart';
import 'package:lesson4/model/photomemo.dart';
import 'package:lesson4/viewscreen/view/view_util.dart';

class CreatePhotoMemoScreen extends StatefulWidget {
  static const routeName = '/createPhotoMemoScreen';

  const CreatePhotoMemoScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreatePhotoMemoState();
  }
}

class _CreatePhotoMemoState extends State<CreatePhotoMemoScreen> {
  late _Controller con;
  late CreatePhotoMemoScreenModel screenModel;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    screenModel = CreatePhotoMemoScreenModel(user: Auth.user!);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${screenModel.user.email}: Create New',
        ),
        actions: [
          IconButton(
            onPressed: screenModel.progressMessage == null ? con.save : null,
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              photoPreview(),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                autocorrect: true,
                validator: PhotoMemo.validateTitle,
                onSaved: screenModel.saveTitle,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Memo',
                ),
                autocorrect: true,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                validator: PhotoMemo.validateMemo,
                onSaved: screenModel.saveMemo,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Shared With (email list separated by space , ;)',
                ),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                maxLines: 2,
                validator: PhotoMemo.validateSharedWith,
                onSaved: screenModel.saveSharedWith,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget photoPreview() {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: screenModel.photo == null
              ? const FittedBox(child: Icon(Icons.photo_library))
              : Image.file(screenModel.photo!),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            color: Colors.blue[200],
            child: PopupMenuButton(
              onSelected: con.getPhoto,
              itemBuilder: (context) {
                return [
                  for (var source in PhotoSource.values)
                    PopupMenuItem(
                      value: source,
                      child: Text(source.name.toUpperCase()),
                    ),
                ];
              },
            ),
          ),
        ),
        if (screenModel.progressMessage != null)
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              color: Colors.blue[200],
              child: Text(
                screenModel.progressMessage!,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          )
      ],
    );
  }
}

class _Controller {
  _CreatePhotoMemoState state;
  _Controller(this.state);

  Future<void> save() async {
    FormState? currenState = state.formKey.currentState;
    if (currenState == null || !currenState.validate()) {
      return;
    }
    if (state.screenModel.photo == null) {
      showSnackBar(context: state.context, message: 'Photo not selected');
      return;
    }
    currenState.save();

    try {
      Map<ArgKey, String> result = await StorageController.uploadPhotoFile(
          photo: state.screenModel.photo!,
          uid: state.screenModel.user.uid,
          listener: (int progress) {
            state.render(() {
              if (progress == 100) {
                state.screenModel.progressMessage = null;
              } else {
                state.screenModel.progressMessage = 'Uploading: $progress %';
              }
            });
            print('=========== uploading: $progress %');
          });
      print('======= ${result[ArgKey.filename]}');
      print('======= ${result[ArgKey.downloadURL]}');
    } catch (e) {
      if (Constant.devMode) {
        print('***************** upload photo/doc error: $e');
      }
      showSnackBar(
          context: state.context,
          message: '************* upload photo/doc error: $e');
    }
  }

  Future<void> getPhoto(PhotoSource source) async {
    try {
      var imageSource = source == PhotoSource.camera
          ? ImageSource.camera
          : ImageSource.gallery;
      XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return; // cancelled at camera or gallery
      state.render(() => state.screenModel.photo = File(image.path));
    } catch (e) {
      if (Constant.devMode) print('============ failed to get pic: $e');
      showSnackBar(context: state.context, message: 'Failed to get a pic: $e');
    }
  }
}
