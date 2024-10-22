import 'package:flutter/material.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar conta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('E-mail'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Senha'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Confirmar senha'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.065),
                  ),
                  onPressed: () {},
                  child: Text('Criar Conta'))
            ],
          ),
        ),
      ),
    );
  }
}
