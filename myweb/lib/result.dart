import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myweb/main.dart';
import 'package:myweb/title.dart';
import 'package:myweb/triangleLeft.dart';


// ############################################ //
//             The Result Page                 //
// ############################################ //

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Center(
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width > 800
                  ? MediaQuery.of(context).size.width - 500
                  : MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 1200),
                        width: MediaQuery.of(context).size.width > 800
                            ? MediaQuery.of(context).size.width - 200
                            : MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.height - 120,
                        padding: EdgeInsets.only(
                            left: 60, right: 60, top: 90, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [
                              0.01,
                              0.99,
                              0.99,
                            ],
                            colors: [
                              Colors.teal[800],
                              Colors.teal[400],
                              Colors.teal[400],
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              if (MyHomePageState.rsponse1[1] == '1')
                                Column(
                                  children: [
                                    Text(
                                      'This Customer is likely to Churn',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Colors.teal[100],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Probability that the customer will churn is: ',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          double.parse(MyHomePageState
                                                      .rsponse1[1])
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Probability that the customer will not churn is: ',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          double.parse(MyHomePageState
                                                      .rsponse1[2])
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (MyHomePageState.rsponse1[0] == '0')
                                Column(
                                  children: [
                                    Text(
                                      'This Customer is not likely to Churn',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Colors.teal[100],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Probability that the customer will not churn is: ',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          double.parse(MyHomePageState
                                                      .rsponse1[2])
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Probability that the customer will churn is: ',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          double.parse(MyHomePageState
                                                      .rsponse1[1])
                                                  .toStringAsFixed(2) +
                                              '%',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (MediaQuery.of(context).size.width > 800)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width < 1450
                                ? 75
                                : 130,
                          ),
                          child: Container(
                            width: 50,
                            height: 100,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CustomPaint(
                                painter: TrianglePainterLeft(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    TitleWidget('Prediction Result:'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
