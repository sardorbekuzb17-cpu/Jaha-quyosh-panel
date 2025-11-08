import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final Map<String, dynamic> updateInfo;
  final Function() onUpdate;
  final Function() onLater;
  
  const UpdateDialog({
    Key? key,
    required this.updateInfo,
    required this.onUpdate,
    required this.onLater,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.system_update, color: Colors.blue),
          SizedBox(width: 10),
          Text('Yangi Yangilash'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Yangi versiya mavjud!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Joriy versiya: ${updateInfo['currentVersion']}'),
            Text('Yangi versiya: ${updateInfo['latestVersion']}'),
            const SizedBox(height: 15),
            if (updateInfo['releaseNotes'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yangilanishlar:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    updateInfo['releaseNotes'].toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onLater,
          child: const Text('Keyin'),
        ),
        ElevatedButton(
          onPressed: onUpdate,
          child: const Text('Yangilash'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}