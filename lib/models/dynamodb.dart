import 'package:amplify_flutter/amplify_flutter.dart';
import 'User.dart';

class DynamoDBService {
  // Create a new user in DynamoDB
  static Future<void> createUser(User user) async {
    try {
      await Amplify.DataStore.save(user);
      print('User created successfully: ${user.toString()}');
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  // Update an existing user in DynamoDB
  static Future<void> updateUser(User updatedUser) async {
    try {
      final existingUser = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(updatedUser.id),
      );

      if (existingUser.isNotEmpty) {
        await Amplify.DataStore.save(updatedUser);
        print('User updated successfully: ${updatedUser.toString()}');
      } else {
        print('User not found for update');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Delete a user from DynamoDB
  static Future<void> deleteUser(String userId) async {
    try {
      final userToDelete = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );

      if (userToDelete.isNotEmpty) {
        await Amplify.DataStore.delete(userToDelete[0]);
        print('User deleted successfully');
      } else {
        print('User not found for deletion');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
