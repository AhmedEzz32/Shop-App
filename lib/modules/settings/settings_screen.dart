import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/shop_app/cubit/cubit.dart';
import 'package:project1/layout/shop_app/cubit/states.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
var formkey = GlobalKey<FormState>();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();

@override
Widget build(BuildContext context) {
  return BlocConsumer<ShopCubit, ShopStates>(
    listener: (BuildContext context, state) {},
    builder: (BuildContext context, Object? state) {
      dynamic model = ShopCubit.get(context).userModel;

      if (model?.data != null) {
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
      }

      return Center(
        child: SingleChildScrollView(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      function: () {
                        if (formkey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'LogOut',
                    ),
                  ],
                ),
              ),
            ),
            fallback: (BuildContext context) =>
            const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    },
  );
}
}