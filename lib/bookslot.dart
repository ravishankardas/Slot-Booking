// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe, unused_field, unused_local_variable, must_be_immutable, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slot_book/landing.dart';
import 'package:slot_book/pay.dart';
import 'package:slot_book/datetime_picker_widget.dart';

class BookSlot extends StatefulWidget {
  String em;
  BookSlot({Key? key, required this.em}) : super(key: key);

  @override
  _BookSlotState createState() => _BookSlotState(this.em);
}

class _BookSlotState extends State<BookSlot> {
  // final auth = FirebaseAuth.instance;
  String emailId;
  _BookSlotState(this.emailId);
  List contact = [
    'LuLu International Shopping Mall, Kochi',
    'DLF Mall of India, Noida',
    'Sarath City Capital Mall, Hyderabad',
    'Z Square Mall, Kanpur',
    'HiLITE Mall, Kozhikode',
    'World Trade Park Mall, Jaipur',
    'Phoenix Marketcity Mall, Bangalore',
    'Elante Mall, Chandigarh',
    'Esplanade One Mall, Bhubaneswar',
    'Phoenix Marketcity Mall, Chennai',
    'Mantri Square Mall, Bangalore',
    'Orion Mall, Bangalore',
    'Ambience Mall, Gurgaon',
    'Ambience Mall, Delhi',
    'The Forum Mall, Bangalore',
    'Viviana Mall, Thane',
    'Select CITYWALK Mall, Delhi',
    'Phoenix Marketcity Mall, Mumbai',
    'High Street Phoenix Mall, Mumbai',
    'Ahmedabad One Mall, Ahmedabad',
    'VR Mall, Chennai',
    'The Great India Place (GIP Mall), Noida',
    'Pacific Mall, Delhi',
    'The Grand Venice Mall, Greater Noida',
    'UB City Mall, Bangalore'
  ];

  List locations = [
    'Edappally, Kochi',
    'Sector 18, Noida',
    'Kondapur, Hyderabad',
    'The Mall, Kanpur',
    'Kozhikode Bypass, Kozhikode',
    'JLN Marg, Malviya Nagar, Jaipur',
    'Whitefield Main Road, Mahadevpura, Bangalore',
    'Industrial Area, Phase 1, Chandigarh',
    'Rasulgarh Industrial Estate, Bhubaneswar',
    'Velachery Main Road, Velachery, Chennai',
    'Sampige Road, Malleswaram, Bengaluru',
    'Dr Rajkumar Road, Malleswaram, Bengaluru',
    'DLF Phase 3, Sector 24, Gurugram',
    'Nelson Mandela Marg, Vasant Kunj, New Delhi',
    'Hosur Road, Koramangala, Bengaluru',
    'Eastern Express Highway, Thane West, Thane',
    'District Centre, Saket, New Delhi',
    'Lal Bahadur Shastri Marg, Kurla West, Mumbai',
    'Tulsi Pipe Road, Lower Parel, Mumbai',
    'T.P Scheme-1, Vastrapur, Ahmedabad',
    'Jawaharlal Nehru Road, Anna Nagar, Chennai',
    'Sector 38-A, Noida',
    'Tagore Garden, Najafgarh Road, Delhi',
    'Industrial Area Surajpur Site IV, Near Pari Chowk, Greater Noida',
    'Vittal Mallya Road, KG Halli, Bengaluru'
  ];
  List timings = [
    '9.00 am – 11.00 pm',
    '10.00 am – 10.00 pm',
    '11.00 am – 9.30 pm',
    '11.00 am – 10.00 pm',
    '10.00 am – 10.30 pm',
    '11.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '11.00 am – 11.00 pm',
    '11.00 am – 10.00 pm',
    '11.00 am – 10.00 pm',
    '11.00 am – 10.00 pm',
    '9.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '11.00 am – 10.00 pm',
    '10.00 am – 11.00 pm',
    '11.00 am – 11.00 pm',
    '10.00 am – 9.30 pm',
    '11.00 am – 10.00 pm',
    '10.00 am – 10.00 pm',
    '11.00 am – 11.00 pm',
    '10.00 am – 10.00 pm',
    '10.00 am – 11.00 pm'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text('Malls'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: contact.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LandingPage(
                          email: emailId,
                          shopName: contact[index],
                          locationShop: locations[index],
                          timeShop: timings[index],
                        ),
                      ),
                    );
                  },
                  title: Text(contact[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
