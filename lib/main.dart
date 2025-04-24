import 'package:flutter/material.dart';
import 'app/config/injection/di.dart';
import 'app/newspaper_app.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const NewspaperApp());
}

