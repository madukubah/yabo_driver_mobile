import 'dart:io';

import 'package:yabo_bank/activity/profile/interactor/ProfileMVPInteractor.dart';
import 'package:yabo_bank/activity/profile/view/ProfileMVPView.dart';

abstract class ProfileMVPPresenter < V extends ProfileMVPView , I extends ProfileMVPInteractor > 
{
    // void onServerProfileClicked( Object registerData );
    void getUser(  );
    void updateUser( dynamic userData );
    void uploadImage(File image);
}