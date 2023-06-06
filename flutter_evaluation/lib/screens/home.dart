import 'package:flutter/material.dart';
import 'package:flutter_evaluation/screens/articles.dart';
import 'package:flutter_evaluation/screens/home_cell.dart';
import 'package:flutter_evaluation/screens/home_header.dart';
import 'package:flutter_evaluation/screens/search.dart';
import 'package:geolocator/geolocator.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New York Times"),
      ),
      body: ListView(
        children: [
          HomeHeader(title: "Search"),
          GestureDetector(
            child: HomeCell(title: "Search Articles"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
          ),
          HomeHeader(title: "Popular"),
          GestureDetector(
            child: HomeCell(title: "Most Viewed"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Articles(
                          type: "Viewed",
                        )),
              );
            },
          ),
          GestureDetector(
            child: HomeCell(title: "Most Shared"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Articles(
                          type: "Shared",
                        )),
              );
            },
          ),
          GestureDetector(
            child: HomeCell(title: "Most Emailed"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Articles(
                          type: "Emailed",
                        )),
              );
            },
          ),
          _currentPosition != null
              ? HomeCell(title: "Latitude: ${_currentPosition!.latitude}")
              : Container(),
          _currentPosition != null
              ? HomeCell(title: "Longitude: ${_currentPosition!.longitude}")
              : Container(),
        ],
      ),
    );
  }
}
