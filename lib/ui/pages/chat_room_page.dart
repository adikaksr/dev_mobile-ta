import 'dart:math';
import 'package:easkripsi/shared/theme.dart';
import 'package:easkripsi/ui/widgets/item_chat.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:easkripsi/controller/chat_room_controller.dart';
import 'package:get/get.dart';

import '../../controller/text_controller.dart';

class ChatRoomPage extends StatefulWidget {
  final String chatId;
  final String chatName;
  final String nipDosen;

  ChatRoomPage(
      {required this.chatId, required this.chatName, required this.nipDosen});
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<String> messages = [];
  final TextEditingController messageController = TextEditingController();
  final textController = Get.find<TextController>();
  bool isShowEmoji = false;
  FocusNode focusNode = FocusNode();
  ChatRoomController controller = Get.put(ChatRoomController());

  @override
  void initState() {
    super.initState();
    messageController.addListener(() {
      if (messageController.text.length > 0 && isShowEmoji) {
        setState(() {
          isShowEmoji = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5),
              Icon(Icons.arrow_back),
              SizedBox(width: 5),
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/image_avatar.png'),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatName,
              style: blackTextStyle.copyWith(
                fontSize: 15,
                fontWeight: medium,
              ),
            ),
            // Text(
            //   'Status',
            //   style: grayTextStyle.copyWith(
            //     fontSize: 13,
            //     fontWeight: light,
            //   ),
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView(
                // itemCount: messages.length,
                // itemBuilder: (context, index) {
                //   return ListTile(
                //     title: Text(messages[index]),
                //   );
                // },
                children: [
                  ItemChat(
                    isSender: true,
                    message: 'Assalamualaikum',
                  ),
                  ItemChat(
                    isSender: false,
                    message: 'waalaikumsalam',
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kGreyColor, // Set the background color to gray
                      borderRadius:
                          BorderRadius.circular(100), // Add border radius
                    ),
                    child: TextField(
                      onTap: () {
                        if (isShowEmoji) {
                          setState(() {
                            isShowEmoji = false;
                          });
                        }
                      },
                      focusNode: focusNode,
                      controller: controller.chatC,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            if (isShowEmoji) {
                              Future.delayed(Duration.zero, () {
                                focusNode.requestFocus();
                              });
                            } else {
                              Future.delayed(Duration.zero, () {
                                focusNode.unfocus();
                              });
                            }
                            setState(() {
                              isShowEmoji = !isShowEmoji;
                            });
                          },
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        suffixIcon: Transform.rotate(
                          angle: 45 * pi / 180, // Rotate the icon 45 degrees
                          child: IconButton(
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.photo_library),
                                            title: Text('Photo Library'),
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.image);
                                              if (result != null) {
                                                PlatformFile file =
                                                    result.files.first;
                                                print(file.name);
                                                // Do something with the file
                                              }
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.file_upload),
                                            title: Text('File'),
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles();
                                              if (result != null) {
                                                PlatformFile file =
                                                    result.files.first;
                                                print(file.name);
                                                // Do something with the file
                                              }
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                                Icons.attach_file), // Use the attach_file icon
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Masukkan pesan...',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFF696CFF),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      controller.newChat(
                          textController.nimMahasiswa.value,
                          widget.nipDosen,
                          widget.chatId,
                          controller.chatC.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 25, // Set the width
                        height: 25, // Set the height
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isShowEmoji)
            Container(
              height: 325,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  controller.addEmojiToChat(emoji);
                },
                onBackspacePressed: () {
                  controller.deleteEmoji();
                },
                // textEditingController:
                //     textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                config: Config(
                  columns: 7,
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  recentTabBehavior: RecentTabBehavior.RECENT,
                  recentsLimit: 28,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ), // Needs to be const Widget
                  loadingIndicator:
                      const SizedBox.shrink(), // Needs to be const Widget
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
