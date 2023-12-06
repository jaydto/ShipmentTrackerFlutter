import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../middleware/api_middleware.dart'; // Import your middleware
import '../reducers/index.dart';

import 'app_state.dart'; // Import your reducers
final dio = Dio(); // Initialize the Dio instance

final apiMiddleware = ApiMiddleware(dio); // Create an instance of ApiMiddleware

final store = Store<AppState>(
  rootReducer, // Combined reducer function from your reducers
  initialState: AppState.initial(), // Initial state
  middleware: [thunkMiddleware
  // ,
  //  (Store<AppState> store, dynamic action, NextDispatcher next) {
  //     apiMiddleware.createMiddleware()(store, action, next);
  //   },
    ]
  // middleware: [
  //   // Add any middleware you need here, such as for API requests
  //       (Store<AppState> store, dynamic action, NextDispatcher next) {
  //     apiMiddleware.createMiddleware()(store, action, next);
  //   },
  // ],
);
