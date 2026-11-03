import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:http/http.dart' as http;

class container_edit_stless extends StatelessWidget {
  String p_edit_id,
      p_edit_name,
      p_edit_barcode,
      p_edit_unit,
      p_edit_type,
      p_edit_image_path,
      p_edit_amount00,
      p_edit_amount02,
      p_edit_amount04,
      p_edit_amountPD;
  double p_edit_price,
      p_edit_price2,
      p_edit_price3,
      p_edit_price4,
      p_edit_price5,
      p_edit_pricePD,
      p_edit_pricePD2,
      p_edit_pricePD3,
      p_edit_pricePD4,
      p_edit_pricePD5,
      p_edit_priceBML,
      p_edit_priceBML2,
      p_edit_priceBML3,
      p_edit_priceBML4,
      p_edit_priceBML5,
      p_edit_lastavgprice;
  int p_edit_amount, p_edit_hire;

  container_edit_stless(
    this.p_edit_id,
    this.p_edit_name,
    this.p_edit_barcode,
    this.p_edit_unit,
    this.p_edit_type,
    this.p_edit_amount,
    this.p_edit_hire,
    this.p_edit_amount00,
    this.p_edit_amount02,
    this.p_edit_amount04,
    this.p_edit_amountPD,

    this.p_edit_image_path,
    this.p_edit_price,
    this.p_edit_price2,
    this.p_edit_price3,
    this.p_edit_price4,
    this.p_edit_price5,
    this.p_edit_pricePD,
    this.p_edit_pricePD2,
    this.p_edit_pricePD3,
    this.p_edit_pricePD4,
    this.p_edit_pricePD5,
    this.p_edit_priceBML,
    this.p_edit_priceBML2,
    this.p_edit_priceBML3,
    this.p_edit_priceBML4,
    this.p_edit_priceBML5,
    this.p_edit_lastavgprice, {
    super.key,
  });

  List<String> Lst_SelectEditPro = [];
  bool? _HaveImage = true;

  Future checkIfImageExists(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return {
        if (response.statusCode == 200)
          {_HaveImage = true}
        else
          {_HaveImage = false},
      };
    } catch (e) {
      // Handle network errors or other exceptions
      return {_HaveImage = false};
    }
  }

  @override
  Widget build(BuildContext context) {
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

        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Material(
            elevation: 10,
            shape: const CircleBorder(),
            shadowColor: Colors.blue.withOpacity(0.4),
            child: InstaImageViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: p_edit_image_path == ''
                    ? Image(
                        image: Image.asset(
                          "assets/images/NoImage.png",
                          fit: BoxFit.cover,
                        ).image,
                      )
                    : Image(
                        image: Image.network(
                          root_url + p_edit_image_path + "?v=1",
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
                    p_edit_id + ' ' + p_edit_name + ' ' + p_edit_unit,
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
            children: <Widget>[
              Flexible(
                child: Text(
                  "Price  [${NumberFormat("#,###,###.##").format(p_edit_price)}]  [${NumberFormat("#,###,###.##").format(p_edit_price2)}]  [${NumberFormat("#,###,###.##").format(p_edit_price3)}]  [${NumberFormat("#,###,###.##").format(p_edit_price4)}]  [${NumberFormat("#,###,###.##").format(p_edit_price5)}] ",
                  style: const TextStyle(
                    inherit: true,
                    fontSize: 12.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          await checkIfImageExists(root_url + p_edit_image_path);

          Lst_SelectEditPro = [
            p_edit_id,
            p_edit_barcode,
            p_edit_name,
            p_edit_unit,
            p_edit_type,
            p_edit_price.toString(),
            p_edit_price2.toString(),
            p_edit_price3.toString(),
            p_edit_price4.toString(),
            p_edit_price5.toString(),
            p_edit_pricePD.toString(),
            p_edit_pricePD2.toString(),
            p_edit_pricePD3.toString(),
            p_edit_pricePD4.toString(),
            p_edit_pricePD5.toString(),
            p_edit_priceBML.toString(),
            p_edit_priceBML2.toString(),
            p_edit_priceBML3.toString(),
            p_edit_priceBML4.toString(),
            p_edit_priceBML5.toString(),
            p_edit_hire.toString(),
            _HaveImage == true ? root_url + p_edit_image_path + "?v=1" : '',
          ];
          if (Lst_SelectEditPro != null)
            Navigator.pop(context, Lst_SelectEditPro);
        },
      ),
    );
  }
}
