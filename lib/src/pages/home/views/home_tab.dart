import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/configs/app_data.dart' as mock;
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer/src/pages/base/navigation/navigation_tabs.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_shimmer.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';
import 'package:greengrocer/src/pages/home/views/components/category_tile.dart';
import 'package:greengrocer/src/pages/home/views/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final TextEditingController searchController = TextEditingController();

  final navigationController = Get.find<NavigationController>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: AppNameWidget(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GetBuilder<CartController>(
              builder: (ctrl) => GestureDetector(
                onTap: () {
                  navigationController.navigatePageView(NavigationTabs.cart);
                },
                child: Badge(
                  badgeColor: CustomColors.customContrastColor,
                  badgeContent: Text(
                    ctrl.cartItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  position: BadgePosition.topEnd(),
                  child: AddToCartIcon(
                    key: globalKeyCartItems,
                    icon: Icon(
                      Icons.shopping_cart,
                      color: CustomColors.customSwatchColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: AddToCartAnimation(
          gkCart: globalKeyCartItems,
          previewDuration: const Duration(milliseconds: 100),
          dragToCardDuration: const Duration(milliseconds: 300),
          previewCurve: Curves.ease,
          receiveCreateAddToCardAnimationMethod: (addToCartAnimationMethod) {
            runAddToCartAnimation = addToCartAnimationMethod;
          },
          child: Column(
            children: [
              GetBuilder<HomeController>(
                builder: (ctrl) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        ctrl.searchTitle.value = value;
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquisar...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: CustomColors.customContrastColor,
                        size: 24.0,
                      ),
                      suffixIcon: ctrl.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                searchController.clear();
                                ctrl.searchTitle.value = '';
                              },
                              icon: Icon(
                                Icons.clear_rounded,
                                color: CustomColors.customContrastColor,
                                size: 20.0,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GetBuilder<HomeController>(
                builder: (ctrl) => Container(
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: !ctrl.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) => CategoryTile(
                            category: ctrl.categories[index].title,
                            isSelected:
                                ctrl.currentCategory == ctrl.categories[index],
                            onPressed: () {
                              ctrl.selectCategory(ctrl.categories[index]);
                            },
                          ),
                          separatorBuilder: (_, index) =>
                              const SizedBox(width: 14.0),
                          itemCount: ctrl.categories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: List.generate(5, (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: CustomShimmer(
                                  height: 20.0,
                                  width: 80.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            );
                          }),
                        ),
                ),
              ),
              GetBuilder<HomeController>(
                builder: (ctrl) => Expanded(
                  child: !ctrl.isProductLoading
                      ? Visibility(
                          visible:
                              (ctrl.currentCategory?.items ?? []).isNotEmpty,
                          replacement: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 48.0, horizontal: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 56.0,
                                  color: CustomColors.customSwatchColor,
                                ),
                                const Text(
                                  'Não foram encontrados produtos com o nome informado para esta categoria',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount: ctrl.products.length,
                            itemBuilder: (_, index) {
                              if ((index + 1) == ctrl.products.length) {
                                if (!ctrl.isLastPage) {
                                  ctrl.loadMoreProducts();
                                }
                              }

                              return ItemTile(
                                item: ctrl.products[index],
                                cartAnimationMethod: itemSelectedCartAnimations,
                              );
                            },
                          ),
                        )
                      : GridView.count(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            mock.items.length,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
