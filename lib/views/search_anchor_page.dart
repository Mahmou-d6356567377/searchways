import 'package:flutter/material.dart';

class SearchAnchorPage extends StatefulWidget {
  const SearchAnchorPage({super.key});

  @override
  State<SearchAnchorPage> createState() => _SearchAnchorPageState();
}

class _SearchAnchorPageState extends State<SearchAnchorPage> {
  SearchController searchController = SearchController();
  var allitems = List.generate(50, (index) => 'Item $index');
  var items = [];
  var searchHistory = [];

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
  void initState() {
    searchController.addListener(() {
      search(searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text("Search Anchor"),
        centerTitle: true,
       
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchAnchor.bar(
              searchController: searchController,
              suggestionsBuilder: (context, searchController) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        searchController.closeView(item);
                      });
                    },
                  );
                });
              }),
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
    );
  }
}
