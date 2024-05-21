import 'package:emarket/views/emarketUI/constants.dart';
import 'package:flutter/material.dart';



class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          // onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
