import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitar_eik/logic/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search Artist",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SearchBloc>().add(OnQueryChanged(value));
            },
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return switch (state) {
                  SearchInitial() => const Center(
                    child: Text("Search for your favorite artist"),
                  ),
                  SearchLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  SearchError(message: String msg) => Center(child: Text(msg)),
                  SearchSuccess(artists: var data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final artist = data[index];
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(artist.name),
                        subtitle: Text(artist.name),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/artist",
                            arguments: artist.id,
                          );
                        },
                      );
                    },
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
