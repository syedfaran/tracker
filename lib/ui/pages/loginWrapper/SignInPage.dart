import 'package:flutter/material.dart';
import 'package:flutter_app/provider/FirebaseAuthProvider.dart';
import 'package:flutter_app/provider/formProvider/SignInValidationProvider.dart';
import 'package:flutter_app/provider/formProvider/WrapperProvider.dart';
import 'package:flutter_app/ui/appUtil/AppString.dart';
import 'package:flutter_app/ui/appUtil/ScreenUtil.dart';
import 'package:flutter_app/ui/appUtil/ToastNotfier.dart';
import 'package:flutter_app/ui/widgets/CustomElevatedButton.dart';
import 'package:flutter_app/ui/widgets/CustomIconTextButton.dart';
import 'package:flutter_app/ui/widgets/CustomLoader.dart';
import 'package:flutter_app/ui/widgets/TextFieldContainer.dart';
import 'package:provider/provider.dart';

class LoginState extends StatelessWidget {
  const LoginState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authPro = Provider.of<AuthProvider>(context);
    final signInFormPro = Provider.of<SignInFormProvider>(context);
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
            Text(AppString.welcomeScreenTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: AppConfig.of(context).appWidth(10),
                    )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.email,
                    callback: signInFormPro.setEmail),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
                TextFieldContainer(
                    hintText: AppString.password,
                    callback: signInFormPro.setPassword,
                    obscureText: true),
                SizedBox(height: AppConfig.of(context).appHeight(3)),
              ],
            ),
            Column(
              children: [
                RElevatedButton(
                  text: AppString.signIn,
                  onPressed: () {
                    signInFormPro.submit();
                    context.read<AuthProvider>().signInUser(
                        signInFormPro.getEmail.value!,
                        signInFormPro.getPassword.value!);
                  },
                ),
                if (authPro.state == NotifierState.loading)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: const CustomLoader(),
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
                const SizedBox(height: 30),
                RETextButtonIcon(
                  iconData: Icons.create,
                    onPressed: () {
                      context.read<LoginRegisterProvider>().eventToState(LoginEvent.register);
                    },
                    text: AppString.createAccount),
              ],
            )
          ],
        ),
      ),
    );
  }
}
