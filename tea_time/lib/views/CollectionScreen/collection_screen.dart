import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/domain/entities/tea_container.dart';

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
            return CollectionList(
              collectionId: state.user.collectionId ?? '',
              userId: state.user.id,
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 40)),
                const Text(
                  'No collection linked to this account',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/collection_creation',
                        arguments: state.user.accountId,
                      );
                    },
                    child: const Text('Create a Collection'),
                  ),
                ),
              ],
            ),
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
      },
    );
  }
}

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        return EmptyContainerTile(index: index);
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

class FullContainerTile extends StatelessWidget {
  const FullContainerTile({
    required this.index,
    required this.container,
    Key? key,
  }) : super(key: key);

  final TeaContainer container;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        Navigator.pushNamed(
          context,
          '/brewing',
          arguments: container.reviewId ?? '',
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.grey.shade800,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/${container.type}.png',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 5,
              ),
            ),
            Text(
              'Box: ${index + 1}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 7,
              ),
            ),
            Text(
              container.name ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyContainerTile extends StatelessWidget {
  const EmptyContainerTile({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/create_tea');
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.grey.shade800,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Icon(
                  Icons.edit,
                  size: 50,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
            ),
            Text(
              'Box: ${index + 1}',
              style: Theme.of(context).textTheme.headline6,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 7,
              ),
            ),
            Text(
              'Empty',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
