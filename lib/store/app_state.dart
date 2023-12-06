import 'dart:async';

class AppState {


  final NavigationsState navigations;

  AppState({


    required this.navigations,
  });

  factory AppState.initial() {
    return AppState(
     
      navigations: NavigationsState(
        navigations: {},
        error: [],
        mobile_default_navigations: [
          
          // ... add other navigations properties ...
        ],
        loading: false,
        // ... add other navigations properties ...
      ),
    );
  }

  // Add a copyWith method for updating specific sections of the state
  AppState copyWith(
      {
      NavigationsState? navigations,
     

      // Add other state sections here, e.g., DataState? data, 
      }) {
    return AppState(
        navigations: navigations ?? this.navigations,
       

        // Update other state sections here, etc.
        );
  }
}

// Define similar classes for other sections of your state ( AuthState, etc.)


class NavigationsState {
  final bool? loading;
  Map<String, dynamic>? navigations;
  List<Object>? error;
  List<dynamic>? mobile_default_navigations;

// ... add other Navigation properties ...

  NavigationsState(
      {this.loading,
      this.navigations,
      this.error,
      this.mobile_default_navigations

// ... add other navigatioms properties ...
      });

  factory NavigationsState.initial() {
    return NavigationsState(
        loading: false,
        error: [],
        navigations: {},
        mobile_default_navigations: []

        // ... add other navigations properties ...
        );
  }

  NavigationsState copyWith({
    bool? loading,
    Map<String, dynamic>? navigations, // Updated data type
    List<Object>? error,
    List<dynamic>? mobile_default_navigations,
// ... add parameters for other properties you want to update ...
  }) {
    return NavigationsState(
        loading: loading ?? this.loading,
        navigations: navigations ?? this.navigations,
        error: error ?? this.error,
        mobile_default_navigations:
            mobile_default_navigations ?? this.mobile_default_navigations);
  }
}
