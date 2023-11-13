import 'package:amplify_datastore/amplify_datastore.dart';

class ModelProvider {
  static final List<SchemaBuilder> _schemaBuilders = [
    UserDetailsMain.createSchema,
    // Add other models here if you have more
  ];

  static final Version _schemaVersion = Version(1, 0);

  static Future<void> initialize() async {
    AmplifyDataStore dataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);

    try {
      await dataStore.configureModelProvider(modelProvider: ModelProvider.instance);
      await dataStore.configure(version: _schemaVersion, schemaBuilder: _schemaBuilders);
      print('DataStore initialized');
    } catch (e) {
      print('Error initializing DataStore: $e');
    }
  }

  static final ModelProvider instance = ModelProvider._internal();

  ModelProvider._internal();

  // Define the model class
  // Add other models here if you have more
  static Future<void> configureDataStore() async {
    AmplifyDataStore dataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);

    try {
      await dataStore.configureModelProvider(modelProvider: ModelProvider.instance);
      await dataStore.configure(version: _schemaVersion, schemaBuilder: _schemaBuilders);
      print('DataStore configured');
    } catch (e) {
      print('Error configuring DataStore: $e');
    }
  }
}

// Add other models here if you have more

extension UserDetailsMainSchema on UserDetailsMain {
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField USERNAME = QueryField(fieldName: "userName");

  // Schema definition for UserDetailsMain
  static late final QueryField _$USER_DETAIL_MAIN;
  static late final QueryField _$USER_DETAILS_MAIN_ID;
  static late final QueryField _$USER_DETAILS_MAIN_USERID;
  static late final QueryField _$USER_DETAILS_MAIN_USERNAME;

  static QueryField get USER_DETAIL_MAIN => _$USER_DETAIL_MAIN ??= QueryField(fieldName: "UserDetailsMain");
  static QueryField get ID => _$USER_DETAILS_MAIN_ID ??= QueryField(fieldName: "id");
  static QueryField get USERID => _$USER_DETAILS_MAIN_USERID ??= QueryField(fieldName: "userID");
  static QueryField get USERNAME => _$USER_DETAILS_MAIN_USERNAME ??= QueryField(fieldName: "userName");
}

extension UserDetailsMainBinding on UserDetailsMain {
  static const String tableName = 'UserDetailsMain';

  static const UserDetailsMainSchema schema = UserDetailsMainSchema();
}

