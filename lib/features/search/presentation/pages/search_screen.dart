import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socially/features/authentication/presentation/utils/const.dart';
import 'package:socially/features/profile/presentation/pages/profile_screen.dart';
import 'package:socially/features/profile/presentation/widgets/profile_image.dart';
import 'package:socially/features/search/presentation/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/features/search/presentation/widgets/centered_text.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _controller,
            keyboardType: TextInputType.name,
            // onFieldSubmitted: (_) => node.unfocus(),
            decoration: textFormFieldDecoration.copyWith(
              hintText: 'Search',
              fillColor: Theme.of(context).hintColor,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade500,
              ),
              hintStyle: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  context.read<SearchCubit>().clearSearch();
                  _controller.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
            style: GoogleFonts.lato(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).focusColor,
            ),
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                context.read<SearchCubit>().searchUsers(value.trim());
              }
            },
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            switch (state.status) {
              case SearchStatus.error:
                return CenteredText(text: state.failure.message);
              case SearchStatus.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).focusColor,
                  ),
                );
              case SearchStatus.loaded:
                return state.users.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = state.users[index];
                          return ListTile(
                            leading: UserProfileImage(
                              radius: 22,
                              profileImageUrl: user.profileImageUrl,
                            ),
                            title: Text(
                              user.username,
                              style: GoogleFonts.lato(
                                color: Theme.of(context).focusColor,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pushNamed(
                              ProfileScreen.routeName,
                              arguments: ProfileScreenArgs(userId: user.id),
                            ),
                          );
                        },
                      )
                    : const CenteredText(text: 'No users found');
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
