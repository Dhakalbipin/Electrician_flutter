import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrician/pages/electrician/send_or_update_data.dart';
import 'package:flutter/material.dart';

class ElectricianListTile extends StatelessWidget {
  const ElectricianListTile({
    super.key,
    required this.electrician,
  });

  final QueryDocumentSnapshot<Object?> electrician;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/electrician.jpg',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Electrician Name: ${electrician['name']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Phone: ${electrician['phone']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Address: ${electrician['address']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Rating: ${electrician['rating']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      size: 10,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: ${electrician['status']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendOrUpdateData(
                        electrician_name: electrician['name'],
                        phone: electrician['phone'].toString(),
                        address: electrician['address'],
                        rating: electrician['rating'].toString(),
                        status: electrician['status'],
                        id: electrician.id,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.green,
                  size: 21,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final docData = FirebaseFirestore.instance
                      .collection('electricians')
                      .doc(electrician.id);
                  await docData.delete();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red.shade900,
                  size: 21,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
