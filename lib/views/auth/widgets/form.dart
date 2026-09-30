import 'package:flutter/material.dart';
import 'package:luxora/core/constants/app_colors.dart';
import 'package:luxora/viewmodels/auth_viewmodel.dart';
import 'package:luxora/views/auth/widgets/label.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.formKey,
    required this.idCtrl,
    required this.pwCtrl,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController idCtrl;
  final TextEditingController pwCtrl;
  final VoidCallback onSubmit;

  InputDecoration _decoration(String hint, {Widget? suffix}) {
    OutlineInputBorder border(Color c, [double w = 1.5]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c, width: w),
    );
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: border(AppColors.line),
      focusedBorder: border(AppColors.accent, 2),
      errorBorder: border(AppColors.error),
      focusedErrorBorder: border(AppColors.error, 2),
      errorStyle: const TextStyle(color: AppColors.error, fontSize: 13),
      errorMaxLines: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewmodel>(
      builder: (context, p, child) {
        return Form(
          key: formKey,
          autovalidateMode: p.submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Column(
            key: const ValueKey('form'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sign in to continue.',
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
              const SizedBox(height: 24),

              if (p.banner != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.errorSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    p.banner!,
                    style: const TextStyle(
                      color: AppColors.error,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              const LabelWidget('Email or phone number'),
              TextFormField(
                controller: idCtrl,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.username],
                validator: p.validateId,
                decoration: _decoration('you@example.com or +91 98765 43210'),
              ),
              const SizedBox(height: 18),

              const LabelWidget('Password'),
              TextFormField(
                controller: pwCtrl,
                obscureText: p.obscure,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                validator: p.validatePassword,
                onFieldSubmitted: (_) => onSubmit(),
                decoration: _decoration(
                  'At least 8 characters',
                  suffix: TextButton(
                    onPressed: p.toggleObscure,
                    child: Text(
                      p.obscure ? 'Show' : 'Hide',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: p.loading ? null : onSubmit,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    disabledBackgroundColor: AppColors.accentDisabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (p.loading) ...[
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.onAccent,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        p.loading ? 'Signing in' : 'Log in',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.onAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  'Demo: demo@example.com / Demo@1234',
                  style: TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
