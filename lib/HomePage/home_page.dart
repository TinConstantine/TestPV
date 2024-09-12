import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/map_app_icon.dart';
import 'package:map_app/model/auto_suggest_address.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageViewmodel _homePageViewmodel = HomePageViewmodel();
  TextEditingController _searchController = TextEditingController();
  Position? position;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageViewmodel.determinePosition().then((value) {
      if (value == null) exit(0);
      setState(() {
        position = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _homePageViewmodel,
      child: Consumer<HomePageViewmodel>(
        builder: (BuildContext context, HomePageViewmodel homePageViewmodel,
            Widget? child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SearchBar(
                    trailing: [
                      if(_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.close, size: 24,),
                          onPressed: () => homePageViewmodel.clear(_searchController),
                        )

                    ],
                    hintText: "Enter keyword",
                    leading: homePageViewmodel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Icon(Icons.search),
                    controller: _searchController,
                    onChanged: (value) async {
                      homePageViewmodel.queryResult(value.trim(), position);
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _searchController.text.trim().isNotEmpty
                        ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: homePageViewmodel
                              .autoSuggestAddress()
                              .items
                              .length,
                          itemBuilder: (context, index) {
                            final item = homePageViewmodel
                                .autoSuggestAddress()
                                .items[index];
                            return _item(item);
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                        )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _item(Item item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 24,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: RichText(
              text: makeHighlightText(
                  item.title ?? "", _searchController.text)),
        ),
        const SizedBox(
          width: 12,
        ),
        IconButton(
            onPressed: () async {
              final googleMapsUrl =
                  'https://www.google.com/maps/dir/?api=1&destination=${item.position?.lat ?? 0},${item.position?.lng ?? 0}';
              try {
                await launchUrl(
                  Uri.parse(googleMapsUrl),
                );
              } catch (e) {
                print("Error: $e");
              }
            },
            icon: SvgPicture.asset(
              MapAppIcon.icTurnRight,
              height: 24,
              width: 24,

              fit:   BoxFit.scaleDown,
            ),)
      ],
    );
  }

  TextSpan makeHighlightText(String text, String query) {
    if (query.isEmpty) {
      return TextSpan(
          text: text, style: const TextStyle(color: Colors.grey, fontSize: 16));
    }
    int start = 0;
    var spans = <TextSpan>[];
    do {
      // lay vi tri cua query trong text
      final queryIndex = text.toLowerCase().indexOf(query.toLowerCase(), start);

      // neu query khong co trong text, them phan con lai cua text
      if (queryIndex == -1) {
        spans.add(TextSpan(
            text: text.substring(start),
            style: const TextStyle(color: Colors.grey, fontSize: 16)));
        break;
      }
      // lay text tu start den vi tri cua query
      if (queryIndex > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, queryIndex),
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }

      // them phan query
      spans.add(
        TextSpan(
          text: text.substring(queryIndex, queryIndex + query.length),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      );

      // cap nhat start
      // cho start = vi tri sau cua query de tiep tuc tim kiem

      start = queryIndex + query.length;
    } while (start < text.length);

    return TextSpan(children: spans);
  }
}
