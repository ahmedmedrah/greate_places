import 'package:flutter/material.dart';
import 'package:greate_places/providers/places_provider.dart';
import 'package:greate_places/screens/add_place_screen.dart';
import 'package:greate_places/screens/place_details_screen.dart';
import 'package:greate_places/widgets/place_list_item.dart';
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
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
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
                                return Column(
                                  children: [
                                    PlaceListItem(data.items[i]),
                                    Divider(thickness: 2,),
                                  ],
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
