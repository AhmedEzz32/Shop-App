import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/shop_app/shop_layout.dart';
import 'package:project1/modules/shop_app/login/cubit/cubit.dart';
import 'package:project1/modules/shop_app/login/cubit/states.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/network/local/cashe_helper.dart';
import '../../../shared/components/constants.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);

              CasheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value)
              {
                token = state.loginModel.data!.token!;
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login.jpg'),
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  //3shan error aly bygy lma bft7 keyboard
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DefaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[200],
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DefaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              onSubmit:
                                  (value) //da 3shan lma ados sah ydkhol 3ltool mn 8eer ma ados login
                                  {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'password is to short';
                                }
                              },
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              label: 'password',
                              prefix: Icons.lock_outlined,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (BuildContext context) => DefaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                            ),
                            fallback: (BuildContext context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               const Text('Don\'t have an account?',
                               style: TextStyle(
                                 color: Colors.white,
                               ),
                               ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(
                                    context,
                                     ShopRegisterScreen(),
                                  );
                                },
                                text: 'register',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
