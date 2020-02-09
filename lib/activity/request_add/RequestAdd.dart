import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yabo_bank/activity/request_add/presenter/RequestAddPresenter.dart';
import 'package:yabo_bank/activity/request_add/view/RequestAddMVPView.dart';
import 'package:flutter/material.dart';
import 'package:yabo_bank/data/network/AppApiHelper.dart';
import 'package:yabo_bank/data/preferences/AppPreferenceHelper.dart';
import 'package:yabo_bank/template/form/MyForm.dart';
import 'package:yabo_bank/template/form/MyFormBuilder.dart';
import 'package:yabo_bank/util/AppConstants.dart';

import 'interactor/RequestAddInteractor.dart';
import 'interactor/RequestAddMVPInteractor.dart';
import 'package:image/image.dart' as _image;

class RequestAdd extends StatefulWidget {
  @override
  _RequestAddState createState() => _RequestAddState();
}

class _RequestAddState extends State<RequestAdd> implements RequestAddMVPView {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  RequestAddPresenter<RequestAddMVPView, RequestAddMVPInteractor> presenter;

  List<MyForm> dataForm = [
    MyForm(type: MyForm.TYPE_TEXTAREA, name: "info", label: "Keterangan"),
  ];

  bool isMessageShowed = false;
  String message = "";
  Color messageColor = Colors.red;
  File _imageFile;

  _RequestAddState() {
    RequestAddInteractor interactor = RequestAddInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = RequestAddPresenter<RequestAddMVPView, RequestAddMVPInteractor>(
        interactor);
  }

  @override
  void initState() {
    presenter.onAttach(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        // isButtonDisabled : true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            print(_fbKey.currentState.value);
            presenter.createRequests(_fbKey.currentState.value, this._imageFile);
          } else {
            print(_fbKey.currentState.value);
            print("validation failed");
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue,
        child: Text('Kirim', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColor.PRIMARY,
        title: new Text("Buat Penjemputan"),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          Visibility(
            visible: isMessageShowed,
            child: Center(
              child: Text(
                "$message",
                style: TextStyle(color: messageColor),
              ),
            ),
          ),
          FormBuilder(
            key: _fbKey,
            autovalidate: false,
            child: Column(
              children: MyFormBuilder().create_forms(dataForm,
                  isLabeled: true, decorationType: DecorationType.PLAIN),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: FlatButton(
              child: new CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 25.0,
                child: new Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                // _getImage(context, ImageSource.gallery);
                _openImagePickerModal( context );
                print("CAMERA");
              },
            ),
          ),
          SizedBox(height: 4.0),
          this._imageFile == null
              ? Image.asset(
                  "assets/images/placehoder.jpg",
                  fit: BoxFit.contain,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                )
              : Image.file(
                  _imageFile,
                  fit: BoxFit.contain,
                  height: 300.0,
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                ),
          SizedBox(height: 24.0),
          submitButton,
        ],
      ),
    );
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Ambil Gambar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Gunakan Kamera'),
                  onPressed: () {
                      Navigator.pop(context);
                      _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Buka Galeri'),
                  onPressed: () {
                      Navigator.pop(context);
                      _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    // // Closes the bottom sheet

    if (image != null) {
      _image.Image imageFile = _image.decodeJpg(image.readAsBytesSync());

      _image.Image thumbnail = _image.copyResize(imageFile, width: 500);

      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      print(appDocDirectory.path);
      print(Directory.current.path);

      new Directory(appDocDirectory.path + '/yabo_bank').create(recursive: true)
          // The created directory is returned as a Future.
          .then((Directory directory) {
        var name = DateTime.now().millisecondsSinceEpoch;
        File(directory.path + '/$name.png')
            .writeAsBytesSync(_image.encodePng(thumbnail));

        File imageThumbnail = File(directory.path + '/$name.png');

        setState(() {
          this._imageFile = imageThumbnail;
        });
        // presenter.uploadImage(imageThumbnail);
        print('Path of New Dir: ' + directory.path);
      });
    } else
      print("tidak ada gambar");
  }

  @override
  void hideProgress() {
    Navigator.pop(context);
  }

  @override
  void showMessage(String message, int status) {
    if (status == 1) {
      Navigator.pop(context, 1);
      return;
    }
    List<Color> messageColor = [Colors.red, Colors.green];
    setState(() {
      this.message = message;
      this.isMessageShowed = true;
      this.messageColor = messageColor[0];
    });
  }

  @override
  void showProgress() {
    print("showProgress");
    showDialog(
      barrierDismissible: false,
      context: context,
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
