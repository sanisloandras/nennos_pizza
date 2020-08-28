import 'package:bloc/bloc.dart';
import 'package:nennos_pizza/domain/interactor/load_pizza_list_interactor.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_events.dart';
import 'package:nennos_pizza/presentation/pizza_list/pizza_list_state.dart';

class PizzaListBloc extends Bloc<PizzaListEvent, PizzaListState> {
  final LoadPizzaListInteractor _loadPizzaListInteractor;

  PizzaListBloc(this._loadPizzaListInteractor) : super(PizzaListLoading());

  @override
  Stream<PizzaListState> mapEventToState(PizzaListEvent event) async* {
    if (event is PizzasRequested) {
      try {
        var pizzaList = await _loadPizzaListInteractor.invoke();
        yield PizzaListLoaded(pizzaList);
      } catch (_) {
        yield PizzaListFailure();
      }
    }
  }
}
