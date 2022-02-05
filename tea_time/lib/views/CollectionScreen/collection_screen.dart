import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/cubit/user_cubit.dart';
import 'package:tea_time/views/CollectionScreen/collection_list.dart';

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
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
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
