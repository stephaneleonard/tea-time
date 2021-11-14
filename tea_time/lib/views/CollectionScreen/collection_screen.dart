import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/collection_cubit.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/data/model/collection.dart';
import 'package:tea_time/data/model/screen_arguments.dart';
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
          if (userId == state.collection.owner) {
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 30),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: state.collection.containers?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (state.collection.containers![index].name == null) {
                    return EmptyContainerTile(index: index);
                  }
                  return FullContainerTile(
                    index: index,
                    container: state.collection.containers![index],
                  );
                },
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: state.collection.containers?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (state.collection.containers![index].name == null) {
                  return EmptyContainerTile(index: index);
                }
                return FullContainerTile(
                  index: index,
                  container: state.collection.containers![index],
                );
              },
            ),
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
          arguments:
              ScreenArguments(index: index, id: container.reviewId ?? ''),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
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
              container.name ?? '',
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

class EmptyContainerTile extends StatelessWidget {
  const EmptyContainerTile({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Container(),
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
    );
  }
}

class AddContainerTile extends StatelessWidget {
  const AddContainerTile({required this.uid, Key? key}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addABox(uid);
        context.read<CollectionCubit>().getCollection(uid);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.add_circle_outline_outlined,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
            ),
            Text(
              'Add Container',
              style: Theme.of(context).textTheme.headline6,
              softWrap: false,
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 7,
              ),
            ),
            const Text(
              '',
              style: TextStyle(
                color: Colors.black,
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
