import 'package:flutter/material.dart';
import 'package:greate_places/providers/places_provider.dart';
import 'package:greate_places/screens/add_place_screen.dart';
import 'package:greate_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PlacesProvider>(
                builder: (ctx, data, child) {
                  return data.items.length == 0
                      ? child
                      : ListView.builder(
                          itemCount: data.items.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              leading: Container(
                                width: 70,
                                height: 50,
                                child: Image.file(data.items[i].image,fit: BoxFit.cover,),
                              ),
                              title: Text(data.items[i].title),
                              subtitle: Text(data.items[i].location.address),
                              onTap: () {
                                //go to place details page
                                Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName,arguments: data.items[i].id);
                              },
                            );
                          },
                        );
                },
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Got no place yet, add some?',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(AddPlaceScreen.routeName),
                        color: Theme.of(context).primaryColor,
                        iconSize: 40,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
