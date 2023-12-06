import 'package:shipment_tracker/constants/ActionConstants.dart';
import 'package:shipment_tracker/services/local_storage.dart';
import 'package:shipment_tracker/store/app_state.dart';


//define reducers

dynamic authReducerReducer(AppState state, dynamic action) {
  
  }


// Create a separate reducer function that follows the Reducer<AppState> type signature
AppState authReducer(AppState state, dynamic action) {
  return authReducerReducer(state, action);
}
