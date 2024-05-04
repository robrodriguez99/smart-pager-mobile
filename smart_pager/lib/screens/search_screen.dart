import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'All';
  String _selectedDistance = 'Any';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: SPColors.activeBlack,
            size: 30,
          ),
        ),
        title: const CustomText(
          text: 'Restaurantes',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Restaurante',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              items: <String>['All', 'Category 1', 'Category 2', 'Category 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Categoría',
                prefixIcon: Icon(Icons.restaurant),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDistance,
              onChanged: (newValue) {
                setState(() {
                  _selectedDistance = newValue!;
                });
              },
              items: <String>['Any', '1 km', '2 km', '3 km', '5 km']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Distancia',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              icon: Icons.search,
              text: 'Buscar',
              gradientColors: const [SPColors.primary, SPColors.primary],
              onPressed: () {
                GoRouter.of(context).push('/search/results');
              },
            ),
          ],
        ),
      ),
    );
  }
}
