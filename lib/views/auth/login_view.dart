import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/viewmodels/auth_viewmodel.dart';
import 'package:luxora/views/auth/widgets/form.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _idCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  @override
  void dispose() {
    _idCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AuthViewmodel, bool>(
      selector: (_, p1) => p1.success,
      builder: (context, success, child) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) =>
              context.read<AuthViewmodel>().navigateToHome(context, success),
        );
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 40,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: FormWidget(
                      formKey: _formKey,
                      idCtrl: _idCtrl,
                      pwCtrl: _pwCtrl,
                      onSubmit: () async {
                        await context.read<AuthViewmodel>().submit(
                          _formKey,
                          _idCtrl,
                          _pwCtrl,
                          context,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

