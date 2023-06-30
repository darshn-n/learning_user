// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSendNavigation extends StatefulWidget {
  @override
  _BottomSendNavigationState createState() => _BottomSendNavigationState();
}

class _BottomSendNavigationState extends State<BottomSendNavigation>
    with SingleTickerProviderStateMixin {
  final TextEditingController _sendMessageController = TextEditingController();

  bool showEmoji = false;

  FocusNode focusNode = FocusNode();

  Icon _emojiIcon = const Icon(
    FontAwesomeIcons.faceSmile,
    color: Colors.grey,
    size: 20,
  );

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            showEmoji = false;
            _emojiIcon = const Icon(
              FontAwesomeIcons.faceSmile,
              color: Colors.grey,
              size: 20,
            );
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: TextField(
                                focusNode: focusNode,
                                cursorColor: Colors.black,
                                controller: _sendMessageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type Here",
                                  prefixIcon: IconButton(
                                    icon: _emojiIcon,
                                    onPressed: () {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        showEmoji = !showEmoji;
                                        _emojiIcon = const Icon(
                                            FontAwesomeIcons.keyboard);
                                      });
                                    },
                                  ),
                                  suffixIcon: const Icon(
                                    FontAwesomeIcons.paperclip,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 12),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.microphone,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 7),
                          // Container(
                          //   padding: const EdgeInsets.only(right: 5),
                          //   height: 40,
                          //   width: 40,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Theme.of(context).primaryColor,
                          //   ),
                          //   child: const Icon(
                          //     FontAwesomeIcons.solidPaperPlane,
                          //     color: Colors.white,
                          //     size: 20,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
    );
  }
}
