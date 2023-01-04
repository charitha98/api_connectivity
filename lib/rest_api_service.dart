import 'dart:convert';
import 'package:login_page/user.dart';
import 'package:http/http.dart' as http;

class RestApiServices {

  String apiUrl = 'https://mocki.io/v1/ed0c6388-7a27-4c27-942b-f1b6b358178e';

  //Future method to get all users from API url.. (response or error)
  Future<List<User>> getUsers() async {

    final response = await http.get(Uri.parse(apiUrl));
    print(response.body);

    //Checking the response using the status code
    if (response.statusCode == 200) {
      return getUsersList(response.body);
    }
    else {
      return throw Exception('Unable to fetch data');
    }
  }

  //Convert response body to user object list
  List<User> getUsersList(String responseBody){
    final parseBody = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parseBody.map<User>((json) => User.fromJson(json)).toList();
  }

}

