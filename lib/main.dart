import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'repositories/repositories.dart';
import 'screens/home.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final CourtRepository courtRepository = CourtRepository(
    courtApiClient: CourtApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App(courtRepository: courtRepository));
}

class App extends StatelessWidget {
  final CourtRepository courtRepository;

  App({Key key, @required this.courtRepository})
      : assert(courtRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: routes(),
        theme: ThemeData(
          primaryColor: Colors.indigo[300],
        ),
        home: MultiBlocProvider(providers: [
          BlocProvider<LocationBloc>(
            builder: (BuildContext context) => LocationBloc(),
          ),
          BlocProvider<CourtBloc>(
            builder: (BuildContext context) =>
                CourtBloc(courtRepository: courtRepository),
          )
        ], child: Home()));
  }
}
