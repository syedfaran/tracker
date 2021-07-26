import 'package:flutter/material.dart';
import 'package:flutter_app/businessLogic/SignUp_validation_Provider.dart';
import 'package:flutter_app/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/customWidget/textField_container.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';
import 'package:provider/provider.dart';

class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    final formPro = Provider.of<FormProvider>(context);
    final authPro = Provider.of<AuthProvider>(context);
    final GlobalKey<FormFieldState> _key;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05,
          top: size.width * 0.15,
          bottom: size.width * 0.05),
      child: AbsorbPointer(
        absorbing: authPro.state == NotifierState.loading,
        child: ListView(
          children: [
            Text(AppString.welcomeScreenTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: size.width * 0.1,
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                TextFieldContainer(
                  hintText: AppString.email,
                  callback: formPro.setEmail,
                 // controller: emailController,
                ),
                const SizedBox(height: 20),
                TextFieldContainer(
                  hintText: AppString.password,
                  callback: formPro.setPassword,
                  obscureText: true,
                 // controller: passwordController,
                ),
                const SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthProvider>().signInUser(
                        formPro.getEmail.value!, formPro.getPassword.value!);
                  },
                  child: Text(AppString.signIn),
                ),
                if (authPro.state == NotifierState.loading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const CircularProgressIndicator(),
                  ),
                if (authPro.state == NotifierState.loaded)
                  authPro.getUserCredential.fold((failure) {
                    ToastNotifier.showToast(context, failure.message)
                        .then((value) {
                      authPro.setState(NotifierState.initial);
                    });
                    return const SizedBox();
                  }, (success) {
                    // ToastNotifier.showToast(context, AppString.signedInSuccessfully).then((value){});
                    return const SizedBox();
                  }),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    context
                        .read<LoginRegisterProvider>()
                        .eventToState(LoginEvent.register);
                  },
                  child: Text(AppString.signup,
                      style: Theme.of(context).textTheme.bodyText2),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
