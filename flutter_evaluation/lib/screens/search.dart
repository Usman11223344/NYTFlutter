import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_evaluation/data/model/response/search_model.dart';
import 'package:flutter_evaluation/provider/search_provider.dart';
import 'package:flutter_evaluation/screens/articles.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController _searchField;

  @override
  void initState() {
    super.initState();
    _searchField = TextEditingController();
  }

  @override
  void dispose() {
    _searchField.dispose();
    super.dispose();
  }

  Future<void> searchArticles(BuildContext context) async {
    await Provider.of<SearchProvider>(context, listen: false).searchArticles(
      context: context,
      query: _searchField.text.trim(),
      callback: searchResponse,
    );
  }

  searchResponse(List<SearchData> articles) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return Articles(articles: articles);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<SearchProvider>(context).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                TextField(
                  controller: _searchField,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search articles here...',
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_searchField.text.trim().isNotEmpty) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          searchArticles(context);
                        });
                      }
                    },
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
