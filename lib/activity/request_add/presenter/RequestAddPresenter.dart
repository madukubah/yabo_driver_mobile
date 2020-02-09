
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:yabo_bank/activity/request_add/interactor/RequestAddMVPInteractor.dart';
import 'package:yabo_bank/activity/request_add/view/RequestAddMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

import 'RequestAddMVPPresenter.dart';
import 'package:image/image.dart' as _image;
import 'package:path_provider/path_provider.dart';

class RequestAddPresenter < V extends RequestAddMVPView , I extends RequestAddMVPInteractor > extends BasePresenter< V, I > implements RequestAddMVPPresenter<V, I>
{
  RequestAddPresenter(RequestAddMVPInteractor interactor) : super(interactor);

  @override
  void createRequests(dynamic formData, File image) {
    this.getView().showProgress(  );
    if( image == null )
    {
          this.getView().hideProgress(  );
          this.getView().showMessage(  'Masukkan Gambar', 0 );
          return;
    }
    interactor.doCreateRequests( formData, image ).then( ( ApiResponse response ){
          this.getView().hideProgress(  );
          if( response.success )   
            this.getView().showMessage(  response.message, 1 );
          else
            this.getView().showMessage(  response.message, 0 );
      } );
  }

  @override
  void getImage(ImageSource source) async {
    this.getView().showProgress(  );

    File image = await ImagePicker.pickImage(source: source);
    
    if (image != null) {
      _image.Image imageFile = _image.decodeJpg(image.readAsBytesSync());

      _image.Image thumbnail = _image.copyResize(imageFile, width: 500, height : 400);

      Directory appDocDirectory = await getApplicationDocumentsDirectory();

      new Directory(appDocDirectory.path + '/yabo_bank').create(recursive: true)
          // The created directory is returned as a Future.
          .then((Directory directory) {
        var name = DateTime.now().millisecondsSinceEpoch;
        File(directory.path + '/$name.png')
            .writeAsBytesSync(_image.encodePng(thumbnail));

        File imageThumbnail = File(directory.path + '/$name.png');
        this.getView().onImageLoad(  imageThumbnail );
        print('Path of New Dir: ' + directory.path);
      });
    } else
        this.getView().showMessage(  'tidak ada gambar', 0 );

    this.getView().showMessage(  '', 1 );
      
  }
}