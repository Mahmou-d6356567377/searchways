import 'package:flutter/material.dart';
import 'package:searchways/views/search_anchor_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var allitems = List.generate(50, (index) => 'Item $index');
  var items = [];
  var searchHistory = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      search(searchController.text);
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allitems;
      });
    } else {
      setState(() {
        items = allitems
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // to take the primary color 
        title: Text('Search Bar'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchAnchorPage()));
              },
              icon: Icon(Icons.arrow_forward)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                controller: searchController,
                hintText: "Search",
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: items.isEmpty ? allitems.length : items.length,
              itemBuilder: (context, index) => items.isEmpty
                  ? ListTile(
                      title: Text(allitems[index]),
                    )
                  : ListTile(
                      title: Text(items[index]),
                    ),
            ))
          ],
        ),
      ),
    );
  }
}
