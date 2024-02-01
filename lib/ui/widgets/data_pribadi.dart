import 'package:easkripsi/shared/theme.dart';
import 'package:flutter/material.dart';

class DataPribadi extends StatelessWidget {
  const DataPribadi({Key? key}) : super(key: key);

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
                      "NPM",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "1808107010056",
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
                      "Telepon",
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
                      "Jenis Kelamin",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Laki-Laki",
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
                      "Tempat Lahir",
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
                      "Tanggal Lahir",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "1 Januari 2000",
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
                      "Agama",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Public Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Islam",
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
                      "Alamat Sekarang",
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
                        "Desa Blang Krueng",
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
