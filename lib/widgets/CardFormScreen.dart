import 'package:etno_app/bloc/blocs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CardFormScreen extends StatefulWidget {
  const CardFormScreen({super.key, required this.reservePrice});

  final double reservePrice;
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}
class PageState extends State<CardFormScreen> {

  CardFormScreen get props => super.widget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => PaymentBloc(),
  child: Scaffold(
      appBar: AppBar(
        title: const Text('Pagar con tarjeta de credito'),
      ),
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
                  Text('Formulario de tarjeta', style: Theme
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
                     PaymentCreateIntent(billingDetails: const BillingDetails(email: 'marcobenegasdev@gmail.com'), amount: (props.reservePrice * 100)
                    )
                  ) : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No esta completo el formulario')));},
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.red)),
                      child: const Text('Pagar'))
                ],
              ),
            );
          }
          if (state.status == PaymentStatus.success) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('The payment is succesful'),
                const SizedBox(
                  height: 10.0,
                  width: double.infinity
                ),
                ElevatedButton(
                    onPressed: (){ context.read<PaymentBloc>().add(PaymentStart()); },
                    child: const Text('Back to Home')
                )
              ]
            );
          }
          if (state.status == PaymentStatus.failure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text('The payment failed'),
                const SizedBox(
                  height: 10.0,
                  width: double.infinity
                ),
                ElevatedButton(onPressed: (){ context.read()<PaymentBloc>().add(PaymentStart()); }, child: const Text('Try again'))
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