import 'package:drinks_flutter_app/data/drink_list_remote_data_source.dart';
import 'package:drinks_flutter_app/data/drink_list_repository_impl.dart';
import 'package:drinks_flutter_app/domain/interactors/drink_list_interactor.dart';
import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/usecases/bookmark_use_case.dart';
import 'package:drinks_flutter_app/domain/usecases/get_drink_list_with_bookmarks_use_case.dart';
import 'package:drinks_flutter_app/presentation/pages/drink_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../bloc/base/base_block.dart';
import '../bloc/drinkList/drink_list_bloc.dart';

class DrinkListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final drinkRepository =
        DrinkListRepositoryImpl(DrinkListRemoteDataSourceImpl());
    final drinkListInteractor = DrinkListInteractor(
        AddBookmarkUseCase(drinkRepository),
        GetDrinkListWithBookmarkUseCase(drinkRepository),
        RemoveBookmarkUseCase(drinkRepository));
    return BlocProvider(
      create: (_) => DrinkListBloc(drinkListInteractor)..add(GetDrinks()),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: typing ? TextBox() : Text("Drinks"),
        leading: IconButton(
          icon: Icon(typing ? Icons.done : Icons.search),
          onPressed: () {
            setState(() {
              typing = !typing;
            });
          },
        ),
      ),
      body: DrinkList(),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<DrinkListBloc, DrinkListState, String>(
      selector: (state) {
        return state.searchParameter;
      },
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextFormField(
            initialValue: state,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Search'),
            onChanged: (text) {
              context
                  .read<DrinkListBloc>()
                  .add(SearchUpdated(searchQuery: text));
            },
          ),
        );
      },
    );
  }
}

class DrinkList extends StatelessWidget {
  const DrinkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DrinkListBloc>().add(GetDrinks());
      },
      child: BlocBuilder<DrinkListBloc, DrinkListState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.failure:
              return Center(child: Text(state.error?.toString() ?? "Error"));
            case Status.success:
              if (state.drinks.isEmpty) {
                return const Center(child: Text('no drinks'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final drink = state.drinks[index];
                  return DrinkListItemWidget(
                    drink: drink,
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrinkDetailRoute(
                                drinkId: drink.id, drinkName: drink.name)),
                      );
                    },
                  );
                },
                itemCount: state.drinks.length,
              );
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DrinkListItemWidget extends StatelessWidget {
  const DrinkListItemWidget(
      {Key? key, required this.drink, required this.onItemClicked})
      : super(key: key);

  final DrinkListItemWithBookmark drink;
  final void Function() onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: DrinkImage(source: drink.image),
          trailing: BookmarkButton(
              isBookmark: drink.bookmark,
              onPressed: () {
                context.read<DrinkListBloc>().add(DrinkListBookmarkEvent(
                    add: !drink.bookmark, drinkId: drink.id));
              }),
          title: Text(drink.name),
          subtitle: Text(drink.name),
          dense: false,
          onTap: () {
            onItemClicked();
          },
        ),
      ),
    );
  }
}

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    Key? key,
    required this.isBookmark,
    required this.onPressed,
  }) : super(key: key);
  final void Function() onPressed;
  final bool isBookmark;

  @override
  Widget build(BuildContext context) {
    final color = isBookmark ? Colors.red : Colors.grey;
    final icon = isBookmark ? Icons.favorite : Icons.favorite_border;
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
        ));
  }
}

class DrinkImage extends StatelessWidget {
  const DrinkImage({Key? key, required this.source}) : super(key: key);
  final String source;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: source,
      ),
    );
  }
}
