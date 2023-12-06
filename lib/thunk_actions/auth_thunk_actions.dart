import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart'; // Import the Redux Thunk middleware
import '../actions/auth_actions.dart'; // Import your action types
import '../services/api_services.dart';
import '../store/app_state.dart'; // Import your API service

// Thunk action for user login
