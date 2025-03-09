import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/core/theme.dart';

import '../../../../common/app_route.dart';
import '../bloc/all_user_bloc.dart';
import '../widgets/circle_loading.dart';

class ThirdPage extends StatefulWidget {
  final String name;
  const ThirdPage({super.key, required this.name});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    super.initState();
    context.read<AllUserBloc>().add(GetAllUserEvent());
  }

  final imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Third Page'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<AllUserBloc>().add(GetAllUserEvent());
            await Future.delayed(Duration(milliseconds: 500));
          },
          child: BlocBuilder<AllUserBloc, AllUserState>(
            builder: (context, state) {
              if (state is AllUserLoading) {
                return Center(child: CircleLoading());
              } else if (state is AllUserLoaded) {
                var users = state.data;
                if (users.isEmpty) {
                  return Center(
                      child: Text(
                    'Data is Empty',
                    style: greyTextStyle.copyWith(
                        fontSize: 16, fontWeight: semiBold),
                  ));
                }
                return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    controller: context.read<AllUserBloc>().scrollController,
                    itemCount: context.read<AllUserBloc>().isLoadingMore
                        ? users.length + 1
                        : users.length,
                    itemBuilder: (context, index) {
                      if (index >= users.length) {
                        return Center(child: CircleLoading());
                      } else {
                        var user = users[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          child: ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipOval(
                                  child: ExtendedImage.network(
                                    user.profileImageUrl,
                                    fit: BoxFit.cover,
                                    handleLoadingProgress: true,
                                    cache: true,
                                    loadStateChanged: (state) {
                                      if (state.extendedImageLoadState ==
                                          LoadState.failed) {
                                        return Material(
                                          color: Colors.grey[300],
                                          child: Icon(Icons.broken_image,
                                              color: Colors.black),
                                        );
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              user.fullName,
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: medium),
                            ),
                            subtitle: Text(
                              user.email,
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: medium),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoute.second,
                                arguments: {
                                  'name': widget.name,
                                  'user': user.fullName,
                                },
                              );
                            },
                          ),
                        );
                      }
                    });
              } else if (state is AllUserFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
