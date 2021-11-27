import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/core/widgets/error_dialog.dart';
import 'package:socially/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:socially/features/profile/presentation/widgets/post_view.dart';

class FeedScreen extends StatefulWidget {
  static const String routeName = '/feed';
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          if (_scrollController.offset >=
                  _scrollController.position.maxScrollExtent &&
              !_scrollController.position.outOfRange &&
              context.read<FeedBloc>().state.status != FeedStatus.paginating) {
            context.read<FeedBloc>().add(FeedPaginatePosts());
          }
        },
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state.status == FeedStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        } else if (state.status == FeedStatus.paginating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              duration: const Duration(seconds: 1),
              content: Text(
                'Fetching more posts...',
                style: GoogleFonts.raleway(
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Socially',
              style: GoogleFonts.raleway(
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(FeedState state) {
    switch (state.status) {
      case FeedStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).focusColor,
          onRefresh: () async {
            context.read<FeedBloc>().add(FeedFetchPosts());
          },
          child: ListView.builder(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return PostView(post: post, isLiked: false);
            },
          ),
        );
    }
  }
}
