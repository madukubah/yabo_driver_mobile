import 'package:yabo_bank/activity/pickup/interactor/PickUpMVPInteractor.dart';
import 'package:yabo_bank/activity/pickup/view/PickUpMVPView.dart';

abstract class PickUpMVPPresenter < V extends PickUpMVPView , I extends PickUpMVPInteractor > 
{
    void getPickUps(  );
}