## Shopping UI(BLoC Version)

This project is an example of how to use Bloc and Cubit packages to manage application state in Flutter. The project is a simple e-commerce application that allows users to view a list of shoes and add them to a shopping cart.

The main feature of the application is the use of the Bloc and Cubit patterns to manage the state of the shopping cart. The application uses the `shoe_bloc.dart` file to define a `ShoeBloc` class that manages the state of the shoes in the application.

The `ShoeBloc` class extends the `Bloc` class from the `bloc` package and uses a `ShoeState` class to define the state of the application. The `ShoeState` class defines three states: `ShoeStateLoading`, `ShoeStateLoaded`, and `ShoeStateError`.

The application also uses the `cubit` package to manage the state of the shopping cart. The `cart_cubit.dart` file defines a `CartCubit` class that manages the state of the shopping cart.

The `CartCubit` class extends the `Cubit` class from the `cubit` package and uses a `CartState` class to define the state of the shopping cart. The `CartState` class defines two states: `CartStateEmpty` and `CartStateNotEmpty`.

The application demonstrates how to use Bloc and Cubit to manage application state and how to use `BlocBuilder` and `CubitBuilder` widgets to listen to state changes and update the UI accordingly.

Overall, this project serves as a good starting point for developers who are interested in learning how to use Bloc and Cubit to manage application state in Flutter.
