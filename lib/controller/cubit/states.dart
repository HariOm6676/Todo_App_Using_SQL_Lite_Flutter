abstract class TodoStates {}

class InitialTodoState extends TodoStates {}

class CreateTodoDatabaseState extends TodoStates {}

class InsertingIntoTodoDatabaseState extends TodoStates {}

class SuccessGettingDataFromDatabaseState extends TodoStates {}

class LoadingGetDataFromDatabase extends TodoStates {}

class ChangeLanguageToArabicState extends TodoStates {}

class ChangeLanguageToEnglishState extends TodoStates {}

class ChangeAppModeState extends TodoStates{}
