import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisata_lamongan/api/listwisata.dart';
import 'package:wisata_lamongan/api/repositorywisata.dart';

class DetailUmkm extends StatefulWidget {
  final Destinasi destinasi;
  RepositoryReligi repository = RepositoryReligi();

  DetailUmkm({Key? key, required this.destinasi}) : super(key: key);

  @override
  _DetailUmkmState createState() => _DetailUmkmState();
}

class _DetailUmkmState extends State<DetailUmkm> {
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
        Navigator.pushReplacementNamed(context, '/umkm');
        break;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
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
            label: 'UMKM',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 1, 92, 218),
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
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
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Kab. Lamongan",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.destinasi.deskripsi,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Kontak",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                widget.destinasi.kontak,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: const Text(
                "Detail Maps Lokasi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                onTap: () async {
                  print("jai");
                  await _launchUrl(widget.destinasi.maps);
                },
                child: Text(
                  widget.destinasi.maps,
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
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
