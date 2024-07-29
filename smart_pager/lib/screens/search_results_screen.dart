import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final String category;
  final String searchText;
  final String distance;
  final String latitude;
  final String longitude;

  const SearchResultsScreen({
    super.key,
    required this.category,
    required this.searchText,
    required this.distance,
    required this.latitude,
    required this.longitude,
  });

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  late ScrollController _scrollController;
  late RestaurantController _restaurantController;
  int _page = 0;
  bool _isLoadingMore = false;
  String _category = '';
  String _searchText = '';
  String _distance = '';
  String _latitude = '';
  String _longitude = '';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _restaurantController = ref.read(restaurantControllerProvider.notifier);
    _scrollController.addListener(_onScroll);
    _fetchRestaurants();
  }

  void _fetchRestaurants() {
    _category = widget.category;
    _searchText = widget.searchText;
    _distance = widget.distance;
    _latitude = widget.latitude;
    _longitude = widget.longitude;
    _restaurantController.loadRestaurants(
      page: _page,
      category: _category,
      searchText: _searchText,
      distance: _distance,
      latitude: _latitude,
      longitude: _longitude,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      _page++;
      _restaurantController
          .loadRestaurants(
        page: _page,
        category: _category,
        searchText: _searchText,
        isScroll: true,
        distance: _distance,
        latitude: _latitude,
        longitude: _longitude,
      )
          .then((_) {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            GoRouter.of(context).go('/search');
          },
        ),
        title: const CustomText(
          text: 'Resultados',
          color: SPColors.heading,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: SPColors.lightGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Buscar restaurantes',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onTap: () {
                    GoRouter.of(context).push('/search');
                  },
                ),
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Restaurantes',
                color: SPColors.heading,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final restaurantsListState =
                      ref.watch(restaurantControllerProvider);

                  return restaurantsListState.when(
                    data: (restaurantsList) {
                      if (restaurantsList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'No encontramos resultados para su búsqueda.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .grey[600], // Adjust color as needed
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Podés probar con una nueva o descubrir nuestras mejores opciones.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors
                                      .grey[500], // Adjust color as needed
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          ListView.builder(
                            padding: const EdgeInsets.only(top: 16.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurantsList.length,
                            itemBuilder: (context, index) {
                              return RestaurantCard(
                                restaurant: restaurantsList[index],
                              );
                            },
                          ),
                          if (_isLoadingMore)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      print("Error: $error");
                      print(stackTrace);
                      return const Center(
                          child: Text('Error loading restaurants'));
                    },
                    loading: () {
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
