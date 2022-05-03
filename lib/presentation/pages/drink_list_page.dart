import 'package:drinks_flutter_app/data/drink_list_remote_data_source.dart';
import 'package:drinks_flutter_app/data/drink_list_repository_impl.dart';
import 'package:drinks_flutter_app/domain/model/drink_list_item_with_bookmark.dart';
import 'package:drinks_flutter_app/domain/usecases/bookmark_use_case.dart';
import 'package:drinks_flutter_app/domain/usecases/drink_list_interactor.dart';
import 'package:drinks_flutter_app/domain/usecases/get_drink_list_with_bookmarks_use_case.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

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
      create: (_) =>
          DrinkListBloc(drinkListInteractor)..add(DrinkListFetched()),
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
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'Search'),
        onChanged: (text) {
          context.read<DrinkListBloc>().add(SearchDrinks(searchQuery: text));
        },
      ),
    );
  }
}

class DrinkList extends StatelessWidget {
  const DrinkList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DrinkListBloc>().add(DrinkListFetched());
      },
      child: BlocSelector<DrinkListBloc, DrinkListState, DrinkListStatus>(
        selector: (state) {return state.status;},
        builder: (context, state) {
          switch (state.status) {
            case DrinkListStatus.failure:
              return const Center(child: Text('failed to fetch drinks'));
            case DrinkListStatus.success:
              if (state.drinks.isEmpty) {
                return const Center(child: Text('no drinks'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return DrinkListItemWidget(drink: state.drinks[index]);
                },
                itemCount: state.drinks.length,
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DrinkListItemWidget extends StatelessWidget {
  const DrinkListItemWidget({Key? key, required this.drink}) : super(key: key);

  final DrinkListItemWithBookmark drink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: DrinkImage(source: drink.image),
          trailing: FavoriteButton(
            iconSize: 30.0,
            isFavorite: drink.bookmark,
            valueChanged: (_) {
              if (drink.bookmark) {
                context
                    .read<DrinkListBloc>()
                    .add(RemoveBookmark(drinkId: drink.id));
              } else {
                context
                    .read<DrinkListBloc>()
                    .add(AddBookmark(drinkId: drink.id));
              }
            },
          ),
          title: Text(drink.name),
          subtitle: Text(drink.name),
          dense: false,
          onTap: () {},
        ),
      ),
    );
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
