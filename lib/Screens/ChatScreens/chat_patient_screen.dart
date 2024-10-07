import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';
import '../../model/res/constant/app_fonts.dart';
import '../../model/res/constant/app_icons.dart';
import '../../model/res/widgets/header.dart';

class ChatPatientScreen extends StatelessWidget {
  const ChatPatientScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconOption(
                icon: Icons.description,
                label: 'Document',
                color: Colors.purple,
              ),
              _buildIconOption(
                icon: Icons.photo,
                label: 'Gallery',
                color: Colors.red,
              ),
              _buildIconOption(
                icon: Icons.audiotrack,
                label: 'Audio',
                color: Colors.blue,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconOption({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Container(
          decoration: const BoxDecoration(
              color: themeColor
          ),
          child: Stack(
            children: [
              Column(
                children: [
              ///    const ChatHeader(),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: secondaryGreenColor,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40)
                          )
                      ),
                      child: ListView(
                        reverse: true,
                        padding: const EdgeInsets.all(10),
                        children: [
                          _buildUserMessage('Hi, good afternoon Michel', false,'09:10'),
                          _buildUserMessage('Hello Good Afternoon Dr.', true,'09:10'),
                          _buildUserMessage(
                              'I’ve been experiencing some discomfort in my lower abdomen',
                              true,'09:10'),
                          _buildUserMessage(
                              'Have you noticed any other symptoms, such as fever or changes in urination?',
                              false,'09:10'),
                          _buildUserMessage('Hi, good afternoon Michel', false,'09:10'),
                          _buildUserMessage('Hello Good Afternoon Dr.', true,'09:10'),
                          _buildUserMessage(
                              'I’ve been experiencing some discomfort in my lower abdomen',
                              true,'09:10'),
                          _buildUserMessage(
                              'Have you noticed any other symptoms, such as fever or changes in urination?',
                              false,'09:10'),
                          _buildUserMessage('Hi, good afternoon Michel', false,'09:10'),
                          _buildUserMessage('Hello Good Afternoon Dr.', true,'09:10'),
                          _buildUserMessage(
                              'I’ve been experiencing some discomfort in my lower abdomen',
                              true,'09:10'),
                          _buildUserMessage(
                              'Have you noticed any other symptoms, such as fever or changes in urination?',
                              false,'09:10'),
                        ],
                      ),
                    ),
                  ),
                  _buildMessageInput(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserMessage(String message, bool isSender, String time) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isSender ? Colors.white : Colors.blue, // Blue for received, white for sent
          borderRadius: isSender
              ? const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )
              : const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: isSender ? Border.all(color: Colors.grey[300]!) : null, // Border for sender
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.black87 : Colors.white, // Black text for sent, white for received
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSender ? Colors.grey : Colors.white70, // Grey time for sender, light white for receiver
                    ),
                  ),
                  if (isSender) // Show double-check icon only for sent messages
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.done_all,
                        size: 16,
                        color: Colors.blue, // Blue checkmark for seen status
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: secondaryGreenColor,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.camera_alt, color: themeColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.photo, color: themeColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: themeColor),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.emoji_emotions_outlined, color: greyColor),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: greyColor,fontFamily: AppFonts.medium),
                        hintText: 'Message',
                        fillColor: bgColor,
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        _showBottomSheet(context);
                      },
                      child: const Icon(Icons.attach_file, color: greyColor)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: themeColor,
            child: SvgPicture.asset(
              AppIcons.sendIcon,
              colorFilter: const ColorFilter.mode(
                  bgColor,
                  BlendMode.srcIn
              ),),
          ),
        ],
      ),
    );
  }

}
