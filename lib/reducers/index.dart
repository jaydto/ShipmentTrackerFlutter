import 'package:redux/redux.dart';

import '../store/app_state.dart'; // Import your AppState
import './auth_reducer.dart';

import './navigations_reducer.dart';

// Combine all your reducers into one
final Reducer<AppState> appReducer = combineReducers<AppState>([
  authReducer,
  navigationsReducer
  
]);

// Define the root reducer for your app
AppState rootReducer(AppState state, dynamic action) {
  return appReducer(state, action);
}
