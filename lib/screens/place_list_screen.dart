import 'package:flutter/material.dart';
import 'package:travelin/data/bali.dart';
import 'package:travelin/data/bandung.dart';
import 'package:travelin/data/jakarta.dart';
import 'package:travelin/models/tourism_place.dart';
import 'package:travelin/screens/place_detail_screen.dart';

class PlacelistScreen extends StatelessWidget {
  const PlacelistScreen({super.key, this.city = "Bandung"});
  final String city;
  @override
  Widget build(BuildContext context) {
    Map cityData = {
      "Bandung": tourismBandungPlaceList,
      "Jakarta": tourismJakartePlacelist,
      "Bali": tourismBaliPlaceList
    };
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/favicon.png',
                width: 30,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "TravelIn ke $city",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Staatliches'),
              )
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth <= 600) {
              return TouristPlaceList(
                cityData: cityData[city],
                city: city,
              );
            } else if (constraints.maxWidth <= 1200) {
              return TouristPlaceGrid(
                cityData: cityData[city],
                gridCount: 3,
                city: city,
              );
            } else {
              return TouristPlaceGrid(
                gridCount: 5,
                cityData: cityData[city],
                city: city,
              );
            }
          },
        ));
  }
}

class TouristPlaceList extends StatefulWidget {
  const TouristPlaceList(
      {super.key, required this.cityData, required this.city});
  final List cityData;
  final String city;
  @override
  State<TouristPlaceList> createState() => _TouristPlaceListState();
}

class _TouristPlaceListState extends State<TouristPlaceList> {
  void favoriteClick(TourismPlace e) {
    setState(() {
      e.isFavorite = !e.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = widget.cityData[index];
        return InkWell(
          onTap: () async {
            final reload = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
              return DetailScreen(
                place: place,
                city: widget.city,
              );
            }));
            if (reload) {
              setState(() {});
            }
          },
          child: Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Image(image: Image.asset(place.imageAsset).image)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                place.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Oxygen"),
                              ),
                            ),
                            IconButton(
                                onPressed: () => favoriteClick(place),
                                icon: place.isFavorite
                                    ? const Icon(Icons.favorite,
                                        color: Colors.red)
                                    : const Icon(Icons.favorite_border))
                          ],
                        ),
                        Text(
                          place.location,
                          style: const TextStyle(fontFamily: "Oxygen"),
                        ),
                      ]),
                ))
              ],
            ),
          ),
        );
      },
      itemCount: widget.cityData.length,
    );
  }
}

class TouristPlaceGrid extends StatefulWidget {
  const TouristPlaceGrid(
      {super.key,
      this.gridCount = 2,
      required this.cityData,
      required this.city});
  final int gridCount;
  final List cityData;
  final String city;

  @override
  State<TouristPlaceGrid> createState() => _TouristPlaceGridState();
}

class _TouristPlaceGridState extends State<TouristPlaceGrid> {
  void favoriteClick(TourismPlace e) {
    setState(() {
      e.isFavorite = !e.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentColorScheme = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.count(
          crossAxisCount: widget.gridCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          children: widget.cityData.map((e) {
            return InkWell(
              onTap: () async {
                final reload = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return DetailScreen(
                    place: e,
                    city: widget.city,
                  );
                }));
                if (reload) {
                  setState(() {});
                }
              },
              child: GridTile(
                header: GridTileBar(
                  backgroundColor: currentColorScheme.secondaryContainer,
                  title: Center(
                    child: Text(
                      e.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Staatliches"),
                    ),
                  ),
                ),
                footer: GridTileBar(
                  backgroundColor: currentColorScheme.secondaryContainer,
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                favoriteClick(e);
                              },
                              icon: e.isFavorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.favorite_border)),
                          Text(
                            e.location,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Oxygen"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: Card(
                  child: Column(children: [
                    Expanded(
                        child: Image.asset(e.imageAsset, fit: BoxFit.cover)),
                  ]),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
