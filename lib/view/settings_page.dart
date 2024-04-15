import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'setting_screens/account_settings.dart';

class SearchableList extends StatefulWidget {
  final List<String> items;

  const SearchableList({Key? key, required this.items}) : super(key: key);

  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  String _searchText = '';
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items; // Initialize with original list
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _searchText = text;
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    onChanged: _onSearchTextChanged,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchText.isEmpty
                  ? widget.items.length
                  : _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _searchText.isEmpty
                    ? widget.items[index]
                    : _filteredItems[index];
                // Display item details here
                // return ListTile(
                //   title: Text(item.name),
                //   subtitle: Text(item.description),
                // );
                return GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountSettings()));
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            Text(
                              item,
                              style: AppFonts().sego14bold,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color:
                            AppConstColors.appBoldTextColor.withOpacity(0.25),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class MyDataClass {
//   final String name;
//   final String description;

//   MyDataClass({required this.name, required this.description});
// }