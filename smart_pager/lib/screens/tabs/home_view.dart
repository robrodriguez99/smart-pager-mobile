import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';
import 'package:smart_pager/providers/user_provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  late RestaurantController restaurantController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    restaurantController = ref.read(restaurantControllerProvider.notifier);
    _scrollController.addListener(_onScroll);
    // Initial fetch
    restaurantController.loadRestaurants(page: _page);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      _page++;
      restaurantController
          .loadRestaurants(page: _page, isScroll: true)
          .then((_) {
        setState(() {
          _isLoadingMore = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(loggedUserProvider);

    return SingleChildScrollView(
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
              text: 'Restaurantes Destacados',
              color: SPColors.heading,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
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
                    final restaurants = restaurantsListState.value;
                    if (restaurants == null || restaurants.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 16.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: restaurantsListState.value!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < restaurantsListState.value!.length) {
                              return RestaurantCard(
                                restaurant: restaurantsListState.value![index],
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
