import 'package:ai_text_to_image/feature/prompt/ui/create_prompt_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.grey.shade900, elevation: 0),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900),
      home: CreatePromptScreen(),
    );
  }
}

