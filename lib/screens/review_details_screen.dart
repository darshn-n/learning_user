import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/screens/main_screen.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewDetailsScreen extends StatefulWidget {
  const ReviewDetailsScreen({
    super.key,
  });
  static const id = "review-details-screen";

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool validate = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController()
    ..text = "+91";
  final TextEditingController _contactNumberController =
      TextEditingController();
  final FirebaseService _service = FirebaseService();
  @override
  void dispose() {
    _nameController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: kscreenBackground,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text(
              'Review Your Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: kscreenBackground,
                      radius: 35,
                      child: const Icon(
                        Icons.person,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Contact Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _countryCodeController,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Mobile Number",
                      ),
                      keyboardType: TextInputType.number,
                      autofillHints: const [
                        AutofillHints.telephoneNumber,
                      ],
                      controller: _contactNumberController,
                      maxLength: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () async {
          setState(
            () {
              _contactNumberController.text.isEmpty ||
                      _nameController.text.isEmpty
                  ? validate = true
                  : validate = false;
            },
          );
          if (validate == false) {
            _service.updateUser({
              "mobile": _contactNumberController.text,
              "name": "${FirebaseAuth.instance.currentUser!.displayName}",
            }, context).then(
              (value) => Navigator.pushNamed(context, MainScreen.id),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please Enter the Required Fields',
                ),
                duration: Duration(
                  seconds: 2,
                ),
              ),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
