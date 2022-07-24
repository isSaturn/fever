import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fever/data/model/chat_with_user.dart';
import 'package:fever/util/constants.dart';
import 'package:fever/util/utils.dart';

class ChatListTile extends StatefulWidget {
  final ChatWithUser chatWithUser;
  final Function onTap;
  final Function onLongPress;
  final String myUserId;

  ChatListTile(
      {@required this.chatWithUser,
      @required this.onTap,
      @required this.onLongPress,
      @required this.myUserId});

  @override
  State<ChatListTile> createState() => _ChatListTileState();
}

class _ChatListTileState extends State<ChatListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: () {},
      child: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              width: 60,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage(widget.chatWithUser.user.profilePhotoPath),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kAccentColor, width: 1.0),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [getTopRow(), getBottomRow()],
              ),
            )),
          ],
        ),
      ),
    );
  }

  bool isLastMessageMyText() {
    return widget.chatWithUser.chat.lastMessage.senderId == widget.myUserId;
  }

  bool isLastMessageSeen() {
    if (widget.chatWithUser.chat.lastMessage.seen == false &&
        isLastMessageMyText() == false) {
      return false;
    }
    return true;
  }

  Widget getTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.chatWithUser.user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
            child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.chatWithUser.user.isOnline
                    ? Colors.green.shade500
                    : Colors.grey.shade800,
              ),
            ),
            SizedBox(width: 10),
            Text(
                widget.chatWithUser.chat.lastMessage == null
                    ? ''
                    : convertEpochMsToDateTime(
                        widget.chatWithUser.chat.lastMessage.epochTimeMs),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12)),
          ],
        )),
      ],
    );
  }

  Widget getBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Opacity(
            opacity: 0.6,
            child: Text(
              widget.chatWithUser.chat.lastMessage == null
                  ? "Write something!"
                  : ((isLastMessageMyText() ? "You: " : "") +
                      widget.chatWithUser.chat.lastMessage.text),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        SizedBox(
            width: 40,
            child: widget.chatWithUser.chat.lastMessage == null ||
                    isLastMessageSeen() == false
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: kAccentColor, shape: BoxShape.circle),
                  )
                : null)
      ],
    );
  }
}
