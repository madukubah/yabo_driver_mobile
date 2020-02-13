import 'package:url_launcher/url_launcher.dart';
import 'package:yabo_bank/activity/invoice_create/presenter/InvoiceCreatePresenter.dart';
import 'package:yabo_bank/activity/invoice_create/view/InvoiceCreateMVPView.dart';
import 'package:yabo_bank/data/network/AppApiHelper.dart';
import 'package:yabo_bank/data/preferences/AppPreferenceHelper.dart';
import 'package:yabo_bank/model/PickUp.dart';
import 'package:yabo_bank/model/PriceList.dart';
import 'package:yabo_bank/util/AppConstants.dart';
import 'package:flutter/material.dart';
import 'package:yabo_bank/widget/PriceListWidget.dart';
import 'package:intl/intl.dart';

import 'interactor/InvoiceCreateInteractor.dart';
import 'interactor/InvoiceCreateMVPInteractor.dart';

class InvoiceCreate extends StatefulWidget {
  final PickUp pickUp;

  const InvoiceCreate({Key key, this.pickUp}) : super(key: key);

  @override
  _InvoiceCreateState createState() => _InvoiceCreateState();
}

class _InvoiceCreateState extends State<InvoiceCreate>
    implements InvoiceCreateMVPView {
  MediaQueryData queryData;
  List<PriceList> priceLists = [];
  var total = 0.0;
  bool _isLoading = true;

  bool isMessageShowed = false;
  String message = "";
  Color messageColor = Colors.red;

  InvoiceCreatePresenter<InvoiceCreateMVPView, InvoiceCreateMVPInteractor>
      presenter;

  _InvoiceCreateState() {
    InvoiceCreateInteractor interactor = InvoiceCreateInteractor(
        AppPreferenceHelper.getInstance(), AppApiHelper.getInstance());

    presenter = InvoiceCreatePresenter<InvoiceCreateMVPView,
        InvoiceCreateMVPInteractor>(interactor);
  }
  @override
  void initState() {
    presenter.onAttach(this);
    super.initState();
    presenter.getPriceLists();
  }

  @override
  Widget build(BuildContext context) {
    var formatter = new NumberFormat.decimalPattern();

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
        appBar: new AppBar(
          backgroundColor: AppColor.PRIMARY,
          title: new Text("Buat Transaksi"),
          actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.phone ),
                  onPressed: () {
                    launch("tel:${widget.pickUp.customerPhone}");
                  },
                ),
              ],
        ),
        body: Container(
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
                          ListTile(
                            title: Text('${widget.pickUp.requestInfo}'),
                            subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.pickUp.customerName}'),
                                  Text('${widget.pickUp.customerAddress} (${widget.pickUp.customerPhone})'),
                                ]),
                            trailing: Text(
                                '${widget.pickUp.requestDate.split(' ')[0]}'),
                          ),

                          ///
                          Container(
                            color: Colors.blueGrey,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Buat Invoice",
                                style: style15White,
                              ),
                            ),
                          ),
                          ///////////////////////////
                          Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 400,
                                  child: ListView(
                                    children: priceLists.map((i) {
                                      return Builder(
                                          builder: (BuildContext context) {
                                        return PriceListWidget(
                                            priceList: i,
                                            onChange: (PriceList priceList) {
                                              countTotal();
                                            });
                                      });
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  color: Colors.blueGrey,
                                  width: MediaQuery.of(context).size.width,
                                  height: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 12.0, 8.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Total",
                                          style: style15,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Rp. ${formatter.format(total)}",
                                            style: style15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: isMessageShowed,
                                  child: Center(
                                    child: Text(
                                      "$message",
                                      style: TextStyle(color: messageColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                showDialogConfirm();
                              },
                              color: Colors.blue,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    'Konfirmasi',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
      );
  }

  void countTotal() {
    var _total = 0.0;
    for (var i = 0; i < priceLists.length; i++) {
      _total += priceLists[i].price * priceLists[i].quantity;
    }
    setState(() {
      this.total = _total;
    });
  }

  Future<void> showDialogConfirm() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi', style: TextStyle(color: Colors.black)),
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
                presenter.createTransaction(widget.pickUp, priceLists);
              },
            ),
          ],
        );
      },
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
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void setPriceLists(List<PriceList> items) {
    setState(() {
      this.priceLists = items;
    });
  }
}
