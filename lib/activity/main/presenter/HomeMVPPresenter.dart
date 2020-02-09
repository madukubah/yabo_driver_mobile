import 'package:yabo_bank/activity/main/interactor/HomeMVPInteractor.dart';
import 'package:yabo_bank/activity/main/view/HomeMVPView.dart';

abstract class HomeMVPPresenter < V extends HomeMVPView , I extends HomeMVPInteractor > 
{
    void logout(  );
    // void getGroups(  );
}