abstract class TodoStates {}

class InitialTodoState extends TodoStates {}

class CreateTodoDatabaseState extends TodoStates {}

class InsertingIntoTodoDatabaseState extends TodoStates {}

class SuccessGettingDataFromDatabaseState extends TodoStates {}
