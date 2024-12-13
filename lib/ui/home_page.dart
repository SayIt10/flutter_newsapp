import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shared_preferences_app/auth/auth_local_datasource.dart';
import 'package:flutter_shared_preferences_app/ui/login_page.dart';// Import halaman detail
import 'bloc/bloc_news/news_bloc.dart';
// import 'detail_page.dart';
import 'webview_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(GetNews()); 
  }

  void onSearch() {
    final query = searchController.text;
    if (query.isNotEmpty) {
      context.read<NewsBloc>().add(SearchNews(query)); 
    } else {
      context.read<NewsBloc>().add(GetNews()); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Page'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            Expanded(child: Container()), 
            ListTile(
              leading: const Icon(Icons.logout), 
              title: const Text('Logout'),
              onTap: () async {
                await AuthLocalDatasource().removeToken();
                if (!mounted) return; 
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if(value.length > 1){
                  onSearch();
                }
              },
              decoration: InputDecoration(
                label: const Text('Search'),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                suffixIcon: IconButton(
                  onPressed: onSearch,
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocListener<NewsBloc, NewsState>(
              listener: (context, state) {
                if (state is NewsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is NewsEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }

                  if (state is NewsSuccess) {
                    final listArticle = state.articles;
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                listArticle[index].urlToImage ??
                                'https://via.placeholder.com/600/121fa4',
                              ),
                            ),
                            title: Text(listArticle[index].title ?? ''),
                            onTap: () {
                              // Navigasi ke DetailNewsPage
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => DetailNewsPage(article: listArticle[index]),
                              //   ),
                              // );
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                      return WebviewPage(
                                        url: listArticle[index].url!,
                                        title: listArticle[index].title!,
                                );
                              }));
                            },
                          ),
                        );
                      },
                      itemCount: listArticle.length,
                    );
                  }

                  return const Center(child: Text('Unexpected state'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}