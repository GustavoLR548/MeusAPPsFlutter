import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final String username;
  final String imageUrl;
  final bool _isMe;
  final Key key;

  MessageBubble(this.username, this._message, this.imageUrl, this._isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    final thisUserBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(0));

    final otherUserBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(12));

    final otherUserProfileIcon = Positioned(
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      top: -10,
      left: 120,
    );

    final thisUserProfileIcon = Positioned(
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      top: -10,
      right: 120,
    );

    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: _isMe
                        ? Colors.grey[500]
                        : Theme.of(context).accentColor,
                    borderRadius:
                        _isMe ? thisUserBorderRadius : otherUserBorderRadius),
                width: 140,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                    crossAxisAlignment: _isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !_isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color,
                          ),
                          textAlign: _isMe ? TextAlign.end : TextAlign.start),
                      Text(
                        _message,
                        style: TextStyle(
                            color: !_isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color),
                      ),
                    ])),
          ],
        ),
        if (_isMe) thisUserProfileIcon else otherUserProfileIcon
      ],
      clipBehavior: Clip.antiAlias,
    );
  }
}
