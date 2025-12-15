import 'package:flutter/material.dart';

class CreateQrListTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String? title;
  const CreateQrListTile({super.key, this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1.5,
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          title: Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
        ),
      ),
    );
  }
}
