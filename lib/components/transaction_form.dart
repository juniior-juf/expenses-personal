import 'package:expenses/components/adaptive_button.dart';
import 'package:expenses/components/adaptive_data_picker.dart';
import 'package:expenses/components/adaptive_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final amount = _amountController.numberValue ?? 0.0;

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, amount, _selectedDate);
  }

//  _showDatePicker() {
//    showDatePicker(
//      context: context,
//      initialDate: DateTime.now(),
//      firstDate: DateTime(2019),
//      lastDate: DateTime.now(),
//    ).then((date) {
//      if (date == null) return;
//      setState(() {
//        _selectedDate = date;
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptiveTextField(
                label: 'Título',
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptiveTextField(
                label: 'Valor R\$',
                controller: _amountController,
                onSubmitted: (_) => _submitForm(),
                inputType: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptiveDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) => {
                  setState(() {
                    _selectedDate = newDate;
                  })
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptiveButton(
                    label: 'Nova transação',
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
