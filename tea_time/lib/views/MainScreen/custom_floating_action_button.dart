import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/data/repository/collection_repository_impl.dart';

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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
              CollectionRepositoryImpl().addAContainer(collectionId ?? '');
              context.read<CollectionCubit>().getCollection(collectionId ?? '');
              debugPrint('pushed');
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
