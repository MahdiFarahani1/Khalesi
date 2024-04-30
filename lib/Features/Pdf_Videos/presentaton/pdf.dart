import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:khalesi/Core/const/const_Color.dart';
import 'package:khalesi/Core/const/const_link.dart';
import 'package:khalesi/Core/utils/esay_size.dart';
import 'package:khalesi/Core/utils/loading.dart';
import 'package:khalesi/Core/widgets/appbar.dart';
import 'package:khalesi/Core/widgets/drawer.dart';
import 'package:khalesi/Core/widgets/navbar.dart';
import 'package:khalesi/Features/Pdf_Videos/data/model/model.dart';
import 'package:khalesi/Features/Pdf_Videos/data/source/fetch-data.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PdfPage extends StatefulWidget {
  static const rn = "/pdfpage";
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  final PagingController<int, PdfModel> pagingController1 =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    DataPdfSource.fetchData(
        start: 0, pagingController1: pagingController1, context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CommonAppbar.appBar(context),
          bottomNavigationBar: CommonNavbar.botNav(),
          drawer: CommonDrawer.drawer(context),
          body: PagedListView<int, PdfModel>(
            pagingController: pagingController1,
            builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder: (context) {
                return CostumLoading.fadingCircle(context);
              },
              itemBuilder: (context, item, index) {
                return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200),
                      width: EsaySize.width(context),
                      height: EsaySize.height(context) * 0.2,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: EsaySize.width(context) * 0.24,
                                height: EsaySize.height(context) * 0.175,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${ConstLink.imgBaselow}${item.img}",
                                  placeholder: (context, url) {
                                    return CostumLoading.loadCircle(context);
                                  },
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: EsaySize.width(context) * 0.29,
                                left: 8,
                                top: 10),
                            child: Text(
                              item.title!,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: EsaySize.width(context) * 0.29,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.dateTime!,
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                  InkResponse(
                                    onTap: () async {
                                      if (item.pdf == null) {
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.info(
                                              backgroundColor: ConstColor.blue,
                                              message: "الملف غير متوفر"),
                                        );
                                      } else {
                                        FileDownloader.downloadFile(
                                          notificationType:
                                              NotificationType.all,
                                          url:
                                              "${ConstLink.imgBasehigh}${item.pdf}",
                                          name: "${item.id}",
                                          onDownloadCompleted: (String path) {
                                            OpenFile.open(path);
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.yellow.shade200,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: const Offset(3, -3),
                                            ),
                                          ],
                                          color: ConstColor.yellow,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(8))),
                                      width: 35,
                                      height: 35,
                                      child: const Icon(
                                        FontAwesomeIcons.download,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
              },
            ),
          ),
        ));
  }
}
