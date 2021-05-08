import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myweb/fieldTitle.dart';
import 'package:myweb/result.dart';
import 'package:myweb/title.dart';
import 'package:myweb/triangleDown.dart';
import 'package:myweb/triangleRight.dart';
import 'package:http/http.dart' as http;
import 'package:myweb/checkBox.dart';

// ############################################ //
//                 The Main Page                //
// ############################################ //

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIC - Tech',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// Radio button options
enum SingingCharacter {
  Yes,
  No,
  Month,
  Year,
  Two_Year,
  Electronic,
  Bank,
  Credit,
  Mail,
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final predict = GlobalKey<FormState>();
  bool isLoading = false; // to check to show the loading bar
  String tenure, charge; // save the input value
  static dynamic
      rsponse1; // save the response from the API to send it to next page

  SingingCharacter gender,
      seniorCitizen,
      partner,
      dependent,
      contract,
      payment; // save the radio value
  List<bool> services = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ]; // save the services value

  // save the name of services that provided, used to great a list of CheckBoxs
  List<Map<String, Object>> servicesName = [
    {
      "label": 'Phone_Service?',
      'num': 0,
    },
    {
      "label": 'Multiple_Lines?',
      'num': 1,
    },
    {
      "label": 'Internet_Service_Fiber? optic',
      'num': 2,
    },
    {
      "label": 'Online_Security?',
      'num': 3,
    },
    {
      "label": 'Online_Backup?',
      'num': 4,
    },
    {
      "label": 'Device_Protection?',
      'num': 5,
    },
    {
      "label": 'Tech_Support?',
      'num': 6,
    },
    {
      "label": 'Streaming_TV?',
      'num': 7,
    },
    {
      "label": 'Streaming_Movies?',
      'num': 8,
    },
  ];

  // In this function we check the validatiy of the input, and send the form to the API as json format, and get the responed and save it.
  ////////////////
  void submit() async {
    setState(() {
      isLoading = true;
    });
    bool valid = predict.currentState.validate();
    if (valid &&
        partner != null &&
        dependent != null &&
        gender != null &&
        payment != null &&
        contract != null) {
      try {
        var url = Uri.parse(
            'https://polar-peak-21219.herokuapp.com/predictAPI'); //API link

        // read the value and prepare it to the form that the API accept.
        var values = [];
        values.add(tenure);
        values.add(charge);
        values.add(gender.toString() == 'SingingCharacter.Yes' ? '1' : '0');
        values.add(
            seniorCitizen.toString() == 'SingingCharacter.Yes' ? '1' : '0');
        values.add(partner.toString() == 'SingingCharacter.Yes' ? '1' : '0');
        values.add(dependent.toString() == 'SingingCharacter.Yes' ? '1' : '0');
        values.add(services[0] == true ? '1' : '0');
        values.add(services[1] == true ? '1' : '0');
        values.add(services[2] == true ? '1' : '0');
        values.add(services[3] == true ? '1' : '0');
        values.add(services[4] == true ? '1' : '0');
        values.add(services[5] == true ? '1' : '0');
        values.add(services[6] == true ? '1' : '0');
        values.add(services[7] == true ? '1' : '0');
        values.add(services[8] == true ? '1' : '0');
        values.add(contract.toString() == 'SingingCharacter.Year' ? '1' : '0');
        values.add(
            contract.toString() == 'SingingCharacter.Two_Year' ? '1' : '0');
        values.add(payment.toString() == 'SingingCharacter.Credit' ? '1' : '0');
        values.add(
            payment.toString() == 'SingingCharacter.Electronic' ? '1' : '0');
        values.add(payment.toString() == 'SingingCharacter.Mail' ? '1' : '0');
        print(values);
        var response = await http.post(
          url,
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Accept": "application/json",
            'Access-Control-Allow-Methods': 'GET, POST',
            "Access-Control-Allow-Headers": "X-Requested-With"
          },
          body: jsonEncode(values),
        );
        print('API reply: ' + response.statusCode.toString());
        print('API reply json: ' + response.body);

        setState(() {
          rsponse1 = json.decode(response.body);
        });
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).push(_createRoute());
      } catch (e) {
        print(e);
      }
    } else if (valid) {
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            void closeDialog() {
              Navigator.of(context).pop();
            }

            return AlertDialog(
              title: Column(
                children: [
                  Text(
                    'Please make sure you fill all the field.',
                  ),
                  Divider(
                    height: 3,
                  ),
                ],
              ),
            );
          });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool validateIntNumber(String value) {
    if (value == null) return false;
    String pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateFloatNumber(String value) {
    if (value == null) return false;
    String pattern = r'(^[0-9]*)([.]?)([0-9]*)$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  // style the input failed
  InputDecoration getStyle() {
    return InputDecoration(
      fillColor: Colors.teal[50],
      filled: true,
      errorStyle: TextStyle(
          fontSize: 12.0, color: Colors.red[900], fontWeight: FontWeight.bold),
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        borderSide: BorderSide(color: Colors.teal[900], width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        borderSide: BorderSide(color: Colors.teal[900], width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
    );
  }

  // A form of services field, and contract and payment method, used a function to use it in two places.
  Widget getSecondListForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        FieldTitle('Services ?'),
        ...servicesName.map((e) {
          return LabeledCheckbox(
            label: e['label'],
            value: services[e['num']],
            onChanged: (bool newValue) {
              setState(() {
                services[e['num']] = newValue;
              });
            },
          );
        }).toList(),
        SizedBox(
          height: 20,
        ),
        FieldTitle('Contract ?'),
        if (MediaQuery.of(context).size.width < 800)
          Column(
            children: [
              getOneRadio(
                SingingCharacter.Month,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'Month to Month',
              ),
              getOneRadio(
                SingingCharacter.Year,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'One Year',
              ),
              getOneRadio(
                SingingCharacter.Two_Year,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'Two Years',
              ),
            ],
          ),
        if (MediaQuery.of(context).size.width > 800)
          Row(
            children: [
              getOneRadio(
                SingingCharacter.Month,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'Month to Month',
              ),
              getOneRadio(
                SingingCharacter.Year,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'One Year',
              ),
              getOneRadio(
                SingingCharacter.Two_Year,
                contract,
                (SingingCharacter value) {
                  setState(() {
                    contract = value;
                  });
                },
                'Two Years',
              ),
            ],
          ),
        SizedBox(
          height: 20,
        ),
        FieldTitle('Payment Method ?'),
        if (MediaQuery.of(context).size.width < 800)
          Column(
            children: [
              getOneRadio(
                SingingCharacter.Credit,
                payment,
                (SingingCharacter value) {
                  setState(() {
                    payment = value;
                  });
                },
                'Credit Card',
              ),
              getOneRadio(
                SingingCharacter.Electronic,
                payment,
                (SingingCharacter value) {
                  setState(() {
                    payment = value;
                  });
                },
                'Electronic Check',
              ),
              getOneRadio(
                SingingCharacter.Bank,
                payment,
                (SingingCharacter value) {
                  setState(() {
                    payment = value;
                  });
                },
                'Bank Transfer',
              ),
              getOneRadio(
                SingingCharacter.Mail,
                payment,
                (SingingCharacter value) {
                  setState(() {
                    payment = value;
                  });
                },
                'Mailed Check',
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        if (MediaQuery.of(context).size.width > 800)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    getOneRadio(
                      SingingCharacter.Credit,
                      payment,
                      (SingingCharacter value) {
                        setState(() {
                          payment = value;
                        });
                      },
                      'Credit Card',
                    ),
                    getOneRadio(
                      SingingCharacter.Electronic,
                      payment,
                      (SingingCharacter value) {
                        setState(() {
                          payment = value;
                        });
                      },
                      'Electronic Check',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    getOneRadio(
                      SingingCharacter.Bank,
                      payment,
                      (SingingCharacter value) {
                        setState(() {
                          payment = value;
                        });
                      },
                      'Bank Transfer',
                    ),
                    getOneRadio(
                      SingingCharacter.Mail,
                      payment,
                      (SingingCharacter value) {
                        setState(() {
                          payment = value;
                        });
                      },
                      'Mailed Check',
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget getYesNoRadio(
    SingingCharacter groupValue1,
    Function onChange1,
    bool isMale,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          value: SingingCharacter.Yes,
          groupValue: groupValue1,
          onChanged: onChange1,
        ),
        Text(isMale ? 'Male' : 'YES'),
        SizedBox(
          width: 20,
        ),
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          activeColor: Colors.blue,
          value: SingingCharacter.No,
          groupValue: groupValue1,
          onChanged: onChange1,
        ),
        Text(isMale ? 'Female' : 'NO'),
      ],
    );
  }

  Widget getOneRadio(
    SingingCharacter value1,
    SingingCharacter groupValue1,
    Function onchange1,
    String label,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
        Radio(
          fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
          value: value1,
          groupValue: groupValue1,
          onChanged: onchange1,
        ),
        Text(label),
      ],
    );
  }

  // statr buliding the UI, using other widget files like, fieldTitle, checkBox, ...
  @override
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Form(
                          key: predict,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FieldTitle('Tenure Months ?'),
                                          Container(
                                            width: 250,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter a valid number.';
                                                } else if (!validateIntNumber(
                                                    value)) {
                                                  return 'Please enter a valid number.';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                tenure = value;
                                              },
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                              decoration: getStyle().copyWith(
                                                  hintText:
                                                      'Enter Number of Tenure Months'),
                                              //reusableInputDecorationOutLine(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          FieldTitle('Monthly Charge?'),
                                          Container(
                                            width: 250,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter a valid number.';
                                                } else if (!validateFloatNumber(
                                                    value)) {
                                                  return 'Please enter a valid number.';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                charge = value;
                                              },
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),
                                              decoration: getStyle().copyWith(
                                                  hintText:
                                                      'Enter Number of Monthly Charges'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FieldTitle('Gender ?'),
                                          getYesNoRadio(
                                            gender,
                                            (SingingCharacter value) {
                                              setState(() {
                                                gender = value;
                                              });
                                            },
                                            true,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FieldTitle('Senior Citizen ?'),
                                          getYesNoRadio(
                                            seniorCitizen,
                                            (SingingCharacter value) {
                                              setState(() {
                                                seniorCitizen = value;
                                              });
                                            },
                                            false,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FieldTitle('Partner ?'),
                                          getYesNoRadio(
                                            partner,
                                            (SingingCharacter value) {
                                              setState(() {
                                                partner = value;
                                              });
                                            },
                                            false,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FieldTitle('Dependent ?'),
                                          getYesNoRadio(
                                            dependent,
                                            (SingingCharacter value) {
                                              setState(() {
                                                dependent = value;
                                              });
                                            },
                                            false,
                                          ),
                                          if (MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              800)
                                            getSecondListForm(),
                                        ]),
                                  ),
                                  if (MediaQuery.of(context).size.width > 800)
                                    Expanded(
                                      flex: 3,
                                      child: getSecondListForm(),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (MediaQuery.of(context).size.width < 800)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: 300,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              submit();
                            },
                            child: CustomPaint(
                              painter: TrianglePainterDown(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (MediaQuery.of(context).size.width > 800)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width < 1450
                              ? 75
                              : 130,
                        ),
                        child: Container(
                          width: 50,
                          height: 100,
                          child: GestureDetector(
                            onTap: () {
                              submit();
                            },
                            child: CustomPaint(
                              painter: TrianglePainter(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  TitleWidget('Telec Churn Customer Preduction'),
                  if (isLoading)
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.teal[300].withOpacity(0.4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.teal[100]),
                                  strokeWidth: 5,
                                )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

// Animation code, and map to next page.
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
