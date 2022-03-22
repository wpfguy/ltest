import 'package:flutter/material.dart';
import 'package:test_project/models/enums.dart';
import 'package:test_project/models/feed_response.dart';
import 'package:test_project/providers/api_provider.dart';
import 'package:test_project/widgets/components/feed_post.dart';
import 'package:test_project/widgets/pages/loading_widget.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget(
      {Key? key, required this.userToken, required this.onNavigatePages})
      : super(key: key);

  final String userToken;
  final Function(Views) onNavigatePages;

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  late String _selectedSortOrder = "Recent";
  late int _lastPostId = 0;
  late List<Post> _currentPosts;

  Future<FeedResponse> _callFeed() async {
    return await APIProvider.getFeedPage(
        10, _selectedSortOrder.toLowerCase(), _lastPostId, widget.userToken);
  }

  List<Widget> _populateFeedResults(List<Post> posts) {
    _currentPosts = posts;

    var widgets = <Widget>[];

    for (var post in posts) {
      widgets.add(FeedPost(post: post));
    }

    return widgets;
  }

  void _nextPage() {
    setState(() {
      _lastPostId = _currentPosts.last.id!;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FeedResponse>(
      future: _callFeed(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasError) {
          return const LoadingWidget();
        } else if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Sort by: ',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _selectedSortOrder,
                            items: <String>['Recent', 'Oldest']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value,
                                      style: const TextStyle(fontSize: 20)),
                                ),
                              );
                            }).toList(),
                            onChanged: (input) => {
                              setState(
                                  () => {_selectedSortOrder = input.toString()})
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: _populateFeedResults(snapshot.data!.posts!),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 35,
                      width: 125,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _nextPage();
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
