import 'package:flutter/material.dart';

class MutationTab extends StatelessWidget {
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
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3 - 100,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          color: Colors.blue,
                          // child: new Image.asset(
                          //   'images/sapi.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3 - 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xCC000000),
                              const Color(0x00000000),
                              const Color(0xCC000000),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        bottom: 30,
                        child: Container(
                            // color: Colors.pink,
                            height: 100.0,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Saldo : Rp. 1.200.000",
                                  style: style15BoldWhite,
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "1 jan 2020",
                                  style: style15White,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Sampai",
                                  style: style15White,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "30 jan 2020",
                                  style: style15White,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Total Debit",
                                      style: style15,
                                    ),
                                    Text(
                                      "Rp. 100.000",
                                      style: style15,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Total Kredit",
                                      style: style15,
                                    ),
                                    Text(
                                      "Rp. 100.000",
                                      style: style15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "4/1/2020",
                                  style: style15White,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width /2,
                                  child: 
                                    Text(
                                      "transaction to customer Customer_1579500670: plastik,1000,kg,qty:4driver:c alin",
                                      style: style15,
                                    ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Rp. 100.000",
                                      style: style15,
                                    ),
                                  ],
                                ),
                              ],
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
}
