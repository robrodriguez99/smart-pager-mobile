// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _selectedCategory = 'Todas';
  String _selectedDistance = 'Todas';
  Position? _currentPosition;
  final TextEditingController _searchController = TextEditingController();

  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Los servicios de ubicación estan desactivados. Por favor activelos.')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Los permisos de ubicación estan denegados.')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Los permisos de ubicación estan permanentemente denegados, no podemos pedir los permisos.')));
      return false;
    }

    return true;
  }

  Future<Position?> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return null;

    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() => _currentPosition = position);
      return position;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref
        .watch(restaurantControllerProvider.notifier)
        .getRestaurantCategories();

    return PopScope(
      onPopInvoked: (value) {
        GoRouter.of(context).go('/home');
      },
      canPop: false,
      child: FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar los datos de categorias'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron categorias'));
          }
      
          final categoriesData = snapshot.data!;
          final categoriesList = ['Todas', ...categoriesData];
      
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => GoRouter.of(context).go('/home'),
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
                    items: categoriesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.restaurant),
                                const SizedBox(width: 10),
                                Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              color: SPColors.lightGray,
                              thickness: 1,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      prefixIcon: Icon(Icons.restaurant),
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return categoriesList.map<Widget>((String item) {
                        return SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(item),
                          ),
                        );
                      }).toList();
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedDistance,
                    onChanged: (newValue) async {
                      setState(() {
                        _selectedDistance = newValue!;
                      });
                    },
                    items: <String>['Todas', '1 km', '2 km', '3 km', '5 km']
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
                    onPressed: () async {
                      Position? position;
      
                      if (_selectedDistance != 'Todas') {
                        position = await _getCurrentPosition(context);
                      }
      
                      final params = {
                        'category': _selectedCategory,
                        'distance': _selectedDistance,
                        'searchText': _searchController.text,
                        'latitude': position?.latitude.toString(),
                        'longitude': position?.longitude.toString(),
                      };
      
                      final uri = Uri(
                        path: '/search/results',
                        queryParameters: params,
                      );
      
                      GoRouter.of(context).push(uri.toString());
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
