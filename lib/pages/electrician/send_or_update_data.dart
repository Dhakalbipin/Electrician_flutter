import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SendOrUpdateData extends StatefulWidget {
  final String electrician_name;
  final String phone;
  final String address;
  final String status;
  final String rating;

  final String id;
  const SendOrUpdateData(
      {super.key,
      this.id = '',
      this.electrician_name = '',
      this.phone = '',
      this.address = '',
      this.status = '',
      this.rating = ''});
  @override
  State<SendOrUpdateData> createState() => _SendOrUpdateDataState();
}

class _SendOrUpdateDataState extends State<SendOrUpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool showProgressIndicator = false;

  @override
  void initState() {
    nameController.text = widget.electrician_name;
    phoneController.text = widget.phone;
    addressController.text = widget.address;
    statusController.text = widget.status;
    ratingController.text = widget.rating;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    statusController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
        centerTitle: true,
        title: const Text(
          'Add Electricians',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 60, bottom: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Electrician Name',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Phone',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: phoneController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: addressController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Rating',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: ratingController,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Status',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: statusController,
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                setState(() {});
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    ratingController.text.isEmpty ||
                    statusController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fill in all fields')));
                } else {
                  //reference to document
                  final dUser = FirebaseFirestore.instance
                      .collection('electricians')
                      .doc(widget.id.isNotEmpty ? widget.id : null);
                  String docID = '';
                  if (widget.id.isNotEmpty) {
                    docID = widget.id;
                  } else {
                    docID = dUser.id;
                  }
                  final jsonData = {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'address': addressController.text,
                    'rating': ratingController.text,
                    'status': statusController.text,
                    'id': docID
                  };
                  showProgressIndicator = true;
                  if (widget.id.isEmpty) {
                    //create document and write data to firebase
                    await dUser.set(jsonData).then((value) {
                      nameController.text = '';
                      phoneController.text = '';
                      addressController.text = '';
                      ratingController.text = '';
                      statusController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  } else {
                    await dUser.update(jsonData).then((value) {
                      nameController.text = '';
                      phoneController.text = '';
                      addressController.text = '';
                      ratingController.text = '';
                      statusController.text = '';
                      showProgressIndicator = false;
                      setState(() {});
                    });
                  }
                }
              },
              minWidth: double.infinity,
              height: 50,
              color: Colors.red,
              child: showProgressIndicator
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
