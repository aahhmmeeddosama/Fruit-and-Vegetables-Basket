import 'dart:ui';
import 'package:flutter/material.dart';
import '../Provider/products_provider.dart';
import '../data/data.dart';
import '../model/fruits_vegtables.dart';
import '../screens/add_product.dart';
import '../screens/fresh_fruits.dart';
import '../screens/sign_in.dart';
import '../screens/product_details.dart';
import '../screens/my_account.dart';
import '../screens/view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'cart.dart';

enum FilterValue { Favourites, All }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  bool _isLoading = false;
  bool _showFavourites = false;
  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchProducts()
        .then(
          (_) => setState(
            () => _isLoading = true,
          ),
        )
        .catchError(
          (error) => setState(
            () => _isLoading = false,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(
              onSelected: (FilterValue selectedval) {
                setState(() {
                  if (selectedval == FilterValue.Favourites) {
                    _showFavourites = true;
                  } else {
                    _showFavourites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Only Favourites'),
                      value: FilterValue.Favourites,
                    ),
                    const PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterValue.All,
                    )
                  ]),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white)),
          )
        ],
      ),
      body: _isLoading == false
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : view(
              _showFavourites) /*SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //For Daily Fresh Text
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 20),
                    child: Text('Daily Fresh',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28)),
                  ),
                  //For List Displaying
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: dailyFreshList.length,
                    itemBuilder: (context, index) {
                      return _buildDailyFresh(context, index);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0),
                  ),
                  const FreshFruits(),
                ],
              ),
              //Fresh Fruits
            ),
            */
      ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profile",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_rounded),
            label: "Search",
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: "Cart",
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
        onTap: navigationTapped,
      ),
    );
  }

  navigationTapped(int index) {
    if (_currentIndex == index) {
      return 0;
    }
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyAccount()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddProduct()),
      );
    }
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Cart()),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

/*
  Widget _buildDailyFresh(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    FruitsAndVegs fruitsAndVegs = dailyFreshList[index];
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 40, right: 24 / 2, bottom: 35),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                        key: null,
                      )),
            );
          },
          child: Container(
            width: size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(5, 5),
                  blurRadius: 12,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8 / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    fruitsAndVegs.imagename,
                    height: size.height * 0.14,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    fruitsAndVegs.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    fruitsAndVegs.description,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    fruitsAndVegs.price.toStringAsFixed(2) + ' EGP',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        right: size.width / 6,
        bottom: size.width / 24,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(3, 3),
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            children: const [
              Icon(Icons.favorite_rounded),
              Text('Save'),
            ],
          ),
        ),
      )
    ]);
    
  }
}*/
}
