import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  final String category;
  final String searchText;

  const SearchResultsScreen({
    Key? key,
    required this.category,
    required this.searchText,
  }) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  late ScrollController _scrollController;
  late RestaurantController _restaurantController;
  int _page = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _restaurantController = ref.read(restaurantControllerProvider.notifier);
    _scrollController.addListener(_onScroll);
    // Initial fetch
    _fetchRestaurants();
  }

  void _fetchRestaurants() {
    _restaurantController.getRestaurants(
      category: widget.category,
      search: widget.searchText,
      page: _page,
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
          .getRestaurants(
        category: widget.category,
        search: widget.searchText,
        page: _page,
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
            GoRouter.of(context).pop();
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
                        return const Center(
                            child: Text('No se encontraron restaurantes'));
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            restaurantsList.length + (_isLoadingMore ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index < restaurantsList.length) {
                            return RestaurantCard(
                              restaurant: restaurantsList[index],
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      print("Error: $error");
                      print(stackTrace);
                      return const Center(
                          child: Text('Error loading restaurants'));
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
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
