import 'package:etno_app/bloc/blocs.dart';
import 'package:etno_app/store/section.dart';
import 'package:etno_app/widgets/appbar_navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../l10n/l10n.dart';
import '../models/Event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/UserSubscription.dart';
import '../provider/locale_provider.dart';

class CardFormScreen extends StatefulWidget {
  const CardFormScreen({super.key, required this.event, required this.name, required this.mail, required this.phone, required this.reservePrice});

  final Event event;
  final String name;
  final String mail;
  final String phone;
  final double reservePrice;

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<CardFormScreen> {
  final Section section = Section();
  CardFormScreen get props => super.widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => PaymentBloc(),
  child: Scaffold(
      appBar: appBarCustom(AppLocalizations.of(context)!.card_pay_title, Icons.language, () => null),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state){
          CardFormEditController controller = CardFormEditController(
            initialDetails: state.cardFieldInputDetails
          );
          if(state.status == PaymentStatus.initial) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.card_pay_form, style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge),
                  const SizedBox(height: 20.0),
                  CardFormField(controller: controller,
                      style: CardFormStyle(borderColor: Colors.black,
                          backgroundColor: Colors.grey,
                          textColor: Colors.black,
                          placeholderColor: Colors.black)),
                  const SizedBox(height: 10.0),
                  ElevatedButton(onPressed: () { (controller.details.complete) ? context.read<PaymentBloc>().add(
                     PaymentCreateIntent(billingDetails:  BillingDetails(email: props.mail), amount: (props.event.reservePrice! * 100)
                    )
                  ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.no_form_complete)));},
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.red)),
                      child: Text(AppLocalizations.of(context)!.pay, style: const TextStyle(color: Colors.white)))
                ],
              ),
            );
          }
          if (state.status == PaymentStatus.success) {
            FirebaseMessaging.instance.getToken().then((value){
              section.addSubscription('Bolea', props.event.title!, UserSubscription.constructor(value, props.event.title, props.event.seats, props.name, props.mail, props.phone, props.reservePrice, true));
            });
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.is_subscribe,
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 12,
                textColor: Colors.white,
                backgroundColor: Colors.green
            );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.pay_success),
                const SizedBox(
                  height: 10.0,
                  width: double.infinity
                ),
                ElevatedButton(
                    onPressed: (){ context.read<PaymentBloc>().add(PaymentStart()); },
                    child: Text(AppLocalizations.of(context)!.back_form)
                )
              ]
            );
          }
          if (state.status == PaymentStatus.failure) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.fail_subscription,
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 12,
                textColor: Colors.white,
                backgroundColor: Colors.red
            );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(AppLocalizations.of(context)!.pay_fail),
                const SizedBox(
                  height: 10.0,
                  width: double.infinity
                ),
                ElevatedButton(style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)), onPressed: (){ context.read<PaymentBloc>().add(PaymentStart()); }, child: Text(AppLocalizations.of(context)!.try_again))
              ]
            );
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    ),
);
  }
}

class MaterialAppCardForm extends StatelessWidget {
  const MaterialAppCardForm({super.key, required this.event, required this.name, required this.mail, required this.phone, required this.reservePrice});
  final Event event;
  final String name;
  final String mail;
  final String phone;
  final double reservePrice;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => LocaleProvider(),
    builder: (context, child){
      final provider = Provider.of<LocaleProvider>(context);
      return MaterialApp(
        theme: ThemeData(useMaterial3: true),
          locale: provider.locale,
          supportedLocales: L10n.all,
          title: 'Book Form',
          home: CardFormScreen(event: event, name: name, mail: mail, phone: phone, reservePrice: reservePrice),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ]
      );
    },
  );
}