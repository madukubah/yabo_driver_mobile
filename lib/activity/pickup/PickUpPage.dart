import 'package:yabo_bank/activity/invoice_create/InvoiceCreate.dart';
import 'package:yabo_bank/activity/pickup/presenter/PickUpPresenter.dart';
import 'package:yabo_bank/activity/pickup/view/PickUpMVPView.dart';
import 'package:yabo_bank/model/PickUp.dart';
import 'package:yabo_bank/util/AppConstants.dart';
import 'package:flutter/material.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/PickUpInteractor.dart';
import 'interactor/PickUpMVPInteractor.dart';

class PickUpPage extends StatefulWidget {
  @override
  _PickUpPageState createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> implements PickUpMVPView {
  PickUpPresenter<PickUpMVPView, PickUpMVPInteractor> presenter;

  _PickUpPageState() {
    PickUpInteractor interactor = PickUpInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter = PickUpPresenter<PickUpMVPView, PickUpMVPInteractor>(interactor);
  }
  List<PickUp> pickUps = [];
  bool _isLoading = true;

  @override
  void initState() {
    presenter.onAttach(this);
    super.initState();
    presenter.getPickUps();
  }

  MediaQueryData queryData;
  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;

    TextStyle style15BoldWhite = new TextStyle(
      inherit: true,
      fontSize: 13 * devicePixelRatio,
      color: Colors.white,
    );
    TextStyle style15White = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.white,
    );
    TextStyle style15 = new TextStyle(
      inherit: true,
      fontSize: 8 * devicePixelRatio,
      color: Colors.black,
    );
    if (_isLoading)
      return new Scaffold(
        body: new Center(
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    else
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            presenter.getPickUps();
          },
          child: Container(
            // height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: Colors.blueGrey,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Daftar Penjemputan",
                                  style: style15White,
                                ),
                              ),
                            ),
                            // unprocess req
                            Column(
                              children: pickUps.map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return ListTile(
                                    onTap: (){
                                      goToInvoiceCreate( i );
                                      print( '${i.customerAddress}' );
                                    },
                                    title: Text('${i.requestInfo}'),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text('${i.customerName}'),
                                      Text('${i.customerAddress} (${i.customerPhone})'),
                                    ]),
                                    trailing: Text('${i.requestDate.split(' ')[0] }'),
                                  );
                                });
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void goToInvoiceCreate( PickUp pickUp ) async {
    // print("$itemId");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceCreate( pickUp : pickUp ),
      ),
    );
    if( result != null )
      presenter.getPickUps();
  }

  @override
  void hideProgress() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showMessage(String message, int status) {
    // TODO: implement showMessage
  }

  @override
  void showProgress() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void setPickUps(List<PickUp> items) {
    setState(() {
      this.pickUps = items;
    });
  }
}
