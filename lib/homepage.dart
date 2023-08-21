import 'package:flutter/material.dart';
import 'apicalling.dart';
import 'modelclass/usermodalclass.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter - API Implementation"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
    );
  }

  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<User>>(
      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<User>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List<User> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          child: Card(
            color: Colors.grey[100],
            elevation: 3,
            child: ListTile(
              leading: Icon(
                Icons.numbers,
                color: Colors.deepOrange.shade700,
              ),
              title: Text(
                posts[index].title.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(posts[index].completed.toString()),
            ),
          ),
        );
      },
    );
  }
}
