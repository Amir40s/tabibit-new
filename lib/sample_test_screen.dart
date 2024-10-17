import 'package:flutter/material.dart';
import 'package:tabibinet_project/test_call_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _channelController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Video Call Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _channelController,
              decoration: InputDecoration(labelText: 'Enter Channel Name'),
            ),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'Enter User ID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String channelName = _channelController.text.trim();
                int userId = int.parse(_userIdController.text.trim());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoCallScreen(
                      channelName: channelName,
                      userId: userId,
                    ),
                  ),
                );
              },
              child: Text('Start Video Call'),
            ),
          ],
        ),
      ),
    );
  }
}
