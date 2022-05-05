import 'package:drinks_flutter_app/domain/model/drink_detail_with_bookmark.dart';
import 'package:drinks_flutter_app/presentation/bloc/drinkDetail/drink_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../data/drink_list_remote_data_source.dart';
import '../../data/drink_list_repository_impl.dart';
import '../../domain/interactors/drink_detail_interactor.dart';
import '../../domain/usecases/bookmark_use_case.dart';
import '../../domain/usecases/get_drink_detail_with_bookmark_use_case.dart';
import '../bloc/base/base_block.dart';

class DrinkDetailRoute extends StatelessWidget {
  const DrinkDetailRoute({
    Key? key,
    required this.drinkId,
    required this.drinkName,
  }) : super(key: key);

  final int drinkId;
  final String drinkName;

  @override
  Widget build(BuildContext context) {
    final drinkRepository =
        DrinkListRepositoryImpl(DrinkListRemoteDataSourceImpl());
    final drinkDetailInteractor = DrinkDetailInteractor(
        addBookmarkUseCase: AddBookmarkUseCase(drinkRepository),
        removeBookmarkUseCase: RemoveBookmarkUseCase(drinkRepository),
        drinkDetailWithBookmarkUseCase:
            GetDrinkDetailWithBookmarkUseCase(drinkRepository));
    return BlocProvider(
      create: (_) => DrinkDetailBloc(drinkDetailInteractor)
        ..add(GetDrinkDetail(drinkId: drinkId)),
      child: DrinkDetailPage(
        title: drinkName,
      ),
    );
  }
}

class DrinkDetailPage extends StatelessWidget {
  const DrinkDetailPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocBuilder<DrinkDetailBloc, DrinkDetailState>(
          builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            return DrinkDetailWidget(detail: state.drink!);
          case Status.failure:
            return Center(child: Text(state.error?.toString() ?? "Error"));
            break;
        }
      }),
    );
  }
}

class DrinkDetailWidget extends StatelessWidget {
  const DrinkDetailWidget({Key? key, required this.detail}) : super(key: key);

  final DrinkDetailWithBookmark detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: detail.image,
          ),
        ),
        Text(detail.name),
        Text(detail.instructions)
      ],
    );
  }
}
