import 'package:flutter/material.dart';

class RequestTab extends StatelessWidget {
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
                        Column(
                          children: [1, 1, 1].map((i) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                child: Padding(
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
                                          "ini sampah plastik dan besi",
                                          style: style15,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            onPressed: () {},
                                            color: Colors.orange,
                                            icon: Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            color: Colors.red,
                                            icon: Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          }).toList(),
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
                          children: [1, 1, 1, 1, 1,1].map((i) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                child: Padding(
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
                                          "ini sampah plastik dan besi",
                                          style: style15,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airport_shuttle,
                                            color: Colors.orange,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "jhon driver",
                                            style: style15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
