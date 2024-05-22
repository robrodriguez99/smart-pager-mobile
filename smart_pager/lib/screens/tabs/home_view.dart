import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';
import 'package:smart_pager/providers/user_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final futureUser = ref.watch(loggedUserProvider);
  final futureRestaurantsList = ref.watch(restaurantControllerProvider);
    return futureRestaurantsList.when (
      data: (restaurantsList) {
        return SingleChildScrollView(
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
                const SizedBox(height: 10),
                restaurantsList.isEmpty
                    ? const Center(child: Text('No restaurants found'))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: restaurantsList.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                            restaurantName: restaurantsList[index].name,
                            category: restaurantsList[index].type ?? 'No category',
                            estimatedWaitTime: restaurantsList[index].avgTimePerTable ?? 'No time',
                            isPromoted: restaurantsList[index].isPromoted,
                            isClosed: false,//TODO
                          );
                        },
                      ),
                      //insert debug button that on pressed calls getHello
                ElevatedButton(
                  onPressed: () {
                    ref.read(restaurantControllerProvider.notifier).getRestaurants();
                  },
                  child: const Text('Debug Button'),
                ),
              ],
            ),
          ),
        );
      }, 
      //if error i want to print the error
      error: (Object error, StackTrace stackTrace) {
        print("error");
        print(error);
        print(stackTrace);
        return const Center(child: Text('Error loading restaurants'));
      },
      loading: () => const Center(child: CircularProgressIndicator())
    );
  }
  
}
