import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/views/CollectionScreen/empty_container_tile.dart';
import 'package:tea_time/views/CollectionScreen/full_container_tile.dart';

class CollectionList extends StatelessWidget {
  const CollectionList({
    required this.collectionId,
    required this.userId,
    Key? key,
  }) : super(key: key);

  final String collectionId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    context.read<CollectionCubit>().getCollection(collectionId);

    return BlocBuilder<CollectionCubit, CollectionState>(
      builder: (BuildContext context, CollectionState state) {
        if (state is CollectionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CollectionLoaded) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Text(
                        state.collection.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (state.collection.containers![index].name == null) {
                        return EmptyContainerTile(
                          index: index,
                          collectionId: state.collection.id,
                          containerList: state.collection.containers,
                        );
                      }

                      return FullContainerTile(
                        index: index,
                        container: state.collection.containers![index],
                      );
                    },
                    childCount: state.collection.containers?.length ?? 0,
                  ),
                ),
              ),
            ],
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
      },
    );
  }
}
