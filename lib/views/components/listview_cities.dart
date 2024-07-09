import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/utils/cities_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListviewCities extends StatefulWidget {
  final UserApp userApp;
  final void Function(String?) onCitySelected;

  const ListviewCities({
    super.key,
    required this.userApp,
    required this.onCitySelected,
  });

  @override
  State<ListviewCities> createState() => _ListviewCitiesState();
}

class _ListviewCitiesState extends State<ListviewCities> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: citiesGoias.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(citiesGoias[index]),
          value: _selectedCity == citiesGoias[index],
          activeColor: _selectedCity == citiesGoias[index]
            ? Color.fromARGB(255, 83, 172, 60)
            : null,
          onChanged: (value) {
            setState(() {
              if (value ?? false) {
                _selectedCity = citiesGoias[index];
                widget.onCitySelected(_selectedCity);
              } else {
                _selectedCity = null;
                widget.onCitySelected(null);
              }
            });
          },
        );
      },
    );
  }
}
