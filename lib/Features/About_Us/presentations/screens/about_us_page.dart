import 'package:flutter/material.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/gen/assets.gen.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Features/About_Us/widgets/widget_us.dart';

class AboutUs extends StatelessWidget {
  static String rn = "/aboutus";
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CommonAppbar.appBar(context),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: EsaySize.width(context) * 0.92,
              height: EsaySize.height(context) * 0.75,
              decoration: BoxDecoration(
                  color: ConstColor.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  EsaySize.gap(40),
                  SizedBox(
                      width: EsaySize.width(context) * 0.6,
                      child: Assets.images.logo.image()),
                  EsaySize.gap(20),
                  EsaySize.gap(20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      textAlign: TextAlign.justify,
                      "تعود مرجعية ومدرسة الإمام الخالصي إلى بداية القرن العشرين، حيث أسس الامام المجاهد الشيخ محمد مهدي بن محمد حسين بن عزيز الخالصي (قدس) سنة 1330هـ / 1911م، مدرسة كبيرة في مدينة الكاظمية المقدسة، أسماها المدرسة الزهراء، تدرّس فيها العلوم الفقهية والدينية على منهج علمي يتبع مبدأ الحداثة لإجراء تغيير جذري في التعليم الديني والفقهي، ولتكون جامعة علمية دينية؛ يتخرّج منها علماء ‌يَجمعون بين العلوم الدينية والعلوم الحديثة، وتُعرف اليوم بإسم مدرسة الإمام الخالصي الكبير نسبةً له. كما تتبنى مدرسة الإمام الخالصي نهجاً سياسياً شرعياً يقوم على مبدأ عدم فصل الدين على السياسة، ومبدأ استقلال البلاد الإسلامية، وتحكيم الشريعة الإسلامية في حياة الأمة، والحفاظ على هوية العراق الإسلامية والوطنية.",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Btn.allbtn(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
