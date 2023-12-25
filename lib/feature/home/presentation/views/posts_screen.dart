// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/core/local_storage/keys.dart';
import 'package:gitty/core/local_storage/storage.dart';
import 'package:gitty/core/routes/route_paths.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_bloc.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_events.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_states.dart';
import 'package:gitty/feature/home/presentation/widget/post_widget.dart';
import 'package:gitty/injection_container.dart';
import 'package:gitty/src/values/colors.dart';
import 'package:go_router/go_router.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<PostScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<PostScreenBloc, PostScreenStates>(
        builder: (context, state) {
          if (state is PostInitialState) {
            context.read<PostScreenBloc>().add(FetchPostsEvent());
          } else if (state is FetchingPostsState) {
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Posts",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.instance.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PostsFetchingSuccessfulState) {
            final posts = state.postEntity!.data;
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Posts",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            var res =
                                await LocalStorage.instance.writeBoolToLocalDb(
                              key: AppLocalStorageKeys.instance.isLoggedIn,
                              value: false,
                            );

                            if (res) {
                              context.replace(
                                  AppRoutePaths.instance.loginScreenRoutePath);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Failed to log out",
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(FontAwesomeIcons.rightFromBracket),
                        ),
                      ],
                    ),
                    verticalSpace(h: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostWidget(
                            size: size,
                            body: posts[index].body,
                            title: posts[index].title,
                            userId: posts[index].userId,
                            postId: posts[index].id,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(h: 20);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PostsFetchingFailedState) {
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Posts",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Try again..",
                            ),
                            verticalSpace(h: 15),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<PostScreenBloc>()
                                    .add(FetchPostsEvent());
                              },
                              icon: const Icon(
                                FontAwesomeIcons.rotateRight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return emptyContainer();
        },
      ),
    );
  }
}
