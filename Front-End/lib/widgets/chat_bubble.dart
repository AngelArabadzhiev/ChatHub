import "package:Chat_App/models/chat_message_entity.dart";
import "package:Chat_App/services/auth_services.dart";
import "package:Chat_App/utils/brand_colors.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity entity;
  final Alignment alignment;

  const ChatBubble({
    super.key,
    required this.alignment,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    bool isAuthor = entity.author.username == context.read<AuthServices>().getUsername();
    return Align(
      alignment: alignment,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: isAuthor ? Theme.of(context).primaryColor : Colors.black87,
            borderRadius: isAuthor
                ? const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))
                : const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entity.text,
              style: TextStyle(fontSize: 20, color: BrandColors.chatInputColor),
            ),
            if (entity.imageUrl != null)
              Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(entity.imageUrl!)),
                      borderRadius: BorderRadius.circular(12)))
          ],
        ),
      ),
    );
  }
}
