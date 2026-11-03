import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class container_stless extends StatelessWidget {
  String p_id_name,
      p_unit,
      p_image_path,
      p_amount00,
      p_amount02,
      p_amount04,
      p_amountPD;

  double p_price, p_price2, p_price3, p_price4, p_price5, p_lastavgprice;
  int p_amount;

  container_stless(
    this.p_id_name,
    this.p_unit,
    this.p_amount,
    this.p_amount00,
    this.p_amount02,

    this.p_amount04,
    this.p_amountPD,

    this.p_image_path,
    this.p_price,
    this.p_price2,
    this.p_price3,
    this.p_price4,
    this.p_price5,
    this.p_lastavgprice, {
    super.key,
  });

  late String p_amount00_pad = p_amount00.padLeft(4, ' ');
  late String p_amount02_pad = p_amount02.padLeft(4, ' ');
  late String p_amount04_pad = p_amount04.padLeft(4, ' ');
  late String p_amountPD_pad = p_amountPD.padLeft(4, ' ');

  Widget _TextAuthorizePrice() {
    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      return Text(
        " Price [${NumberFormat("#,###,###.##").format(p_price)}] [${NumberFormat("#,###,###.##").format(p_price2)}] [${NumberFormat("#,###,###.##").format(p_price3)}] [${NumberFormat("#,###,###.##").format(p_price4)}] [${NumberFormat("#,###,###.##").format(p_price5)}] \nCost [${NumberFormat("#,###,###.##").format(p_lastavgprice)}] ",
        style: const TextStyle(
          inherit: true,
          fontSize: 12.0,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        " Price [${NumberFormat("#,###,###.##").format(p_price)}] [${NumberFormat("#,###,###.##").format(p_price2)}] [${NumberFormat("#,###,###.##").format(p_price3)}] [${NumberFormat("#,###,###.##").format(p_price4)}] [${NumberFormat("#,###,###.##").format(p_price5)}] ",
        style: const TextStyle(
          inherit: true,
          fontSize: 12.0,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  String _StrAmount = '';

  Widget _TextAuthorizeAmount() {
    if (glo_branchstock == '00') {
      _StrAmount = p_amount00;
    } else if (glo_branchstock == '02') {
      _StrAmount = p_amount02;
    } else if (glo_branchstock == '04') {
      _StrAmount = p_amount04;
    } else if (glo_branchstock == 'PD') {
      _StrAmount = p_amountPD;
    }

    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      return Text(
        "$p_amount $p_unit",
        style: const TextStyle(
          inherit: true,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      );
    } else {
      return Text(
        "$_StrAmount $p_unit",
        style: const TextStyle(
          inherit: true,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Uint8List imageData = base64Decode(p_image);
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
        trailing: _TextAuthorizeAmount(),
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
            children: <Widget>[Flexible(child: _TextAuthorizePrice())],
          ),
        ),
        onTap: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "\n00 = $p_amount00_pad\n" +
                      "02 = $p_amount02_pad\n" +
                      "04 = $p_amount04_pad\n" +
                      "PD = $p_amountPD_pad\n" +
                      "\nTotal = $p_amount",
                ),

                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
