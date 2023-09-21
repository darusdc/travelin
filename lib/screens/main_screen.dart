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
              const Expanded(
                child: Center(
                  child: Text(
                    "TravelIn",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Staatliches'),
                  ),
                ),
              )
            ],
          ),
        ),
        body: const GridViewMenu());
  }
}

class GridViewMenu extends StatefulWidget {
  const GridViewMenu({super.key});
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
    double screenWidth = MediaQuery.of(context).size.width;
    int gridCount = 1;
    bool isShowPaginationAndControl = false;
    var currentColorScheme = Theme.of(context).colorScheme;
    screenWidth < 400
        ? isShowPaginationAndControl = false
        : isShowPaginationAndControl = true;
    gridCount = (screenWidth / 230).round();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
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
                pagination: isShowPaginationAndControl
                    ? const SwiperPagination(alignment: Alignment.bottomCenter)
                    : null,
                control: isShowPaginationAndControl
                    ? const SwiperControl(color: Colors.white70)
                    : null,
              )),
          // const SizedBox(height: 20),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Mau jalan kemana hari ini?",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Oxygen",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
          Flexible(
            child: GridView.count(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                crossAxisCount: gridCount,
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
                              Flexible(
                                  flex: 1,
                                  child: Swiper(
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
                                    pagination: isShowPaginationAndControl
                                        ? const SwiperPagination(
                                            alignment: Alignment.bottomCenter)
                                        : null,
                                    control: isShowPaginationAndControl
                                        ? const SwiperControl(
                                            color: Colors.white70)
                                        : null,
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
