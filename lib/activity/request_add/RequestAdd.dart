import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yabo_bank/activity/request_add/presenter/RequestAddPresenter.dart';
import 'package:yabo_bank/activity/request_add/view/RequestAddMVPView.dart';
import 'package:flutter/material.dart';
import 'package:yabo_bank/data/network/AppApiHelper.dart';
import 'package:yabo_bank/data/preferences/AppPreferenceHelper.dart';
import 'package:yabo_bank/module/FIXLImage.dart';
import 'package:yabo_bank/template/form/MyForm.dart';
import 'package:yabo_bank/template/form/MyFormBuilder.dart';
import 'package:yabo_bank/util/AppConstants.dart';

import 'interactor/RequestAddInteractor.dart';
import 'interactor/RequestAddMVPInteractor.dart';

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

  FIXLImage imageHandler = FIXLImage();

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "$message",
                  style: TextStyle(color: messageColor),
                ),
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
  void getImage( ImageSource source ){

    imageHandler.getImage(source, 
      start:(){
        this.showProgress();
      } ,
      success:( File image ){
        this.hideProgress();
        setState(() {
          this._imageFile = image;
        });
      } ,
      failed:( String message ){
        this.hideProgress();
        this.showMessage( message, 0);
      } ,
    );
  }

  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
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
                      // presenter.getImage( ImageSource.camera );
                      getImage(ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Buka Galeri'),
                  onPressed: () {
                      Navigator.pop(context);
                      // presenter.getImage( ImageSource.gallery );
                      getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
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

  @override
  void onImageLoad(File image) {
    setState(() {
      this._imageFile = image;
    });
  }
}
 