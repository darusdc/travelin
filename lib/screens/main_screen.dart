import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:travelin/data/bali.dart';
import 'package:travelin/data/bandung.dart';
import 'package:travelin/data/banner.dart';
import 'package:travelin/data/jakarta.dart';
import 'package:travelin/models/tourism_place.dart';
import 'package:travelin/screens/place_list_screen.dart';

class Mainscreen extends StatelessWidget {
  const Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme currentColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: currentColorScheme.background,
        appBar: AppBar(
          backgroundColor: currentColorScheme.primaryContainer,
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
              const Text(
                "TravelIn",
                style: TextStyle(
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
              return const GridViewMenu();
            } else if (constraints.maxWidth <= 1200) {
              return const GridViewMenu(gridCount: 3);
            } else {
              return const GridViewMenu(gridCount: 6);
            }
          },
        ));
  }
}

class GridViewMenu extends StatefulWidget {
  const GridViewMenu({super.key, this.gridCount = 2});
  final int gridCount;
  @override
  State<GridViewMenu> createState() => _GridViewMenu();
}

class _GridViewMenu extends State<GridViewMenu> {
  Map<String, List<TourismPlace>> locationAvaiable = {
    'Jakarta': tourismJakartePlacelist,
    'Bandung': tourismBandungPlaceList,
    'Bali': tourismBaliPlaceList
  };

  Map<String, String> itemName = {
    "Jakarta": tourismJakartePlacelist[0].name,
    "Bandung": tourismBandungPlaceList[0].name,
    "Bali": tourismBaliPlaceList[0].name
  };

  void itemNameChange(String value, String locationName) {
    setState(() {
      itemName[locationName] = value;
    });
  }

  void navigateTo(String value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlacelistScreen(
                  city: value,
                )));
  }

  @override
  Widget build(BuildContext context) {
    var currentColorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Swiper(
                itemBuilder: (context, index) {
                  final url = bannerData[index];
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                  );
                },
                itemCount: bannerData.length,
                pagination:
                    const SwiperPagination(alignment: Alignment.bottomCenter),
                control: const SwiperControl(color: Colors.white70),
              )),
          const SizedBox(height: 20),
          const Text(
            "Mau jalan kemana hari ini?",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Oxygen",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                crossAxisCount: widget.gridCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                children: ["Jakarta", "Bandung", "Bali"].map(
                  (locationName) {
                    var dataUsed = locationAvaiable[locationName];
                    return GridTile(
                      header: GridTileBar(
                        backgroundColor: currentColorScheme.secondaryContainer,
                        title: Center(
                          child: Text(
                            locationName,
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
                          child: Text(
                            itemName[locationName]!,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Oxygen"),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          navigateTo(locationName);
                        },
                        child: Card(
                          color: currentColorScheme.secondaryContainer,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Swiper(
                                    containerWidth: 151,
                                    onTap: (index) {
                                      navigateTo(locationName);
                                    },
                                    itemBuilder: (context, index) {
                                      final url = dataUsed[index];
                                      return Image.asset(
                                        url.imageAsset,
                                        fit: BoxFit.fill,
                                      );
                                    },
                                    onIndexChanged: (value) {
                                      itemNameChange(
                                          dataUsed[value].name, locationName);
                                    },
                                    itemCount: dataUsed!.length,
                                    pagination: const SwiperPagination(
                                        alignment: Alignment.bottomCenter),
                                    control: const SwiperControl(
                                        color: Colors.white70),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList()),
          ),
        ],
      ),
    );
  }
}
