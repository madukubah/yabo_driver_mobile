import 'package:yabo_bank/activity/request/interactor/RequestPageInteractor.dart';
import 'package:yabo_bank/activity/request/presenter/RequestPagePresenter.dart';
import 'package:yabo_bank/activity/request/view/RequestPageMVPView.dart';
import 'package:flutter/material.dart';
import 'package:yabo_bank/model/ProcessedRequest.dart';
import 'package:yabo_bank/model/Request.dart';
import 'package:yabo_bank/widget/ProcessedRequestWidget.dart';
import 'package:yabo_bank/widget/RequestWidget.dart';

import '../../data/network/AppApiHelper.dart';
import '../../data/preferences/AppPreferenceHelper.dart';
import 'interactor/RequestPageMVPInteractor.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage>
    implements RequestPageMVPView {
  RequestPagePresenter<RequestPageMVPView, RequestPageMVPInteractor> presenter;
  bool _isLoading = true;

  List<Request> requests;
  List<ProcessedRequest> processedRequests;

  _RequestPageState() {
    RequestPageInteractor interactor = RequestPageInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());
    presenter =
        RequestPagePresenter<RequestPageMVPView, RequestPageMVPInteractor>(
            interactor);
  }

  @override
  void initState() {
    presenter.onAttach(this);
    super.initState();
    presenter.getRequests();
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
                presenter.getRequests();
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
                                  "Penjemputan",
                                  style: style15White,
                                ),
                              ),
                            ),
                            // unprocess req
                            Column(
                              children: requests.map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return RequestWidget( 
                                    request : i ,
                                    onTap : ( Request request ){
                                        showDialogDelete( request ) ;
                                    } ,
                                  );
                                });
                              }).toList(),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ///
                            Container(
                              color: Colors.blueGrey,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Penjemputan Dikonfirmasi",
                                  style: style15White,
                                ),
                              ),
                            ),
                            Column(
                              children: processedRequests.map((i) {
                                return Builder(builder: (BuildContext context) {
                                  return ProcessedRequestWidget( request : i );
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
  void setProcessedRequests(List<ProcessedRequest> items) {
    setState(() {
      this.processedRequests = items;
    });
  }

  @override
  void setRequests(List<Request> items) {
    setState(() {
      this.requests = items;
    });
  }

  Future<void> showDialogDelete( Request request ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Penjemputan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda yakin ?',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Batal',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                presenter.deleteRequests( request.id );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void refresh() {
    presenter.getRequests();
  }

}
