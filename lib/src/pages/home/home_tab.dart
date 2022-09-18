import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/configs/app_data.dart' as mock;
import 'package:greengrocer/src/configs/custom_colors.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_shimmer.dart';
import 'package:greengrocer/src/pages/home/components/category_tile.dart';
import 'package:greengrocer/src/pages/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  bool isLoading = false;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  void initState() {
    super.initState();

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      setState(() => isLoading = false);
    });
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
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
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
        ],
      ),
      body: SafeArea(
        child: AddToCartAnimation(
          gkCart: globalKeyCartItems,
          previewDuration: const Duration(milliseconds: 100),
          previewCurve: Curves.ease,
          receiveCreateAddToCardAnimationMethod: (addToCartAnimationMethod) {
            runAddToCartAnimation = addToCartAnimationMethod;
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
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
              Container(
                height: 40.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: !isLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => CategoryTile(
                          category: mock.categories[index],
                          isSelected:
                              mock.categories[index] == selectedCategory,
                          onPressed: () {
                            setState(() {
                              selectedCategory = mock.categories[index];
                            });
                          },
                        ),
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 14.0),
                        itemCount: mock.categories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: List.generate(mock.categories.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              Expanded(
                child: !isLoading
                    ? GridView.builder(
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
                        itemCount: mock.items.length,
                        itemBuilder: (_, index) {
                          return ItemTile(
                            item: mock.items[index],
                            cartAnimationMethod: itemSelectedCartAnimations,
                          );
                        },
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
            ],
          ),
        ),
      ),
    );
  }
}
