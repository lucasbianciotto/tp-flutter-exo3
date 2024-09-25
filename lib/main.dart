import 'package:exo3/pages/Breed.dart';
import 'package:exo3/pages/Favorite.dart';
import 'package:exo3/repositories/FavoritesRepository.dart';
import 'package:exo3/services/catapi.dart';
import 'package:exo3/widgets/FavoriteBar.dart';
import 'package:exo3/widgets/FavoriteButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/breed.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => FavoritesRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Instagram'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Breed>> breed;

  @override
  void initState() {
    super.initState();
    breed = CatApi.getBreeds();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: breed,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final breed = snapshot.data?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BreedPage(breed: breed),
                            ),
                          );
                        },
                        child: Card(
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: CatApi().getImage(breed!.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Image.network(snapshot.data!.url);
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(breed!.name),
                                    FavoriteButton(breed: breed)
                                  ],
                                )
                              ],
                            )
                        )
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoritePage(),
            ),
          );
        },
        child: const FavoriteBar()
      ),
    );
  }
}
