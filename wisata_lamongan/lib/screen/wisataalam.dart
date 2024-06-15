import 'package:flutter/material.dart';
import 'package:wisata_lamongan/api/listwisata.dart';
import 'package:wisata_lamongan/api/repositorywisata.dart';
import 'package:wisata_lamongan/screen/detailview.dart';

class WisataAlam extends StatefulWidget {
  const WisataAlam({Key? key}) : super(key: key);

  @override
  State<WisataAlam> createState() => _WisataAlamState();
}

class _WisataAlamState extends State<WisataAlam> {
  List<Destinasi> listAlam = [];
  RepositoryAlam repositoryalam = RepositoryAlam();

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

  getData() async {
    listAlam = await repositoryalam.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        centerTitle: true,
      ),
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
      backgroundColor: Color.fromARGB(255, 241, 245, 245),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/explore'),
                    child: const Center(child: Text("Wisata Religi")),
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 1, 92, 218), width: 2.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/alam'),
                    child: const Center(child: Text("Wisata Alam")),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listAlam.length,
              itemBuilder: (context, index) {
                final destinasi = listAlam[index];
                final imageUrl = repositoryalam.getImageUrl(destinasi.images);
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: Colors.white,
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        top: 15), // Mengatur margin kanan
                                    child: Text(
                                      destinasi.nama_destinasi,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 20,
                                        top: 2), // Mengatur margin kanan
                                    child: Text(destinasi.lokasi),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 10, top: 5),
                                          width: 25,
                                          height: 25,
                                          color: Colors.yellow,
                                          child: Center(
                                              child: Text(
                                            "4.9",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Very Good",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20, top: 30),
                                width: 100,
                                height: 40,
                                color: const Color.fromARGB(255, 14, 100, 171),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailView(
                                              destinasi: destinasi))),
                                  child: const Center(
                                      child: Text(
                                    "View Detail",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
