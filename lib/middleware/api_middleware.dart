import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import '../services/api_services.dart'; // Import your ApiService
import '../actions/api_actions.dart'; // Import your ApiActions

import '../store/app_state.dart';

class ApiMiddleware {
  final Dio dio; // You should configure and initialize Dio elsewhere

  ApiMiddleware(this.dio);

  Middleware<AppState> createMiddleware() {
    // print('message');
    return (Store<AppState> store, action, NextDispatcher next) async {
      next(action); // Dispatch the action to the next middleware or reducer

      if (action is ApiRequestAction) {
        // Handle API request actions
        try {
          final   response =
              await ApiService.makeRequest(
            url: action.endpoint,
            method: action.method,
            data: action.data,
            useJwt: action.useJwt,
          );

          if (response[0] == 200) {
            // Successful API response
            store.dispatch(ApiSuccessAction(response[1]));
          } else {
            // Handle API error response
            store.dispatch(ApiFailureAction(
                response[1] ?? 'API request failed.'));
          }
        } catch (error) {
          // Handle API request failure
          store.dispatch(ApiFailureAction(error.toString()));
        }
      }

      // Continue with the next action
      next(action);
    };
  }
}
