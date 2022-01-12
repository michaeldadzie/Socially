// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/core/widgets/error_dialog.dart';
import 'package:socially/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:socially/features/create/data/repositories/post_repository.dart';
import 'package:socially/features/feed/presentation/cubit/liked_post_cubit.dart';
import 'package:socially/features/profile/data/repositories/user/user_repository.dart';
import 'package:socially/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:socially/features/profile/presentation/widgets/post_view.dart';
import 'package:socially/features/profile/presentation/widgets/profile_image.dart';
import 'package:socially/features/profile/presentation/widgets/profile_info.dart';
import 'package:socially/features/profile/presentation/widgets/profile_stats.dart';

class ProfileScreenArgs {
  final String userId;

  const ProfileScreenArgs({required this.userId});
}

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  static Route route({required ProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          likedPostCubit: context.read<LikedPostCubit>(),
          userRepository: context.read<UserRepository>(),
          postRepository: context.read<PostRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..add(
            ProfileLoadUser(userId: args.userId),
          ),
        child: ProfileScreen(),
      ),
    );
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                state.user.username,
                style: GoogleFonts.raleway(
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              if (state.isCurrentUser)
                IconButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(AuthLogoutRequested()),
                  icon: Icon(
                    Icons.logout,
                    color: Theme.of(context).focusColor,
                  ),
                )
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state) {
    switch (state.status) {
      case ProfileStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).focusColor,
          onRefresh: () async {
            // await Future.delayed(Duration(seconds: 1));
            context.read<ProfileBloc>().add(
                  ProfileLoadUser(userId: state.user.id),
                );
          },
          child: CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, //Wrong place, fix it
                    children: [
                      Row(
                        children: [
                          UserProfileImage(
                            radius: 50,
                            profileImageUrl: state.user.profileImageUrl,
                          ),
                          ProfileStats(
                            isCurrentUser: state.isCurrentUser,
                            isFollowing: state.isFollowing,
                            posts: state.posts.length,
                            followers: state.user.followers,
                            following: state.user.following,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ProfileInfo(
                        name: state.user.name,
                        bio: state.user.bio,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).focusColor,
                  unselectedLabelColor: Theme.of(context).shadowColor,
                  indicatorWeight: 3.0,
                  onTap: (i) => context.read<ProfileBloc>().add(
                        ProfileToggleGridView(isGridView: i == 0),
                      ),
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on, size: 28)),
                    Tab(icon: Icon(Icons.list, size: 28))
                  ],
                ),
              ),
              state.isGridView
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = state.posts[index];
                          return GestureDetector(
                            onTap: () {},
                            child: CachedNetworkImage(
                              imageUrl: post.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        childCount: state.posts.length,
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = state.posts[index];
                          final likedPostsState =
                              context.watch<LikedPostCubit>().state;
                          final isLiked =
                              likedPostsState.likedPostIds.contains(post.id);
                          return PostView(
                            onLike: () {
                              if (isLiked) {
                                context
                                    .read<LikedPostCubit>()
                                    .unlikePost(post: post);
                              } else {
                                context
                                    .read<LikedPostCubit>()
                                    .likePost(post: post);
                              }
                            },
                            post: post,
                            isLiked: isLiked,
                          );
                        },
                        childCount: state.posts.length,
                      ),
                    ),
            ],
          ),
        );
    }
  }
}
