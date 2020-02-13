import 'dart:io';

import 'package:yabo_bank/activity/profile/interactor/ProfileInteractor.dart';
import 'package:yabo_bank/activity/profile/presenter/ProfilePresenter.dart';
import 'package:yabo_bank/activity/profile/view/ProfileMVPView.dart';
import 'package:yabo_bank/data/network/ApiEndPoint.dart';
import 'package:yabo_bank/data/network/AppApiHelper.dart';
import 'package:yabo_bank/data/preferences/AppPreferenceHelper.dart';
import 'package:yabo_bank/model/User.dart';
import 'package:yabo_bank/module/FIXLImage.dart';
import 'package:yabo_bank/template/form/MyForm.dart';
import 'package:yabo_bank/template/form/MyFormBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'interactor/ProfileMVPInteractor.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin
    implements ProfileMVPView {
  String pageName = "Profil";
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfilePresenter<ProfileMVPView, ProfileMVPInteractor> presenter;

  static const PROFILE_PHOTO = 1;
  static const IDENTITY_PHOTO = 2;
  FIXLImage imageHandler = FIXLImage();

  List<MyForm> dataForm = List();

  _ProfileState() {
    ProfileInteractor interactor = ProfileInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        ProfilePresenter<ProfileMVPView, ProfileMVPInteractor>(interactor);
  }

  bool _allowWriteFile = false;

  @override
  void initState() {
    super.initState();
    presenter.onAttach(this);
    presenter.getUser();
    // requestWritePermission();
  }

  requestWritePermission() async {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      setState(() {
        _allowWriteFile = true;
      });
    }
  }

  bool _status = true;
  bool userLoad = true;
  Widget message = Container(
    height: 0,
  );
  User user;
  File identityPhotoFile;
  String imageProfile = 'assets/images/as.png';
  String identityPhoto = 'default.jpg';
  final FocusNode myFocusNode = FocusNode();
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.black,
    );
    return new Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
              presenter.getUser();
          },
        child: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 200.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: (imageProfile ==
                                                "assets/images/as.png")
                                            ? new ExactAssetImage(imageProfile)
                                            : new NetworkImage(
                                                ApiEndPoint.USER_PROFILE_PHOTO +
                                                    "/$imageProfile"),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton(
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                       _openImagePickerModal( context, PROFILE_PHOTO );
                                      },
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  message //Message from api
                  ,
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: userLoad
                          ? new Center(
                              child: new Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: new CircularProgressIndicator(),
                              ),
                            )
                          : new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Informasi Akun',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 24.0, right: 24.0),
                                  child: Column(
                                    children: <Widget>[
                                      FormBuilder(
                                        key: _fbKey,
                                        autovalidate: false,
                                        child: Column(
                                          children: MyFormBuilder().create_forms(
                                              dataForm,
                                              isLabeled: true,
                                              decorationType:
                                                  DecorationType.PLAIN,
                                              readonly: _status),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                !_status ? _getActionButtons() : new Container(),
                              ],
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Simpan"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  // return;
                  setState(() {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      this.presenter.updateUser(_fbKey.currentState.value);
                    } else {
                      print(_fbKey.currentState.value);
                      print("validation failed");
                    }
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Kembali"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
          // this.dataForm.removeLast();
        });
      },
    );
  }

  @override
  void hideProgress() {
    // Navigator.pop(context);
    this.userLoad = false;
  }

  @override
  void showProgress() {
    setState(() {
      message = Container();
    });
    this.userLoad = true;
  }

  @override
  void showMessage(String message, int status) {
    List<Color> messageColor = [Colors.red, Colors.green];
    setState(() {
      this.message = Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Text(
            "$message",
            style: TextStyle(color: messageColor[status]),
          ),
        ),
      );
    });
  }

  @override
  void onUserLoad(User user) {
    this.user = user;

    List<MyForm> dataForm = [
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "name",
          label: "Nama Lengkap",
          value: user.name),
      MyForm(
          type: MyForm.TYPE_EMAIL,
          name: "email",
          label: "Email",
          value: user.email),
      MyForm(
          type: MyForm.TYPE_NUMBER,
          name: "phone",
          label: "NO HP",
          value: user.phone),
      MyForm(
          type: MyForm.TYPE_TEXT,
          name: "address",
          label: "Alamat",
          value: user.address),
    ];

    setState(() {
      this.imageProfile = user.photo;
      this.identityPhoto = user.identity_photo;
      this.dataForm = dataForm;
      this.userLoad = false;
      this._status = true;
    });
  }
  void sendImageProfile( ImageSource source ){

    imageHandler.getImage(source, 
      start:(){
        this.showProgressCircle();
      } ,
      success:( File image ){
        this.hideProgressCircle();
        presenter.uploadImage(image);
      } ,
      failed:( String message ){
        this.hideProgressCircle();
        this.showMessage( message, 0);
      } ,
    );
  }


  void _openImagePickerModal(BuildContext context, int imageType ) {
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
                    switch( imageType )
                    {
                      case PROFILE_PHOTO :
                        sendImageProfile( ImageSource.camera );
                        break;
                      case IDENTITY_PHOTO :
                        break;
                    }
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Buka Galeri'),
                  onPressed: () {
                    Navigator.pop(context);
                    switch( imageType )
                    {
                      case PROFILE_PHOTO :
                        sendImageProfile( ImageSource.gallery );
                        break;
                      case IDENTITY_PHOTO :
                        break;
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void showProgressCircle() {
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
  void hideProgressCircle() {
    Navigator.pop(context);
  }
}
