import 'package:yabo_bank/activity/mutation/interactor/MutationMVPInteractor.dart';
import 'package:yabo_bank/activity/mutation/view/MutationMVPView.dart';

abstract class MutationMVPPresenter < V extends MutationMVPView , I extends MutationMVPInteractor > 
{
    void getMutations( DateTime startDate, DateTime endDate );
}