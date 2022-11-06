import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: const Text(
          'Chat',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Card(
                      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        maxLines: 5,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            hintText: 'Type a Message',
                            prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.emoji_emotions,
                                  color: Colors.red,
                                ),
                                onPressed: () {}),
                            suffixIcon:  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.attach_file,
                                    ),
                                    onPressed: () {}),
                                IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {}),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8,right:5,left: 2),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:const Color(0xFF128C7E),
                      child:  IconButton(
                          icon: const Icon(
                            Icons.mic,color: Colors.white,
                          ),
                          onPressed: () {}),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
