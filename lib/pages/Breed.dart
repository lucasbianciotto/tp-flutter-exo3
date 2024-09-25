import 'package:exo3/services/catapi.dart';
import 'package:exo3/widgets/FavoriteButton.dart';
import 'package:flutter/material.dart';

import '../models/breed.dart';
import '../models/image.dart' as image;
import '../widgets/FavoriteBar.dart';

class BreedPage extends StatefulWidget {
  Breed breed;
  CatApi catApi = CatApi();

  BreedPage({super.key, required this.breed});

  @override
  _BreedPageState createState() => _BreedPageState();
}


class _BreedPageState extends State<BreedPage> {
  late Future<List<image.Image>> images;

  @override
  void initState() {
    super.initState();
    images = widget.catApi.getImages(widget.breed.id, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.breed.name),
            FavoriteButton(breed: widget.breed),
          ],
        )
      ),
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: FutureBuilder(
              future: images,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CarouselView(
                    itemExtent: 400,
                    shrinkExtent: 400,
                    itemSnapping: true,
                    children: snapshot.data!.map((image) {
                      return Image.network(
                        image.url,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          ListTile(
            title: Text(widget.breed.name),
            subtitle: Text(widget.breed.description),
          )
        ],
      ),
    );
  }



}