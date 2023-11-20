import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;

class Todo extends amplify_core.Model {
  static const classType = _TodoModelType();
  final String id;
  final String? _email;
  final String? _username;
  final String? _phoneNumber;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
    '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.',
  )
  @override
  String getId() => id;

  @override
  TodoModelIdentifier get modelIdentifier {
    return TodoModelIdentifier(id: id);
  }

  String get email {
    try {
      return _email!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
        amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String get username {
    try {
      return _username!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
        amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  String get phoneNumber {
    try {
      return _phoneNumber!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
        amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastExceptionMessage,
        recoverySuggestion: amplify_core.AmplifyExceptionMessages
            .codeGenRequiredFieldForceCastRecoverySuggestion,
        underlyingException: e.toString(),
      );
    }
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const Todo._internal({
    required this.id,
    required email,
    required username,
    required phoneNumber,
    createdAt,
    updatedAt,
  })  : _email = email,
        _username = username,
        _phoneNumber = phoneNumber,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory Todo({
    String? id,
    required String email,
    required String username,
    required String phoneNumber,
  }) {
    return Todo._internal(
      id: id ?? amplify_core.UUID.getUUID(),
      email: email,
      username: username,
      phoneNumber: phoneNumber,
    );
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
        id == other.id &&
        _email == other._email &&
        _username == other._username &&
        _phoneNumber == other._phoneNumber;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = StringBuffer();

    buffer.write("Todo {");
    buffer.write("id=$id, ");
    buffer.write("email=$_email, ");
    buffer.write("username=$_username, ");
    buffer.write("phoneNumber=$_phoneNumber, ");
    buffer.write(
        "createdAt=${_createdAt != null ? _createdAt!.format() : "null"}, ");
    buffer.write(
        "updatedAt=${_updatedAt != null ? _updatedAt!.format() : "null"}");
    buffer.write("}");

    return buffer.toString();
  }

  Todo copyWith({
    String? email,
    String? username,
    String? phoneNumber,
  }) {
    return Todo._internal(
      id: id,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Todo copyWithModelFieldValues({
    ModelFieldValue<String>? email,
    ModelFieldValue<String>? username,
    ModelFieldValue<String>? phoneNumber,
  }) {
    return Todo._internal(
      id: id,
      email: email == null ? this.email : email.value,
      username: username == null ? this.username : username.value,
      phoneNumber: phoneNumber == null ? this.phoneNumber : phoneNumber.value,
    );
  }

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _email = json['email'],
        _username = json['username'],
        _phoneNumber = json['phoneNumber'],
        _createdAt = json['createdAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': _email,
        'username': _username,
        'phoneNumber': _phoneNumber,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
      };

  @override
  Map<String, Object?> toMap() => {
        'id': id,
        'email': _email,
        'username': _username,
        'phoneNumber': _phoneNumber,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      };

  static const amplify_core.QueryModelIdentifier<TodoModelIdentifier>
      MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<TodoModelIdentifier>();
  static const ID = amplify_core.QueryField(fieldName: "id");
  static const EMAIL = amplify_core.QueryField(fieldName: "email");
  static const USERNAME = amplify_core.QueryField(fieldName: "username");
  static const PHONENUMBER = amplify_core.QueryField(fieldName: "phoneNumber");
  static var schema = amplify_core.Model.defineSchema(
    define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
      modelSchemaDefinition.name = "User";
      modelSchemaDefinition.pluralName = "Users";

      modelSchemaDefinition.authRules = [
        const amplify_core.AuthRule(
          authStrategy: amplify_core.AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: amplify_core.AuthRuleProvider.USERPOOLS,
          operations: [
            amplify_core.ModelOperation.CREATE,
            amplify_core.ModelOperation.READ,
            amplify_core.ModelOperation.UPDATE,
            amplify_core.ModelOperation.DELETE,
          ],
        ),
        const amplify_core.AuthRule(
          authStrategy: amplify_core.AuthStrategy.GROUPS,
          groupClaim: "cognito:groups",
          groups: ["admin"],
          provider: amplify_core.AuthRuleProvider.USERPOOLS,
          operations: [
            amplify_core.ModelOperation.CREATE,
            amplify_core.ModelOperation.READ,
            amplify_core.ModelOperation.UPDATE,
            amplify_core.ModelOperation.DELETE,
          ],
        ),
      ];

      modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.field(
          key: Todo.EMAIL,
          isRequired: true,
          ofType: const amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.field(
          key: Todo.USERNAME,
          isRequired: true,
          ofType: const amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.field(
          key: Todo.PHONENUMBER,
          isRequired: true,
          ofType: const amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
          fieldName: 'createdAt',
          isRequired: false,
          isReadOnly: true,
          ofType: const amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.dateTime,
          ),
        ),
      );

      modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
          fieldName: 'updatedAt',
          isRequired: false,
          isReadOnly: true,
          ofType: const amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.dateTime,
          ),
        ),
      );
    },
  );
}

class _TodoModelType extends amplify_core.ModelType<Todo> {
  const _TodoModelType();

  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'User';
  }
}

class TodoModelIdentifier implements amplify_core.ModelIdentifier<Todo> {
  final String id;

  const TodoModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => <String, dynamic>{'id': id};

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => <String, dynamic>{entry.key: entry.value})
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'UserModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is TodoModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
