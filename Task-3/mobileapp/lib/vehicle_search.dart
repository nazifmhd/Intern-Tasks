import 'package:flutter/material.dart';

class VehicleSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> vehicles;
  final Function(String) updateSearchResults;

  VehicleSearchDelegate(this.vehicles, this.updateSearchResults);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          updateSearchResults(query);
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
    updateSearchResults(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    updateSearchResults(query);
    return Container();
  }
}
