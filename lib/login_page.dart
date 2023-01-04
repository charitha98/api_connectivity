import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        leading: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                  child: Text('Login', style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                width: 300,
                height: 100,
                child: Image.network('https://amymhaddad.s3.amazonaws.com/morocco-blue.png'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        onChanged: (value){
                          print(value);
                        },
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Username',
                            hintText: 'Username'
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Password',
                            hintText: 'Password'
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: 200,
                child: ElevatedButton(
                  onPressed: loginButtonClicked,
                  child: const Text('Login', style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  void loginButtonClicked(){
    if(_usernameController.text == 'user' && _passwordController.text == '1234'){
      print('Login Success');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
      );
    }else{
      print("Fail");
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context){
    Widget okButton = ElevatedButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: const Text('Ok')
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Error!'),
      content: const Text('Invalid username and password'),
      actions: [
        okButton
      ],
    );
    
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

}
