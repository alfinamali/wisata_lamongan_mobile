import 'package:flutter/material.dart';
import 'package:wisata_lamongan/api/listwisata.dart';
import 'package:wisata_lamongan/api/repositorywisata.dart';
// import 'package:wisata_lamongan/api/repositorywisata.dart';
import 'package:wisata_lamongan/screen/detailview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Destinasi> listDestinasi = [];
  List<Destinasi> listAlam = [];
  List<Destinasi> searchResults = [];
  RepositoryReligi repository = RepositoryReligi();
  RepositoryAlam repositoryalam = RepositoryAlam();

  TextEditingController searchController = TextEditingController();

  void searchDestinasi(String query) {
    final lowerCaseQuery = query.toLowerCase();
    final combinedList = listDestinasi + listAlam;

    setState(() {
      searchResults = combinedList.where((destinasi) {
        final lowerCaseDestinasi = destinasi.nama_destinasi.toLowerCase();
        return lowerCaseDestinasi.contains(lowerCaseQuery);
      }).toList();
    });
  }

  int _selectedIndex = 0;
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
    listDestinasi = await repository.getData();
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
        title: const Text(
          'Welcome!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 89, 89, 179),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                                    child: Image.asset(
                                      "assets/image/homegambar.jpg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 50,
                                    child: Center(
                                      child: Text(
                                        "Where do you want to go?",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      top: 250, // Sesuaikan posisi dengan keinginan Anda
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: searchDestinasi,
                                decoration: InputDecoration(
                                  hintText: 'Search here...',
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                // Action when search button is pressed
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildKategoributton("Religi & Sejarah",
                        Icons.temple_hindu_sharp, "/explore"),
                    const SizedBox(width: 30),
                    buildKategoributton(
                        "Wisata Alam", Icons.fastfood_outlined, "/alam"),
                    const SizedBox(width: 30),
                    buildKategoributton(
                        "UMKM", Icons.fastfood_outlined, "/umkm"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Paling Populer",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final destinasi = listAlam[index];
                        final imageUrl =
                            repository.getImageUrl(destinasi.images);
                        return Row(
                          children: [
                            SizedBox(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailView(
                                          destinasi:
                                              destinasi, // Pass the selected item to the DetailView
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        destinasi.nama_destinasi,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Wisata Religi",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listDestinasi.length,
                      itemBuilder: (context, index) {
                        final destinasi = listDestinasi[index];
                        final imageUrl =
                            repository.getImageUrl(destinasi.images);
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.blue,
                                  ),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailView(
                                          destinasi:
                                              destinasi, // Pass the selected item to the DetailView
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  width: 105,
                                  height: 105,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      105, // Set the width to match the container width above
                                  child: Text(
                                    destinasi.nama_destinasi,
                                    textAlign: TextAlign
                                        .center, // Optional: center the text
                                    softWrap: true,
                                    maxLines:
                                        2, // Allow the text to wrap into a second line
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow with an ellipsis
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Wisata Alam",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listAlam.length,
                      itemBuilder: (context, index) {
                        final alam = listAlam[index];
                        final imageUrl =
                            repositoryalam.getImageUrl(alam.images);
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.blue,
                                  ),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailView(
                                          destinasi:
                                              alam, // Pass the selected item to the DetailView
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  width: 105,
                                  height: 105,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      105, // Set the width to match the container width above
                                  child: Text(
                                    alam.nama_destinasi,
                                    textAlign: TextAlign
                                        .center, // Optional: center the text
                                    softWrap: true,
                                    maxLines:
                                        2, // Allow the text to wrap into a second line
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow with an ellipsis
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          if (searchResults.isNotEmpty)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color.fromARGB(241, 255, 255, 255),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final destinasi = searchResults[index];
                      final imageUrl = repository.getImageUrl(destinasi.images);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailView(
                                destinasi: destinasi,
                              ),
                            ),
                          );
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              width: 100,
                              alignment: Alignment.centerLeft,
                              child: Image.network(imageUrl, width: 100)),
                        ),
                        title: Text(destinasi.nama_destinasi),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildKategoributton(String text, IconData icon, String routeName) {
    return Column(
      children: [
        RawMaterialButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              routeName,
            );
          },
          elevation: 2.0,
          fillColor: Colors.blue,
          shape: const CircleBorder(),
          constraints: BoxConstraints.tightFor(width: 60, height: 60),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
