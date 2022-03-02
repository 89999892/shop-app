import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/Data&network/remote/constants.dart';
import 'package:shop_app/Data&network/remote/endPoints.dart';
import 'package:shop_app/Data&network/remote/shop_DioHelper.dart';
import 'package:shop_app/models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  SearchModel searchModel;
void UserSearch(String text){
  emit(SearchLoadingState());
  DioHelper.postData(path: SEARCH, data:{
    'text':text
  },authorization: token ).then((value){
    searchModel=SearchModel.fromJson(value.data);
    print('this is the search Model =${searchModel.toString()}');
    emit(SearchSuccessState(searchModel));
  }).catchError((error){
    print('$error');
    emit(SearchErrorState());
  });
}
}
