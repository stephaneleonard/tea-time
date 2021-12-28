import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
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
    const ProfileScreen(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        if (state is UserLoading) {
          return const Scaffold(
            appBar: CustomAppBar(title: 'Tea Time'),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is UserLoaded) {
          if (state.user.collectionId != null) {
            context
                .read<CollectionCubit>()
                .getCollection(state.user.collectionId ?? '');
          }

          return Scaffold(
            appBar: const CustomAppBar(title: 'Tea Time'),
            body: pages[selectedIndex],
            bottomNavigationBar: CustomBottomNavigationBar(
              selectedIndex: selectedIndex,
              onItemTap: onItemTap,
            ),
            floatingActionButton: selectedIndex == 0
                ? CustomFloatingActionButton(
                    collectionId: state.user.collectionId,
                    userId: state.user.id,
                  )
                : null,
          );
        }

        return Scaffold(
          appBar: const CustomAppBar(title: 'Tea Time'),
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('error try logout'),
            ),
          ),
        );
      },
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    required this.collectionId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  final String? collectionId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    if (collectionId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<CollectionCubit, CollectionState>(
      builder: (BuildContext context, CollectionState state) {
        if (state is CollectionLoaded) {
          if (state.collection.owner != userId) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton.extended(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              'Add Container',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // TODO implement
              debugPrint('pushed');
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  final int selectedIndex;
  final Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTap,
      selectedItemColor: Colors.green.shade300,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Collection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_cafe_outlined),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
