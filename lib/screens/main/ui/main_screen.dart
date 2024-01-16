import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:audio_book_flutter/data/model/book_model.dart';
import 'package:audio_book_flutter/data/repository/app_repository_impl.dart';
import 'package:audio_book_flutter/data/source/local/pref/my_shared_pref.dart';
import 'package:audio_book_flutter/domain/repository/app_repository.dart';
import 'package:audio_book_flutter/screens/by_category/by_category_page.dart';
import 'package:audio_book_flutter/screens/main/bloc/main_bloc.dart';
import 'package:audio_book_flutter/screens/playing/playing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late MainBloc _dashboardBloc;
  List<BookData> books = [];
  final AppRepository _repository = AppRepositoryImpl();
  List<String> categoryList = ['Humor', 'Story', 'Fiction', 'Detective'];

  @override
  void initState() {
    super.initState();
    _dashboardBloc = MainBloc()..add(BooksLoadEvent());
  }

  @override
  void dispose() {
    _dashboardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dashboardBloc,
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is BooksLoadFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is BooksLoadedState) {
            books.addAll(state.books);
            print(state.books.length);
          }
          if (state is BooksLoadingState) {
            if (MySharedPreference.getTheme() == true) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
            print("loading books");
            const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is BookByCategoryState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ByCategoryPage(state.category),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }

          if (state is BookToPlayState) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PlayingPage(state.id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 17, right: 17, left: 17),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Visibility(
                            visible: false,
                            child: Icon(Icons.arrow_back_rounded)),
                        const Spacer(),
                        const Text(
                          'Explore',
                          style: TextStyle(
                            color: Color(0xFFF26B6C),
                            fontSize: 20,
                            fontFamily: 'Uni Neue',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              context
                                  .read<MainBloc>()
                                  .add(BooksLoadEvent());
                            },
                            child: const Icon(Icons.more_vert))
                      ],
                    ),
                    Expanded(
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 30, right: 20.0, left: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'New Releases Book',
                                        style: TextStyle(
                                          color: Color(0xFF4F4F4F),
                                          fontSize: 20,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'See All',
                                        style: TextStyle(
                                          color: Color(0xFFF26B6C),
                                          fontSize: 12,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25),
                                SizedBox(
                                  height: 146,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: books.isEmpty ? 4 : books.length,
                                    itemBuilder: (context, index) {
                                      if (books.isEmpty) {
                                        return Container(
                                          width: 103,
                                          margin:
                                          const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300]!,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(4, 4),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          width: 103,
                                          margin:
                                          const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300]!,
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 4,
                                                offset: Offset(4, 4),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              context.read<MainBloc>().add(
                                                  BookToPlayEvent(books[index]
                                                      .id
                                                      .toString()));
                                            },
                                            child: Hero(
                                                tag: "${books[index].id}",
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  child: FutureBuilder<String>(
                                                    future: _repository
                                                        .getDownloadURL(
                                                        books[index].img!),
                                                    builder: (BuildContext
                                                    context,
                                                        AsyncSnapshot<String>
                                                        snapshot) {
                                                      if (snapshot
                                                          .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child: Shimmer
                                                                .fromColors(
                                                              baseColor:
                                                              Colors.grey[300]!,
                                                              highlightColor:
                                                              Colors.grey[100]!,
                                                              child: Container(
                                                                color: Colors.grey,
                                                              ),
                                                            ));
                                                      } else if (snapshot
                                                          .hasError ||
                                                          !snapshot.hasData) {
                                                        return const Center(
                                                            child: Icon(
                                                                Icons.error));
                                                      } else {
                                                        return Image.network(
                                                            snapshot.data!,
                                                            fit: BoxFit.cover);
                                                      }
                                                    },
                                                  ),
                                                )),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 30, right: 20.0, left: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          color: Color(0xFF4F4F4F),
                                          fontSize: 20,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'See All',
                                        style: TextStyle(
                                          color: Color(0xFFF26B6C),
                                          fontSize: 12,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: categoryList.length,
                                      itemBuilder: (context, index) {
                                        if (books.isNotEmpty) {
                                          return InkWell(
                                              onTap: () {
                                                context
                                                    .read<MainBloc>()
                                                    .add(BooksByCategoryEvent(
                                                    categoryList[index]));
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 50,
                                                margin:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: categoryList[index] ==
                                                        "Humor"
                                                        ? const Color(
                                                        0x19F26B6C)
                                                        : categoryList[index] ==
                                                        "Story"
                                                        ? const Color(
                                                        0x196FCF97)
                                                        : categoryList[
                                                    index] ==
                                                        "Fiction"
                                                        ? const Color(
                                                        0x19F2C94C)
                                                        : const Color(
                                                        0x19F26B6C)),
                                                child: Center(
                                                  child: Text(
                                                    categoryList[index],
                                                    style: TextStyle(
                                                      color: categoryList[index] ==
                                                          "Humor"
                                                          ? const Color(
                                                          0xFFF26B6C)
                                                          : categoryList[
                                                      index] ==
                                                          "Story"
                                                          ? const Color(
                                                          0xFF219653)
                                                          : categoryList[
                                                      index] ==
                                                          "Fiction"
                                                          ? const Color(
                                                          0xFFF2C94C)
                                                          : const Color(
                                                          0xFFF26B6C),
                                                      fontSize: 12,
                                                      fontFamily: 'Uni Neue',
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      height: 0,
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        } else {
                                          return Container(
                                            width: 100,
                                            height: 50,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                Colors.grey[200]!,
                                                child: Container(
                                                    color: Colors.grey)),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(right: 20.0, left: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Featured Books',
                                        style: TextStyle(
                                          color: Color(0xFF4F4F4F),
                                          fontSize: 20,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'See All',
                                        style: TextStyle(
                                          color: Color(0xFFF26B6C),
                                          fontSize: 12,
                                          fontFamily: 'Uni Neue',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 27)
                              ],
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 103 / 146,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                if (books.isEmpty) {
                                  return Container(
                                    width: 103,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300]!,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 4,
                                          offset: Offset(4, 4),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                      onTap: () {
                                        context.read<MainBloc>().add(
                                            BookToPlayEvent(
                                                books[index].id.toString()));
                                      },
                                      child: Container(
                                        width: 103,
                                        margin:
                                        const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300]!,
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x3F000000),
                                              blurRadius: 4,
                                              offset: Offset(4, 4),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          child: FutureBuilder<String>(
                                            future: _repository.getDownloadURL(
                                                books[index].img!),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child: Shimmer.fromColors(
                                                      baseColor: Colors.grey[300]!,
                                                      highlightColor:
                                                      Colors.grey[100]!,
                                                      child: Container(
                                                        color: Colors.grey,
                                                      ),
                                                    ));
                                              } else if (snapshot.hasError ||
                                                  !snapshot.hasData) {
                                                return const Center(
                                                    child: Icon(Icons.error));
                                              } else {
                                                return Image.network(
                                                    snapshot.data!,
                                                    fit: BoxFit.cover);
                                              }
                                            },
                                          ),
                                        ),
                                      ));
                                }
                              },
                              childCount: books.isEmpty ? 3 : books.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}