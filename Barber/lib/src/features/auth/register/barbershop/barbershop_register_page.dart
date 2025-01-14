import 'package:barber/src/core/ui/helpers/form_herlpers.dart';
import 'package:barber/src/core/ui/helpers/messages.dart';
import 'package:barber/src/core/ui/widgets/hours_panel.dart';
import 'package:barber/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barber/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barber/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:barber/src/rotas/rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVm =
        ref.watch(barbershopRegisterVmProvider.notifier);
    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
          Messages.showError(
              'Desculpe ocurreu um erro ao registrar barbearia', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Rotas.adm, (route) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar establecimiento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatorio'),
                  onTapOutside: (_) => context.unfocus,
                  decoration: const InputDecoration(label: Text('Nome')),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required("E-mail obrigatorio"),
                      Validatorless.email("E-mail inválido")
                    ],
                  ),
                  onTapOutside: (_) => context.unfocus,
                  decoration: const InputDecoration(label: Text('E-mail')),
                ),
                const SizedBox(
                  height: 24,
                ),
                //----------------------------------------------------------------
                // const SizedBox(
                //   height: 94,
                //   child: Placeholder(),
                // ),
                WeekdaysPanel(
                  onDaysPressed: (value) {
                    barbershopRegisterVm.addOrRemoveOpenDay(value);
                  },
                ),
                //----------------------------------------------------------------
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) {
                    barbershopRegisterVm.addOrRemoveOpenHour(value);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        barbershopRegisterVm.register(
                            nameEC.text, emailEC.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  child: const Text('Cadastrar establecimento'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
