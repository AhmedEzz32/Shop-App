import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/models/shop_app/home_model.dart';
import 'package:project1/models/shop_app/search_model.dart';
import 'package:project1/modules/shop_app/search/cubit/states.dart';
import 'package:project1/shared/components/constants.dart';
import 'package:project1/shared/network/end_points.dart';
import 'package:project1/shared/network/remote/diohelper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel ;

  void search({
    required String text ,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      lang: 'en',
      data:
      {
        'text':text,
      },
      token: token ,
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(SearchErrorState(error.toString()),);
    });
  }
}