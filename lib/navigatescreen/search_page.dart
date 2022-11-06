import 'package:flutter/material.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: const Text(
          'Search',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40,top: 20),
                    width: MediaQuery.of(context).size.width - 60,
                    child: Card(
                      color: Colors.blueGrey,
                      margin: const EdgeInsets.only(left: 3, right: 3, bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                        maxLines: 5,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                onPressed: () {}),
                            suffixIcon:  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {}),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(5)),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
