import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> vehicles = [
    {
      "name": "MT 15",
      "image": "assets/15.JPG",
      "details": "998cc superbike, top speed 300 km/h.",
    },
    {
      "name": "FZ 16",
      "image": "assets/16.jpg",
      "details": "689cc street bike, lightweight and powerful.",
    },
    {
      "name": "Fazer",
      "image": "assets/Fazer.jpg",
      "details": "155cc scooter, fuel-efficient and stylish.",
    },
    {
      "name": "FZS V 3.0",
      "image": "assets/FZSV3.jpg",
      "details": "321cc sportbike, good for beginners and daily riding.",
    },
    {
      "name": "Yamaha R3",
      "image": "assets/r3.jpg",
      "details": "149cc street bike, perfect for city riding.",
    },
    {
      "name": "Yamaha YZF R15 V 3.0",
      "image": "assets/r15v3.jpg",
      "details": "847cc retro bike, combines classic and modern tech.",
    },
    {
      "name": "Yamaha Saluto",
      "image": "assets/saluto.jpg",
      "details": "562cc maxi-scooter, comfortable for long rides.",
    },
    {
      "name": "NMAX 125",
      "image": "assets/Scooter.jpg",
      "details": "942cc cruiser bike, powerful and comfortable.",
    },
  ];

  List<Map<String, String>> filteredVehicles = [];

  @override
  void initState() {
    super.initState();
    filteredVehicles = vehicles; // Initially show all vehicles
  }

  List<Map<String, String>> _filterVehicles(String query) {
    return vehicles
        .where(
          (vehicle) =>
              vehicle['name']!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yamaha Vehicles"),
        backgroundColor: const Color.fromARGB(255, 154, 153, 153),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(onSearch: _filterVehicles),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 55, 54, 54),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: filteredVehicles.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.asset(
                        filteredVehicles[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      filteredVehicles[index]['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => DetailsScreen(
                                vehicle: filteredVehicles[index],
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 55, 54, 54),
                    ),
                    child: Text(
                      "Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> Function(String) onSearch;

  CustomSearchDelegate({required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context); // Reset search when cleared
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredVehicles = onSearch(
      query,
    ); // Perform search when results are requested
    return _buildResultsList(context, filteredVehicles);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredVehicles = onSearch(query); // Perform search while typing
    return _buildResultsList(context, filteredVehicles);
  }

  Widget _buildResultsList(
    BuildContext context,
    List<Map<String, String>> filteredVehicles,
  ) {
    if (filteredVehicles.isEmpty) {
      return Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: filteredVehicles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredVehicles[index]['name']!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        DetailsScreen(vehicle: filteredVehicles[index]),
              ),
            );
          },
        );
      },
    );
  }
}
