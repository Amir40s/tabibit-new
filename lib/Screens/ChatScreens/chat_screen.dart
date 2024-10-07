import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';
import 'package:tabibinet_project/model/res/appUtils/appUtils.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/AudioPlayerProvider/audio_player_provider.dart';
import '../../Providers/chatProvider/chat_provider.dart';
import '../../audio_recording_screen.dart';
import '../../controller/audioController.dart';
import '../../global_provider.dart';
import '../../model/res/constant/app_fonts.dart';
import '../../model/res/constant/app_icons.dart';
import '../../model/res/widgets/header.dart';
import '../../model/res/widgets/text_widget.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key, required this.chatRoomId,
    required this.patientEmail,
    required this.patientName,
    required this.profilePic,
    required this.deviceToken,
    this.type = "user",
    this.problem = "",
    this.phone = "",
    this.name = ""
  });
  final String chatRoomId;
  final String patientEmail;
  final String patientName;
  final String profilePic;
  final String type,deviceToken;
  final String problem,phone,name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;  // Track recording status
  String? _audioUrl;
  AudioController audioController = Get.put(AudioController());
  late String recordFilePath;

  AudioPlayer audioPlayer = AudioPlayer();

  String audioURL = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recorder.initRecorder();
    if(widget.type == "support"){
      messageController.text  = "${widget.name} \n ${widget.phone} \n\n Problem:\n${widget.problem}";
    }
  }

  void _handleMicButton() async {

    if (_isRecording) {
      // Stop recording
      await _recorder.stopRecording();
      String? filePath = _recorder.filePath;

      if (filePath != null) {
        String? url = await uploadAudioToFirebase(
            filePath, context); // Upload to Firebase
        final provider = Provider.of<ChatProvider>(context, listen: false);
        final fcm = FCMService();
        await fcm.sendNotification(widget.deviceToken,
            "Incoming Message",
            "you have received voice message",
            widget.patientEmail);
        await provider.sendFileMessage(
          chatRoomId: widget.chatRoomId,
          fileUrl: url ?? "",
          type: "voice",
          otherEmail: widget.patientEmail,
        );
        if (url.isNotEmpty) {
          setState(() {
            _audioUrl = url;
          });

          var status = await Permission.microphone.status;
          if (!status.isGranted) {
            // Request the permission
            status = await Permission.microphone.request();

            if (status.isGranted) {
              if (_isRecording) {
                // Stop recording
                await _recorder.stopRecording();
                String? filePath = _recorder.filePath;

                if (filePath != null) {
                  String? url = await uploadAudioToFirebase(
                      filePath, context); // Upload to Firebase
                  final provider = Provider.of<ChatProvider>(
                      context, listen: false);
                  await provider.sendFileMessage(
                    chatRoomId: widget.chatRoomId,
                    fileUrl: url ?? "",
                    type: "voice",
                    otherEmail: widget.patientEmail,
                  );
                  if (url.isNotEmpty) {
                    setState(() {
                      _audioUrl = url;
                    });
                  }
                }
              } else {
                // Start recording
                await _recorder.startRecording();
              }
              setState(() {
                _isRecording = !_isRecording;
              });
            } else if (status.isDenied) {
              openAppSettings();
            } else if (status.isPermanentlyDenied) {
              openAppSettings();
            }
          }
          else {
            log("Microphone permission already granted.");
          }
        }
      }
    }
  }

  // @override
  // void dispose() {
  //   _recorder._recorder.closeRecorder();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    final doctorP = GlobalProviderAccess.profilePro;

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
                  ChatHeader(
                    name: widget.patientName,
                    picture: widget.profilePic,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: secondaryGreenColor,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40)
                          )
                      ),
                      child: StreamBuilder(
                        stream: context.read<ChatProvider>().getMessages(
                            widget.chatRoomId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator());
                          }
                          provider.markMessageAsRead(widget.chatRoomId);
                          provider.updateDeliveryStatus(
                              widget.chatRoomId);
                          final messages = snapshot.data!.docs;
                          List<Widget> messageWidgets = [];
                          for (var message in messages) {
                            final messageText = message["text"];
                            final messageSender = message["sender"];
                            final messageTimestamp = message["timestamp"];
                            final isDelivered = message["delivered"];
                            final type = message["type"];
                            final documentId = message.id.toString();

                            final relativeTime = messageTimestamp != null
                                ? timeago.format(
                                messageTimestamp.toDate())
                                : '';
                            // return ListView
                            final isCurrentUser = messageSender == AppUtils().getCurrentUserEmail();

                            final messageWidget = Dismissible(
                              key: Key(documentId),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                provider.deleteMessage(
                                    widget.chatRoomId, documentId);
                                Fluttertoast.showToast(
                                  msg: "Message deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Icon(
                                    Icons.delete, color: Colors.white),
                              ),
                              child: Align(
                                alignment: isCurrentUser ? Alignment
                                    .centerRight : Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: isCurrentUser
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  crossAxisAlignment: isCurrentUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: type == "image" ? Colors
                                            .transparent : isCurrentUser
                                            ? themeColor
                                            : Colors.white,
                                        borderRadius: BorderRadius
                                            .circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: isCurrentUser
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          type == "text" ?
                                          Text(
                                            messageText,
                                            style: TextStyle(
                                                color: isCurrentUser
                                                    ? Colors.white
                                                    : Colors.black),
                                          ) :
                                          type == "image" ?
                                          Image.network(
                                            message['url']!.toString(),
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,)
                                              :
                                          type == "document" ?
                                          Container(
                                            width: 180.0,
                                            height: 180.0,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Stack(
                                                    children: [
                                                      Image.asset(
                                                          AppAssets
                                                              .docImage),
                                                      Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .save_alt_outlined,
                                                              color: Colors
                                                                  .white,),
                                                            onPressed: () async {
                                                              log(
                                                                  "message");
                                                              await downloadFile(
                                                                  message['url'],
                                                                  message['text'],
                                                                  fallbackUrl: message['url']);
                                                            },
                                                          )
                                                      ),
                                                    ]),
                                                TextWidget(
                                                  text: "Document: ${message['text']}",
                                                  textColor: isCurrentUser
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12.0,
                                                )
                                              ],
                                            ),
                                          )
                                              : type == "voice" ?
                                          SizedBox(
                                            width: Get.width * 0.54,
                                            child: ListTile(
                                              title: const Text(
                                                  "Voice Message"),
                                              trailing: PlayButton(
                                                  audioUrl: message['url']),
                                            ),
                                          )
                                          // : type == "location"
                                          // ?

                                          // Container(
                                          //   width: Get.width * 0.54,
                                          //   height: 150,
                                          //   child: Stack(
                                          //     children: [
                                          //       GoogleMap(
                                          //         initialCameraPosition: CameraPosition(
                                          //           target: LatLng(
                                          //             double.parse(message['latitude'].toString()),
                                          //             double.parse(message['longitude'].toString()),
                                          //           ),
                                          //           zoom: 15,
                                          //         ),
                                          //         markers: {
                                          //           Marker(
                                          //             markerId: MarkerId('location'),
                                          //             position: LatLng(
                                          //               double.parse(message['latitude'].toString()),
                                          //               double.parse(message['longitude'].toString()),
                                          //             ),
                                          //           ),
                                          //         },
                                          //         // Optional: Set map type or other properties
                                          //       ),
                                          //       Positioned(
                                          //         bottom: 0,
                                          //         right: 0,
                                          //         child: IconButton(
                                          //           icon: Icon(Icons.location_on_sharp, color: Colors.blue),
                                          //           onPressed: () {
                                          //             // log("Current Message ID ${message.id}");
                                          //             _openMap(message['latitude'].toString(), message['longitude'].toString());
                                          //           },
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // )
                                          //     : type == "offer" ?
                                          // ChatOfferWidget(
                                          //   price: message['text'],
                                          //   tax: message['tax'],
                                          //   fees: message['fees'],
                                          //   total: message['total'],
                                          //   description: message['details'],
                                          //   offerStatus: message['offerStatus'],
                                          //   messageID: documentId,
                                          //   chatRoomId: chatRoomId,
                                          //   otherEmail: otherEmail,
                                          // )
                                          //
                                              : const SizedBox.shrink(),
                                          const SizedBox(height: 3),
                                          Row(
                                            mainAxisSize: MainAxisSize
                                                .min,
                                            children: [
                                              Text(
                                                relativeTime,
                                                style: TextStyle(
                                                  color: type == "image"
                                                      ?
                                                  Colors.black
                                                      : isCurrentUser ?
                                                  Colors.white70 : Colors
                                                      .grey,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              if (isCurrentUser) ...[
                                                const SizedBox(width: 5),
                                                Icon(
                                                  message["read"] ? Icons
                                                      .done_all : Icons
                                                      .done,
                                                  color: type == "image"
                                                      ? Colors.black
                                                      :
                                                  message["read"] ? Colors
                                                      .white : Colors
                                                      .white70,
                                                  size: 12,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if(isCurrentUser)
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextWidget(
                                              text: isDelivered
                                                  ? "seen"
                                                  : "deliver",
                                              fontSize: 12.0))
                                  ],
                                ),
                              ),
                            );
                            messageWidgets.add(messageWidget);
                          }
                          return ListView(
                            reverse: true,
                            children: messageWidgets,
                          );
                        },
                      ),
                    ),
                  ),
                  _buildMessageInput(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildUserMessage(String message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Widget _buildMessageInput(context) {
  Widget _buildMessageInput(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: secondaryGreenColor,
      child: Row(
        children: [
          // IconButton(
          //   icon: const Icon(Icons.camera_alt, color: themeColor),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: const Icon(Icons.photo, color: themeColor),
          //   onPressed: () {
          //     requestGalleryPermission(context);
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.mic, color: themeColor),
          //   onPressed: () {},
          // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: greyColor,
                            fontFamily: AppFonts.medium),
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
                      child: const Icon(
                          Icons.attach_file, color: greyColor)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              final provider = Provider.of<ChatProvider>(
                  context, listen: false);
              if (messageController.text.isEmpty) {
                _handleMicButton();
              }
              if (messageController.text.isNotEmpty) {
                final fcm = FCMService();
                await fcm.sendNotification(widget.deviceToken,
                    "Incoming Message", messageController.text.toString(),
                    widget.patientEmail);
                await provider.sendMessage(
                    chatRoomId: widget.chatRoomId,
                    message: messageController.text,
                    otherEmail: widget.patientEmail,
                    type: 'text'
                );
              }
              messageController.text = "";
            },
            child: Consumer<AudioPlayerProvider>(
              builder: (context, value, child) {
                return CircleAvatar(
                  backgroundColor: themeColor,
                  child: value.isLoading ? const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: CircularProgressIndicator(color: bgColor,),
                  ) :
                  SvgPicture.asset(
                    messageController.text.isEmpty
                        ? AppIcons.micIcon
                        : AppIcons.sendIcon,
                    colorFilter: ColorFilter.mode(
                        _isRecording ? redColor : bgColor,
                        BlendMode.srcIn
                    ),),
                );
              },),
          ),
        ],
      ),
    );
  }

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
                press: () async {
                  final docP = GlobalProviderAccess.medicineProvider;
                  final provider = Provider.of<ChatProvider>(
                      context, listen: false);
                  await docP!.pickFile();
                  if(docP.selectedFilePath != null){
                    final url = await docP.uploadFile();
                    final fcm = FCMService();
                    await fcm.sendNotification(widget.deviceToken,
                        "Incoming Message",
                        "you have received document file",
                        widget.patientEmail);
                    await provider.sendFileMessage(
                      chatRoomId: widget.chatRoomId,
                      fileUrl: url.toString(),
                      type: "document",
                      otherEmail: widget.patientEmail,
                    );
                  }
                },
              ),
              _buildIconOption(
                icon: Icons.photo,
                label: 'Gallery',
                color: Colors.red,
                press: () async {
                  final provider = Provider.of<ChatProvider>(
                      context, listen: false);

                  final imageP = GlobalProviderAccess.profilePro;
                  await imageP!.pickImage();
                  if(imageP.image != null){
                    final url = await imageP.uploadFileReturn();

                    final fcm = FCMService();
                    await fcm.sendNotification(widget.deviceToken,
                        "Incoming Message",
                        "you have received Image file",
                        widget.patientEmail);
                    await provider.sendFileMessage(
                      chatRoomId: widget.chatRoomId,
                      fileUrl: url.toString(),
                      type: "image",
                      otherEmail: widget.patientEmail,
                    );
                  }
                },
              ),
              _buildIconOption(
                  icon: Icons.audiotrack,
                  label: 'Audio',
                  color: Colors.blue,
                  press: () {

                  },
                  onLongPressStart: _onLongPressStart,
                  onLongPressEnd: _onLongPressEnd
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLongPressStart() async {
    log("Long press started");
    var audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource("Notification.mp3"));
    audioPlayer.onPlayerComplete.listen((a) {
      audioController.start.value = DateTime.now();
      // startRecord();
      audioController.isRecording.value = true;
    });
  }

  void _onLongPressEnd() {
    log("Long press ended");
    // Add your logic here (e.g., revert UI, stop animation, etc.)
  }

  // void startRecord() async {
  //   bool hasPermission = await checkPermission();
  //   if (hasPermission) {
  //     recordFilePath = await getFilePath();
  //     RecordMp3.instance.start(recordFilePath, (type) {
  //       setState(() {});
  //     });
  //   } else {}
  //   setState(() {});
  // }
  //
  //
  // void stopRecord() async {
  //   bool stop = RecordMp3.instance.stop();
  //   audioController.end.value = DateTime.now();
  //   audioController.calcDuration();
  //   var ap = AudioPlayer();
  //   await ap.play(AssetSource("Notification.mp3"));
  //   ap.onPlayerComplete.listen((a) {});
  //   if (stop) {
  //     audioController.isRecording.value = false;
  //     audioController.isSending.value = true;
  //   }
  // }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath =
        "${storageDirectory.path}/record${DateTime
        .now()
        .microsecondsSinceEpoch}.acc";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Widget _buildIconOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback press,
    VoidCallback? onLongPressStart, // New parameter for long press start
    VoidCallback? onLongPressEnd,
  }) {
    return GestureDetector(
      onTap: press,
      onLongPressStart: onLongPressStart != null
          ? (_) => onLongPressStart()
          : null,
      onLongPressEnd: onLongPressEnd != null
          ? (_) => onLongPressEnd()
          : null,
      child: Column(
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
      ),
    );
  }

  void _uploadPhoto(context) async {
    final provider = Provider.of<ChatProvider>(context);
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = result.files.single;
      final filePath = file.path!;
      final fileType = file.extension;
      String messageType;
      if (fileType == 'mp3' || fileType == 'wav') {
        messageType = 'voice';
      } else if (fileType == 'jpg' || fileType == 'png') {
        messageType = 'image';
      } else {
        messageType = 'document';
      }
      await provider.sendFileMessage(
        chatRoomId: widget.chatRoomId,
        fileUrl: filePath,
        type: messageType,
        otherEmail: widget.patientEmail,
      );
    }
  }

  Future<void> requestGalleryPermission(context) async {
    PermissionStatus? status;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    int sdkInt = 0;
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    sdkInt = androidInfo.version.sdkInt;
    if (sdkInt >= 33) {
      log("Message:: No storage permission required for Android 13+");
      status = await Permission.phone.request();
      requestPermissions();
    } else if (sdkInt <= 32) {
      log("Message:: Android 32+");
      status = await Permission.storage.request();
    }
    if (sdkInt >= 33) {
      _uploadPhoto(context);
    } else {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        // Request permission
        if (await Permission.photos
            .request()
            .isGranted) {
          _uploadPhoto(context);
          // Permission granted, proceed with gallery access
          // print("Gallery permission granted");
        } else {
          // Permission denied
          // print("Gallery permission denied");
        }
      } else {
        // Permission already granted
        // print("Gallery permission already granted");
      }
    }
  }

  Future<void> requestPermissions() async {
    // For Android 13 and above, request specific media permissions
    if (await Permission.photos
        .request()
        .isGranted &&
        await Permission.mediaLibrary
            .request()
            .isGranted &&
        await Permission.audio
            .request()
            .isGranted) {
      // Permission granted, you can proceed with accessing storage or media
    } else {
      // Handle permission denied scenario
      openAppSettings(); // Optionally direct the user to the app settings
    }
  }

  Future<void> downloadFile(String url, String fileName,
      {String? fallbackUrl}) async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        log("Downloading File: $url");

        // Get the application documents directory
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$fileName');

        // Make an HTTP GET request to download the file
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Write the file to the local filesystem
          await file.writeAsBytes(response.bodyBytes);
          log("File downloaded: ${file.path}");
          showToast("File downloaded: ${file.path}");
        } else {
          log("Failed to download file: ${response.statusCode}");
          showToast("Failed to download file: ${response.statusCode}");
          if (fallbackUrl != null) {
            openWebPage(fallbackUrl);
          }
        }
      } catch (e) {
        log("Error downloading file: $e");
        showToast("Error downloading file: $e");
        if (fallbackUrl != null) {
          openWebPage(fallbackUrl);
        }
      }
    }
    else if (status.isDenied) {
      log("Storage permission denied.");
      showToast(
          "Storage permission denied. Please grant storage permission to download the file.");
      if (fallbackUrl != null) {
        openWebPage(fallbackUrl);
      }
    }
    else if (status.isPermanentlyDenied) {
      log(
          "Storage permission is permanently denied, opening app settings.");
      showToast(
          "Storage permission is permanently denied. Please enable it in settings.");
      bool opened = await openAppSettings();
      log("Opened app settings: $opened");
    }
    else if (status.isRestricted) {
      log("Storage permission is restricted, cannot request permission.");
      showToast(
          "Storage permission is restricted, cannot request permission.");
      if (fallbackUrl != null) {
        openWebPage(fallbackUrl);
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> openWebPage(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchWebUrl({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

}

class PlayButton extends StatelessWidget {
  final String audioUrl;

  const PlayButton({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerProvider>(
      builder: (context, audioPlayerProvider, child) {
        bool isPlaying = audioPlayerProvider.currentPlayingUrl == audioUrl &&
            audioPlayerProvider.audioPlayerState == PlayerState.playing;

        return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            if (isPlaying) {
              audioPlayerProvider.pause();
            } else {
              audioPlayerProvider.play(audioUrl);
            }
          },
        );
      },
    );
  }



// Future<void> _deleteSelectedMessages() async {
//   final provider = Provider.of<ChatProvider>(context, listen: false);
//   for (String messageId in selectedMessages) {
//     await provider.deleteMessage(widget.chatRoomId, messageId);
//   }
//   Fluttertoast.showToast(msg: "Selected messages deleted");
// }
}