import 'package:flutter/material.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/pro/form_validation_Provider.dart';
import 'package:flutter_app/pro/loginORregisterbloc.dart';
import 'package:provider/provider.dart';

class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pro = Provider.of<FormProvider>(context);
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
          left: size.width *0.05,
          right: size.width *0.05,
          top: size.width * 0.15,
          bottom: size.width * 0.05),
      child: ListView(
        children: [
          Text(AppString.welcomeScreenTitle,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: size.width * 0.1,
                color: Color(0xff055E9E),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child:
                TextField(
                  onChanged: pro.setEmail,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: AppString.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child:  TextField(
                  onChanged: pro.setPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: AppString.password),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Forgot Password?",
              //   style: Theme.of(context).textTheme.bodyText1,
              // )
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff055E9E),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                onPressed: () => {
                  //firebase login
                  Navigator.pushNamed(
                    context,
                    '/homepage',
                  ),
                },
                child: Center(
                    child: Text(
                      AppString.signIn,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  context.read<LoginRegisterBloc>().changeState.add(LoginEvent.register);
                },
                child: Text(AppString.signup,
                    style: Theme.of(context).textTheme.bodyText2),
              )
            ],
          )
        ],
      ),
    );
  }
}