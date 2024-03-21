import 'package:flutter/material.dart';
import 'package:wisata_lamongan/api/listwisata.dart';
import 'package:wisata_lamongan/api/repositorywisata.dart';

class DetailView extends StatefulWidget {
  final Destinasi destinasi;
  RepositoryReligi repository = RepositoryReligi();

  DetailView({Key? key, required this.destinasi}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/explore');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/favorite');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 1, 92, 218),
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Center(
                                child: Image.network(
                                  widget.repository
                                      .getImageUrl(widget.destinasi.images),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    height: 100,
                                    color: const Color.fromARGB(105, 0, 0, 0),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              widget.destinasi.lokasi,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Kab. Lamongan",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              color: Colors.yellow,
              height: 70,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Tentang Tempat ini",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.adjust,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                              widget.destinasi.deskripsi,
                            ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ))),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Harga Tiket",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                widget.destinasi.harga,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
