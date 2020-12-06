import 'package:flutter/material.dart';
import 'package:greate_places/providers/places_provider.dart';
import 'package:greate_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlaceListItem extends StatelessWidget {
  final placeItem;
  const PlaceListItem(this.placeItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(placeItem.id),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to delete ${placeItem.title}?'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: Text('Yes'),
                    textColor: Theme.of(context).errorColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No')),
                ],
              );
            });
      },
      onDismissed: (direction) =>
          Provider.of<PlacesProvider>(context, listen: false).deletePlace(placeItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 90,
          height: 100,
          child: Image.file(placeItem.image,fit: BoxFit.cover,),
        ),
        title: Text(placeItem.title),
        subtitle: Text(placeItem.location.address),
        onTap: () {
          //go to place details page
          Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName,arguments:placeItem.id);
        },
      ),
    );
  }
}
