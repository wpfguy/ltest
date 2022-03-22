import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Processing...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
