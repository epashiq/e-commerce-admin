// import 'package:e_commerce_admin/features/categories/presentation/view/category_page.dart';
// import 'package:easy_sidemenu/easy_sidemenu.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({
//     super.key,
//   });

//   @override
//   HomePagePageState createState() => HomePagePageState();
// }

// class HomePagePageState extends State<HomePage> {
//   PageController pageController = PageController();
//   SideMenuController sideMenu = SideMenuController();

//   @override
//   void initState() {
//     sideMenu.addListener((index) {
//       pageController.jumpToPage(index);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(''),
//         centerTitle: true,
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SideMenu(
//             controller: sideMenu,
//             style: SideMenuStyle(
//               displayMode: SideMenuDisplayMode.auto,
//               showHamburger: true,
//               hoverColor: Colors.blue[100],
//               selectedHoverColor: Colors.blue[100],
//               selectedColor: Colors.lightBlue,
//               selectedTitleTextStyle: const TextStyle(color: Colors.white),
//               selectedIconColor: Colors.white,
//             ),
//             title: Column(
//               children: [
//                 ConstrainedBox(
//                   constraints: const BoxConstraints(
//                     maxHeight: 150,
//                     maxWidth: 150,
//                   ),
//                 ),
//                 const Divider(
//                   indent: 8.0,
//                   endIndent: 8.0,
//                 ),
//               ],
//             ),
//             footer: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.lightBlue[50],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//                 ),
//               ),
//             ),
//             items: [
//               SideMenuItem(
//                 title: 'Dashboard',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.home),
//                 badgeContent: const Text(
//                   '3',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 tooltipContent: "This is a tooltip for Dashboard item",
//               ),
//               SideMenuItem(
//                 title: 'Users',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                 },
//                 icon: const Icon(Icons.supervisor_account),
//               ),
//               // SideMenuItem(
//               //   title: 'Products',
//               //   onTap: (index, _) {
//               //     sideMenu.changePage(index);
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //         builder: (context) =>
//               //             AddProductPage(categoryId: ,),
//               //       ),
//               //     );
//               //   },
//               //   icon: const Icon(Icons.category),
//               //   trailing: Container(
//               //     decoration: const BoxDecoration(
//               //       color: Colors.amber,
//               //       borderRadius: BorderRadius.all(Radius.circular(6)),
//               //     ),
//               //     child: Padding(
//               //       padding: const EdgeInsets.symmetric(
//               //         horizontal: 6.0,
//               //         vertical: 3,
//               //       ),
//               //       child: Text(
//               //         'New',
//               //         style: TextStyle(fontSize: 11, color: Colors.grey[800]),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SideMenuItem(
//                 title: 'Category',
//                 onTap: (index, _) {
//                   sideMenu.changePage(index);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CategoryPage(),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.category_outlined),
//               ),
//               SideMenuItem(
//                 title: 'Exit',
//                 onTap: (index, _) {
//                   // Exit or handle navigation here
//                 },
//                 icon: const Icon(Icons.exit_to_app),
//               ),
//             ],
//           ),
//           const VerticalDivider(
//             width: 0,
//           ),
//           Expanded(
//             child: PageView(
//               controller: pageController,
//               children: [
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Dashboard',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Users',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Products',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: const Center(
//                     child: Text(
//                       'Category',
//                       style: TextStyle(fontSize: 35),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:e_commerce_admin/features/order/presentation/view/order_page.dart';
import 'package:e_commerce_admin/features/users/presentation/view/user_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:e_commerce_admin/features/categories/presentation/view/category_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  final SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    super.initState();

    // Synchronize SideMenu with PageView
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    sideMenu.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Side Menu for Navigation
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              showHamburger: true,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Colors.blue[100],
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            items: [
              SideMenuItem(
                title: 'Dashboard',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.dashboard),
              ),
              SideMenuItem(
                title: 'Users',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserPage(),
                      ));
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                title: 'Category',
                onTap: (index, _) {
                  sideMenu.changePage(index);
                },
                icon: const Icon(Icons.category),
              ),
              SideMenuItem(
                title: 'Exit',
                onTap: (index, _) {
                  // Handle exit logic
                },
                icon: const Icon(Icons.exit_to_app),
              ),
              SideMenuItem(
                title: 'orders',
                onTap: (index, _) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderPage()));
                },
              )
            ],
          ),
          const VerticalDivider(width: 1, thickness: 1),

          // Main Content Area
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Users',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                // const UserPage(),
                const CategoryPage(), // Navigate to Category Page
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Exit',
                    style: TextStyle(fontSize: 35),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Orders',
                    style: TextStyle(fontSize: 34),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
