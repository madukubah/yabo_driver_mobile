import 'dart:io';

import 'package:yabo_bank/activity/request_add/interactor/RequestAddMVPInteractor.dart';
import 'package:yabo_bank/activity/request_add/view/RequestAddMVPView.dart';

abstract class RequestAddMVPPresenter < V extends RequestAddMVPView , I extends RequestAddMVPInteractor > 
{
    void createRequests( dynamic formData, File image );
}