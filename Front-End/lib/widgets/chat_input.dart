import 'package:Chat_App/models/chat_message_entity.dart';
import 'package:Chat_App/utils/brand_colors.dart';
import 'package:Chat_App/widgets/picker.body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class ChatInput extends StatefulWidget {
  final Function(ChatMessageEntity) onSubmit;

  const ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final controllerMessage = TextEditingController();

  String _selectedImageUrl = "";

  void onSendBtnPressed() async{
    String? userNameFromCache = context.read<AuthServices>().getUsername();
    final newChatMessage = ChatMessageEntity(
        text: controllerMessage.text,
        id: "244",
        createdAt: DateTime.now().millisecondsSinceEpoch,
        author: Author(username: userNameFromCache!));
    if(_selectedImageUrl.isNotEmpty){
      newChatMessage.imageUrl = _selectedImageUrl;
    }
    widget.onSubmit(newChatMessage);
    controllerMessage.clear();
    _selectedImageUrl = "";
  }

  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NetworkImagePicker(onImageSelected: onImagePicked);
                  });
            },
            icon: Icon(
              Icons.add,
              color: BrandColors.chatInputColor,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                controller: controllerMessage,
                style: TextStyle(color: BrandColors.chatInputColor),
                decoration: const InputDecoration(
                    hintText: "Type your message",
                    hintStyle: TextStyle(color: Colors.red),
                    border: InputBorder.none),
              ),
              if (_selectedImageUrl.isNotEmpty)
                Image.network(
                  _selectedImageUrl,
                  height: 50,
                )
            ],
          )),
          IconButton(
            onPressed: onSendBtnPressed,
            icon: Icon(
              Icons.send,
              color: BrandColors.chatInputColor,
            ),
          ),
        ],
      ),
    );
  }
}
