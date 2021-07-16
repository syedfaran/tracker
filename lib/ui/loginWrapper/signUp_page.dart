import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/form_validation_Provider.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/customWidget/textField_container.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';

class RegisterState extends StatelessWidget {
  const RegisterState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pro = Provider.of<FormProvider>(context);
    final proT = Provider.of<AuthProvider>(context);
    print(proT.state);
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.width * 0.15,
          bottom: size.width * 0.05),
      child: AbsorbPointer(
        absorbing: proT.state == NotifierState.loading,
        child: ListView(
          children: [
            Text(AppString.registrationScreenSubTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                      color: Color(0xff055E9E),
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.name,callback: pro.setName,errorText: pro.getName.error),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.email,callback: pro.setEmail,errorText: pro.getEmail.error),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.password,callback: pro.setPassword,errorText: pro.getPassword.error,obscureText: true),
                const SizedBox(height: 20),
                TextFieldContainer(hintText: AppString.confirmPassword,callback: pro.setConfirmPassword,errorText: pro.getConfirmPassword.error,obscureText: true),
                const SizedBox(height: 20),
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
                  onPressed: ()async{
                    context.read<AuthProvider>().createUser(pro.getEmail.value!, pro.getPassword.value!,pro.getName.value!);


                  },
                  child: Center(
                      child: Text(
                    AppString.signup,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
                ),
                if (proT.state == NotifierState.loading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const CircularProgressIndicator(),
                  ),
                if (proT.state == NotifierState.loaded)
                  proT.getUserCredential.fold(
                      (failure) {
                        ToastNotifier.showToast(context, failure.message).then((value) {
                          proT.setState(NotifierState.initial);
                        });
                        return SizedBox();
                      },
                      (success) => const Text(AppString.registerSuccessfully)),
                SizedBox(
                  height: 30,
                ),
                TextButton.icon(
                    onPressed: () {
                      pro.submit();
                      context
                          .read<LoginRegisterBloc>()
                          .changeState
                          .add(LoginEvent.login);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    label: Text(
                      'Back To LoginPage',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
