import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';

class DataOrtu extends StatelessWidget {
  const DataOrtu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kGreyColor),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Viverra aliquet",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nama Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Urna hendrerit",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Alamat Orangtua",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Banda Aceh",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status Hidup Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Hidup",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status Hidup Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Hidup",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pendidikan Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "S1-Sarjana",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pendidikan Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "S2-Magister",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor HP Ayah",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "082210101010",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor HP Ibu",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "082210101010",
                      style: TextStyle(
                        color: kBlackColor,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: kGreyColor,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nomor HP Wali",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Text(
                        "082210101010",
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: kBlackColor,
                          fontFamily: 'Public Sans',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
