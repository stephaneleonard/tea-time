import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/cubit/user_cubit.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
        builder: (BuildContext context, UserState state) {
      if (state is UserLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UserLoaded) {
        if (state.user.collectionId != null) {
          return BlocProvider<CollectionCubit>(
            create: (BuildContext context) => CollectionCubit(),
            child: CollectionList(
              id: state.user.collectionId ?? '',
            ),
          );
        }
        return const Center(
          child: Text('no collection linked to this account'),
        );
      }
      if (state is UserError) {
        return Center(
          child: Text(state.message),
        );
      }
      return const Center(
        child: Text('error'),
      );
    });
  }
}

class CollectionList extends StatelessWidget {
  const CollectionList({required this.id, Key? key}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    context.read<CollectionCubit>().getCollection(id);
    return BlocBuilder<CollectionCubit, CollectionState>(
        builder: (BuildContext context, CollectionState state) {
      if (state is CollectionLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CollectionLoaded) {
        return Center(
          child: Text(state.collection.owner),
        );
      }
      if (state is CollectionError) {
        return Center(
          child: Text('collection error: ${state.message}'),
        );
      }
      return const Center(
        child: Text('Unexpected error'),
      );
    });
  }
}
