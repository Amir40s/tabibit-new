import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/ChatScreens/chat_screen.dart';
import 'package:tabibinet_project/Screens/ChatScreens/search_controller.dart';
import 'package:tabibinet_project/constant.dart';

import '../../../Providers/chatProvider/chat_provider.dart';
import '../../../controller/translation_controller.dart';
import '../../../model/data/chatModel/chatRoomModel.dart';
import '../../../model/data/chatModel/userChatModel.dart';
import '../../../model/res/widgets/chat_user_card.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/image_loader.dart';
import '../../../model/res/widgets/text_widget.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatSearchController());
    final transController = Get.put(TranslationController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Message"),
            Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                    return Obx(() {
                      final searchQuery = controller.searchQuery.value.toLowerCase();
                      return StreamBuilder<List<ChatRoomModel>>(
                        stream: chatProvider.getChatRoomsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('No chats available'.tr),
                            );
                          }

                          var chatRooms = snapshot.data!
                              .where((chatRoom) {
                            var otherUserEmail = chatRoom.users
                                .firstWhere((user) => user != getCurrentUid().toString());
                            var otherUser = chatProvider.users.firstWhere(
                                  (user) => user.email == otherUserEmail,
                              orElse: () => UserchatModel(
                                id: '',
                                name: 'Support',
                                email: otherUserEmail,
                                profileUrl: '',
                                userUid: '',
                                deviceToken: '',
                              ),
                            );
                            return otherUser.name.toLowerCase().contains(searchQuery);
                          }).toList();

                          if (chatRooms.isEmpty) {
                            return const Center(
                              child: Text('No chats match the search criteria'),
                            );
                          }

                          return ListView.separated(
                            itemCount: chatRooms.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index >= chatRooms.length) {
                                return const SizedBox.shrink();
                              }
                              final chatRoom = chatRooms[index];
                              final unreadCount = chatProvider.unreadMessageCounts[chatRoom.id] ?? 0;
                              var otherUserEmail = chatRoom.users
                                  .firstWhere((user) => user != getCurrentUid().toString());
                              var lastMessage = chatRoom.lastMessage;
                              var timeStamp = chatRoom.lastTimestamp;

                              var otherUser = chatProvider.users.firstWhere(
                                    (user) => user.email == otherUserEmail,
                                orElse: () => UserchatModel(
                                  id: '',
                                  name: 'Unknown',
                                  email: otherUserEmail,
                                  profileUrl: '',
                                  userUid: '',
                                  deviceToken: '',
                                ),
                              );



                              return ListTile(
                                leading: CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: ImageLoaderWidget(imageUrl: otherUser.profileUrl),
                                  ),
                                ),
                                title: TextWidget(
                                  text: transController.translations[otherUser.name] ?? otherUser.name,
                                  fontSize: 14.0,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                subtitle: TextWidget(
                                  text: lastMessage ?? '',
                                  fontSize: 12.0,
                                  maxLines: 1,
                                  textColor: Colors.grey,
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      text: timeStamp != null ? convertTimestamp(timeStamp.toString()) : '',
                                      fontSize: 12.0,
                                      textColor: Colors.black,
                                    ),
                                    const SizedBox(height: 10.0),
                                    unreadCount > 0
                                        ? CircleAvatar(
                                      radius: 7,
                                      backgroundColor: themeColor,
                                    )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                                onTap: () async {
                                  final chatRoomId = await context
                                      .read<ChatProvider>()
                                      .createOrGetChatRoom(otherUser.email, "");
                                  // final userBlockStatus = await context
                                  //     .read<ChatProvider>()
                                  //     .getUserStatus(chatRoomId);
                                  context.read<ChatProvider>().updateMessageStatus(chatRoomId);

                                  Get.to(() => ChatScreen(
                                    patientName: otherUser.name,
                                   profilePic : otherUser.profileUrl,
                                    patientEmail: otherUser.email,
                                    chatRoomId: chatRoomId,
                                    deviceToken: otherUser.deviceToken,
                                  ));
                                  // await chatProvider.getUnreadMessageCount(chatRoom.id);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Colors.grey,
                              );
                            },
                          );
                        },
                      );
                    });
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}
