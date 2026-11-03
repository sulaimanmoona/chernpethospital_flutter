import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class container_count_stless extends StatelessWidget {
  String p_id_name,
      p_unit,
      p_image_path,
      p_amount00,
      p_amount01,
      p_amount02,
      p_amount04,
      p_amount05,
      p_amount07,
      p_amount08,
      p_amount09,
      p_amount10,
      p_amount11,
      p_amount12,
      p_amount13,
      p_amount14,
      p_amount15,
      p_amount20,
      p_amount21,
      p_amount24,
      p_amount26,
      p_amount27,
      p_amount28,
      p_amount29,
      p_amount30,
      p_amount31,
      p_amount32,
      p_amount33,
      p_amount34,
      p_amount35,
      p_amount36,
      p_amount37,
      p_amount38,
      p_amount39,
      p_amount40,
      p_amount41,
      p_amount42;
  double p_price, p_price5;
  int p_amount;

  container_count_stless(
    this.p_id_name,
    this.p_unit,
    this.p_amount,
    this.p_amount00,
    this.p_amount01,
    this.p_amount02,

    this.p_amount04,
    this.p_amount05,

    this.p_amount07,
    this.p_amount08,
    this.p_amount09,
    this.p_amount10,
    this.p_amount11,
    this.p_amount12,
    this.p_amount13,
    this.p_amount14,
    this.p_amount15,

    this.p_amount20,
    this.p_amount21,

    this.p_amount24,

    this.p_amount26,
    this.p_amount27,
    this.p_amount28,
    this.p_amount29,
    this.p_amount30,
    this.p_amount31,
    this.p_amount32,
    this.p_amount33,
    this.p_amount34,
    this.p_amount35,
    this.p_amount36,
    this.p_amount37,
    this.p_amount38,
    this.p_amount39,
    this.p_amount40,
    this.p_amount41,
    this.p_amount42,

    this.p_image_path,
    this.p_price,
    this.p_price5, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List Lst_pickpro = [];
    String branch_amount = '';
    if (glo_branchstock == '00') {
      branch_amount = p_amount00;
    } else if (glo_branchstock == '01') {
      branch_amount = p_amount01;
    } else if (glo_branchstock == '02') {
      branch_amount = p_amount02;
    } else if (glo_branchstock == '04') {
      branch_amount = p_amount04;
    } else if (glo_branchstock == '05') {
      branch_amount = p_amount05;
    } else if (glo_branchstock == '07') {
      branch_amount = p_amount07;
    } else if (glo_branchstock == '08') {
      branch_amount = p_amount08;
    } else if (glo_branchstock == '09') {
      branch_amount = p_amount09;
    } else if (glo_branchstock == '10') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '11') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '12') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '13') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '14') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '15') {
      branch_amount = p_amount10;
    } else if (glo_branchstock == '20') {
      branch_amount = p_amount20;
    } else if (glo_branchstock == '21') {
      branch_amount = p_amount21;
    } else if (glo_branchstock == '24') {
      branch_amount = p_amount24;
    } else if (glo_branchstock == '26') {
      branch_amount = p_amount26;
    } else if (glo_branchstock == '27') {
      branch_amount = p_amount27;
    } else if (glo_branchstock == '28') {
      branch_amount = p_amount28;
    } else if (glo_branchstock == '29') {
      branch_amount = p_amount29;
    } else if (glo_branchstock == '30') {
      branch_amount = p_amount30;
    } else if (glo_branchstock == '31') {
      branch_amount = p_amount31;
    } else if (glo_branchstock == '32') {
      branch_amount = p_amount32;
    } else if (glo_branchstock == '33') {
      branch_amount = p_amount33;
    } else if (glo_branchstock == '34') {
      branch_amount = p_amount34;
    } else if (glo_branchstock == '35') {
      branch_amount = p_amount35;
    } else if (glo_branchstock == '36') {
      branch_amount = p_amount36;
    } else if (glo_branchstock == '37') {
      branch_amount = p_amount37;
    } else if (glo_branchstock == '38') {
      branch_amount = p_amount38;
    } else if (glo_branchstock == '39') {
      branch_amount = p_amount39;
    } else if (glo_branchstock == '40') {
      branch_amount = p_amount40;
    } else if (glo_branchstock == '41') {
      branch_amount = p_amount41;
    } else if (glo_branchstock == '42') {
      branch_amount = p_amount42;
    }

    Lst_pickpro = [p_id_name, branch_amount];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        shape: BoxShape.rectangle,
        border: Border.all(
          width: 1,
          color: Colors.blueAccent,
          style: BorderStyle.solid,
        ),
      ),
      //    padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        dense: true,
        trailing: Text(
          "$branch_amount $p_unit",
          style: const TextStyle(
            inherit: true,
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Material(
            elevation: 10,
            shape: const CircleBorder(),
            shadowColor: Colors.blue.withOpacity(0.4),
            child: InstaImageViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: p_image_path == ''
                    ? Image(
                        image: Image.asset(
                          "assets/images/NoImage.png",
                          fit: BoxFit.cover,
                        ).image,
                      )
                    : Image(
                        image: Image.network(
                          root_url + p_image_path + "?v=1",
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ).image,
                        errorBuilder:
                            (
                              BuildContext context,
                              Object exception,
                              StackTrace? stackTrace,
                            ) {
                              return Image.asset("assets/images/NoImage.png");
                            },
                      ),
              ),
            ),
          ),
        ),
        //   visualDensity: VisualDensity(vertical: -2),
        title: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Text(
                    p_id_name,
                    style: const TextStyle(
                      inherit: true,
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
