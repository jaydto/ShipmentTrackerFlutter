import 'package:shipment_tracker/constants/ActionConstants.dart';
import 'package:shipment_tracker/store/app_state.dart';

dynamic navigationsReducerReducer(AppState state, dynamic action) {
 //define reducers
}

// Create a separate reducer function that follows the Reducer<AppState> type signature
AppState navigationsReducer(AppState state, dynamic action) {
  return navigationsReducerReducer(state, action);
}
