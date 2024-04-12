
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';


class SearchableList extends StatefulWidget {
  final List<MyDataClass> items;

  const SearchableList({Key? key, required this.items}) : super(key: key);

  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  String _searchText = '';
  List<MyDataClass> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items; // Initialize with original list
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _searchText = text;
      _filteredItems = widget.items.where((item) =>
          item.name.toLowerCase().contains(text.toLowerCase()) ||
          item.description.toLowerCase().contains(text.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        
        actions: const [Icon(Icons.more_vert_rounded,color: Colors.white,)],
        iconTheme: const IconThemeData(
    color: Colors.white, 
  ),
        backgroundColor: Colors.black,
        title: const Text("Settings",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          
          Container(
            decoration: const BoxDecoration(color: Colors.black,),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
              
              child: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(25)),
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
              
              itemCount: _searchText.isEmpty ? widget.items.length : _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _searchText.isEmpty ? widget.items[index] : _filteredItems[index];
                // Display item details here
                // return ListTile(
                //   title: Text(item.name),
                //   subtitle: Text(item.description),
                // );
                return Container(
                  decoration: const BoxDecoration(
                                      color: Colors.black,

              //       gradient: LinearGradient(
                      
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Color.fromARGB(255, 42, 39, 39),
              //     Colors.black,
              //   ],
              // ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    
                    children: [
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.person,color: Colors.white,size: 20,),
                    ),
                    Text(item.name,style: AppFonts().sego14bold,)
                  ],),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyDataClass {
  final String name;
  final String description;

  MyDataClass({required this.name, required this.description});
}