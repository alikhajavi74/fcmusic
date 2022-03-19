import 'package:fcmusic/intro/bloc/intro_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class PermisionPage extends StatelessWidget {
  const PermisionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("تایید مجوز دسترسی"),
        onPressed: () async {
          await context.read<IntroCubit>().sendRequestAccessStorage();
        },
      ),
    );
  }
}
