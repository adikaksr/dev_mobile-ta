import 'package:easkripsi/ui/widgets/custom_button.dart';
import 'package:easkripsi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class SecondFormPage extends StatelessWidget {
  const SecondFormPage({Key? key}) : super(key: key);

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              "Form",
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                title: "Indeks Prestasi Kumulatif",
                hintText: 'Indeks Prestasi Kumulatif Anda',
              ),
              CustomTextFormField(
                title: "Jumlah SKS Lulus",
                hintText: 'Jumlah SKS Lulus Anda',
              ),
              CustomTextFormField(
                title: "Jumlah SKS Nilai D",
                hintText: 'Jumlah SKS Nilai D Anda',
              ),
              CustomTextFormField(
                title: "Bidang Minat",
                hintText: 'Bidang Minat Anda',
              ),
              CustomButton(
                  title: "Selanjutnya",
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    // Navigate to the next page
                  }
                  // },
                  ),
              SizedBox(height: 20),
              CustomButton(
                title: "Kembali",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
