import 'package:flutter/material.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/helper/screenUtil.dart';
import 'package:flutter_app/helper/toastNotfier.dart';
import 'package:flutter_app/DataProvider/firebaseAuth_provider.dart';
import 'package:flutter_app/presentation/businessLogic/SignUp_validation_Provider.dart';
import 'package:flutter_app/presentation/businessLogic/loginORregisterbloc.dart';
import 'package:flutter_app/presentation/customWidget/custom_elevatedButton.dart';
import 'package:flutter_app/presentation/customWidget/custom_iconTextButton.dart';
import 'package:flutter_app/presentation/customWidget/textField_container.dart';

import 'package:provider/provider.dart';

class RegisterState extends StatelessWidget {
  const RegisterState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpFromPro = Provider.of<SignUpFormProvider>(context);
    final authPro = Provider.of<AuthProvider>(context);
    print(authPro.state);
    return Container(
      width: AppConfig.of(context).appWidth(100),
      height: AppConfig.of(context).appHeight(100),
      padding: EdgeInsets.only(
        left: AppConfig.of(context).appWidth(5),
        top: AppConfig.of(context).appWidth(15),
        right: AppConfig.of(context).appWidth(5),
        bottom: AppConfig.of(context).appWidth(5),
      ),
      child: AbsorbPointer(
        absorbing: authPro.state == NotifierState.loading,
        child: ListView(
          children: [
            Text(AppString.registrationScreenSubTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: AppConfig.of(context).appWidth(10),
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.name,
                    callback: signUpFromPro.setName,
                    errorText: signUpFromPro.getName.error),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.email,
                    callback: signUpFromPro.setEmail,
                    errorText: signUpFromPro.getEmail.error),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.password,
                    callback: signUpFromPro.setPassword,
                    errorText: signUpFromPro.getPassword.error,
                    obscureText: true),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.confirmPassword,
                    callback: signUpFromPro.setConfirmPassword,
                    errorText: signUpFromPro.getConfirmPassword.error,
                    obscureText: true),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
              ],
            ),
            Column(
              children: [
                RElevatedButton(
                  onPressed: () {
                    context.read<AuthProvider>().createUser(
                        signUpFromPro.getEmail.value!,
                        signUpFromPro.getPassword.value!,
                        signUpFromPro.getName.value!);
                  },
                  text: AppString.createAccount,
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
                    return SizedBox();
                  }, (success) => const Text(AppString.registerSuccessfully)),
                const SizedBox(height: 30),
                RETextButtonIcon(
                    onPressed: () {
                      signUpFromPro.submit();
                      context
                          .read<LoginRegisterProvider>()
                          .eventToState(LoginEvent.login);
                    },
                    text: AppString.backToLoginPage,
                    iconData: Icons.arrow_back_ios_outlined),
              ],
            )
          ],
        ),
      ),
    );
  }
}
