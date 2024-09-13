import 'package:college_updates/screens/profile.dart';
import 'package:college_updates/services/user_api.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  Future<void> searchUsers(String value) async {
    setState(() {
      isLoading = true;
    });

    searchResults = await UserApiService().searchUser(value);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              onChanged: (value) => searchUsers(value),
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Users',
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFC683E5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC683E5), width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC683E5), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC683E5), width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : searchResults.isEmpty && searchController.text.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: Text('No results found'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: searchResults.length >= 5
                            ? 5
                            : searchResults.length,
                        itemBuilder: (context, index) {
                          final searchResult = searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              final id = searchResult['_id'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(id: id),
                                ),
                              );
                            },
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  searchResult['profilePicture'] == ''
                                      ? 'https://picsum.photos/200/300'
                                      : searchResult['profilePicture'],
                                  fit: BoxFit.cover,
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                              title: Text(
                                searchResult['username'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                searchResult['bio'] == ''
                                    ? 'College Student'
                                    : searchResult['bio'],
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
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
