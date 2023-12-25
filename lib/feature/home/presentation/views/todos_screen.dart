import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/core/common/widgets.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_bloc.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_events.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_states.dart';
import 'package:gitty/feature/home/presentation/widget/todos_widget.dart';
import 'package:gitty/injection_container.dart';
import 'package:gitty/src/values/colors.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<TodosScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<TodosScreenBloc, TodosScreenStates>(
        builder: (context, state) {
          if (state is TodosInitialState) {
            context.read<TodosScreenBloc>().add(FetchTodosEvent());
          } else if (state is FetchingTodosState) {
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Todos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.instance.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TodosFetchingSuccessfulState) {
            final todos = state.todoEntity!.data;
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Todos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(h: 20),
                    Expanded(
                      child: ListView.separated(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return TodosWidget(
                            completed: todos[index].completed,
                            size: size,
                            title: todos[index].title,
                            todoId: todos[index].id,
                            userId: todos[index].userId,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return verticalSpace(h: 20);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is TodosFetchingFailedState) {
            return SafeArea(
              child: Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Todos",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Try again..",
                          ),
                          verticalSpace(h: 15),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<TodosScreenBloc>()
                                  .add(FetchTodosEvent());
                            },
                            icon: const Icon(
                              FontAwesomeIcons.rotateRight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return emptyContainer();
        },
      ),
    );
  }
}
