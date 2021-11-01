import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/views/CollectionScreen/collection_screen.dart';
import 'package:tea_time/views/DiscoverScreen/discover_screen.dart';
import 'package:tea_time/views/ProfileScreen/profile_screen.dart';
import 'package:tea_time/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = <Widget>[
    const CollectionScreen(),
    const DiscoverScreen(),
    const ProfileScreen()
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUserInfos();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tea Time'),
      body: pages[selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTap: onItemTap,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {required this.selectedIndex, required this.onItemTap, Key? key})
      : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTap,
      selectedItemColor: Colors.green,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined), label: 'Collection'),
        BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined), label: 'Discover'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
      ],
    );
  }
}

class Testbloc extends StatelessWidget {
  const Testbloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUserInfos();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return Center(child: Text(state.user.name));
        }
        if (state is UserLoading) {
          return const Text('loading');
        }
        if (state is UserError) {
          Text(state.message);
        }
        return const Text('error');
      },
    );
  }
}

// Column(
//         children: <Widget>[
//           BlocBuilder<UserCubit, UserState>(
//               builder: (BuildContext context, UserState state) {
//             if (state is UserLoading) {
//               return const Text('loading');
//             }
//             if (state is UserLoaded) {
//               return Text(state.user.name);
//             }
//             if (state is UserError) {
//               return const Text('error');
//             }
//             return const Text('error');
//           }),
//           TextButton(
//             onPressed: () async {
//               await firebaseAuth.signOut();
//               Navigator.popAndPushNamed(context, '/login');
//             },
//             child: const Text('sign out'),
//           ),
//         ],
//       ),