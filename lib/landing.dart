// ignore_for_file: must_be_immutable

import 'package:flutter/Material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:slot_book/slot_divison.dart';

class LandingPage extends StatefulWidget {
  String email, shopName, locationShop, timeShop;
  LandingPage({
    Key? key,
    required this.email,
    required this.shopName,
    required this.locationShop,
    required this.timeShop,
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState(
      this.email, this.shopName, this.locationShop, this.timeShop);
}

class _LandingPageState extends State<LandingPage> {
  String em, shop, loc, time;
  _LandingPageState(this.em, this.shop, this.loc, this.time);

  static final DateTime theDate = DateTime.now();
  static final theDate1 =
      DateTime(theDate.year, theDate.month, theDate.day + 1);
  static final theDate2 =
      DateTime(theDate.year, theDate.month, theDate.day + 2);
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(theDate);
  final String formatted1 = formatter.format(theDate1);
  final String formatted2 = formatter.format(theDate2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          shop,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Available Dates',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SlotDivison(
                                  email: em,
                                  shop: shop,
                                  location: loc,
                                  date: formatted,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            formatted,
                            style: TextStyle(color: Colors.pink, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SlotDivison(
                                  email: em,
                                  shop: shop,
                                  location: loc,
                                  date: formatted1,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            formatted1,
                            style: TextStyle(color: Colors.pink, fontSize: 16),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     Navigator.of(context).pushReplacement(
                        //       MaterialPageRoute(
                        //         builder: (context) => SlotDivison(
                        //           email: em,
                        //           shop: shop,
                        //           location: loc,
                        //           date: formatted2,
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: Text(
                        //     formatted2,
                        //     style: TextStyle(color: Colors.pink, fontSize: 16),
                        //   ),
                        // )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
