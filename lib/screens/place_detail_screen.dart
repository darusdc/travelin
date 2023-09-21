import 'package:flutter/material.dart';
import 'package:travelin/models/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.place, required this.city});

  final TourismPlace place;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(
              Icons.arrow_back,
            )),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/favicon.png',
                width: 30,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Text(
                "Ada apa di ${place.name}?".length > 25
                    ? place.name
                    : "Ada apa di ${place.name}?",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Staatliches'),
              ),
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return DetailMobileWeb(place: place);
          } else {
            return DetailMobilePage(place: place);
          }
        },
      ),
    );
  }
}

class DetailMobilePage extends StatefulWidget {
  const DetailMobilePage({super.key, required this.place});
  final TourismPlace place;

  @override
  State<DetailMobilePage> createState() => _DetailMobilePageState();
}

class _DetailMobilePageState extends State<DetailMobilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var scrollController = ScrollController();
    const informationTextStyle = TextStyle(fontFamily: 'Oxygen');
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: Image.asset(widget.place.imageAsset).image),
          Column(children: [
            const SizedBox(height: 10),
            Text(
              widget.place.name,
              style: const TextStyle(
                  fontFamily: "Staatliches",
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ]),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: screenWidth < 325
                ? const Center(
                    child: Text(
                    "To Tight!",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Column(children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(height: 8),
                          Text(
                            widget.place.openDays,
                            style: informationTextStyle,
                          ),
                        ]),
                        Column(children: [
                          const Icon(Icons.access_time),
                          const SizedBox(height: 8),
                          Text(
                            widget.place.openTime,
                            style: informationTextStyle,
                          ),
                        ]),
                        Column(children: [
                          const Icon(Icons.monetization_on_outlined),
                          const SizedBox(height: 8),
                          Text(
                            widget.place.ticketPrice,
                            style: informationTextStyle,
                          ),
                        ]),
                      ]),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.place.description,
                textAlign: TextAlign.justify, style: informationTextStyle),
          ),
          SizedBox(
            height: 150,
            child: Scrollbar(
              interactive: true,
              controller: scrollController,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final imageList = widget.place.imageUrls[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                      imageList,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: Text("Loading"));
                      },
                    ),
                  );
                },
                itemCount: widget.place.imageUrls.length,
                scrollDirection: Axis.horizontal,
                controller: scrollController,
              ),
            ),
          ),
          FloatingActionButton(
              splashColor: Colors.amber,
              onPressed: () {
                setState(() {
                  widget.place.isFavorite = !widget.place.isFavorite;
                });
              },
              child: widget.place.isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border))
        ],
      )),
    );
  }
}

class DetailMobileWeb extends StatefulWidget {
  const DetailMobileWeb({super.key, required this.place});
  final TourismPlace place;

  @override
  State<DetailMobileWeb> createState() => _DetailMobileWebState();
}

class _DetailMobileWebState extends State<DetailMobileWeb> {
  final _scrollController = ScrollController();

  void favoriteClick(TourismPlace e) {
    setState(() {
      e.isFavorite = !e.isFavorite;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const informationTextStyle = TextStyle(fontFamily: 'Oxygen');
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(widget.place.imageAsset)),
                        const SizedBox(height: 16),
                        Scrollbar(
                          controller: _scrollController,
                          child: Container(
                            height: 150,
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              children: widget.place.imageUrls.map((url) {
                                return Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(url),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    )),
                    const SizedBox(width: 32),
                    Expanded(
                        child: Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.place.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Staatlisches',
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(width: 8),
                                    Text(widget.place.openDays,
                                        style: informationTextStyle),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      favoriteClick(widget.place);
                                    },
                                    icon: widget.place.isFavorite
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(Icons.favorite_border))
                              ],
                            ),
                            Row(children: [
                              const Icon(Icons.timer_sharp),
                              const SizedBox(width: 8),
                              Text(widget.place.openTime,
                                  style: informationTextStyle),
                            ]),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.monetization_on),
                                const SizedBox(width: 8),
                                Text(widget.place.ticketPrice),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(widget.place.description,
                                textAlign: TextAlign.justify,
                                style:
                                    informationTextStyle.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
