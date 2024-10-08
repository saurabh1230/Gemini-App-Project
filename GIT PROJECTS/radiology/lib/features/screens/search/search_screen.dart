import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/search_controller.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/helper/route_helper.dart';
import '../../../controllers/notes_controller.dart';
import '../../../data/model/response/search_model.dart';
import '../../../data/repo/note_repo.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(title: 'Search',isBackButtonExist: true,),
      body: GetBuilder<SearchDataController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (pattern) async {
                    if (pattern.isNotEmpty) {
                      await controller.getSearchList(pattern);
                    }
                  },
                ),
              ),
              SizedBox(height: 16), // Space between TypeAhead and TabBar
              Expanded(
                child: DefaultTabController(
                  length: 6, // Number of tabs
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'Notes'),
                          Tab(text: 'Spotters'),
                          Tab(text: 'OSCE'),
                          Tab(text: 'Munchies'),
                          Tab(text: 'Learn'),
                          Tab(text: 'Basics'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTabContent(controller, controller.searchNoteList, (searchItem) {
                              Get.toNamed(RouteHelper.getNotesDashboardRoute(
                                  searchItem.id.toString(),
                                  searchItem.title.toString()));
                            }),
                            _buildTabContent(controller, controller.searchSpottersList, (searchItem) {
                              Get.toNamed(RouteHelper.getSpottersDetailsRoute(
                                  searchItem.id.toString(),
                                  searchItem.title.toString()));
                            }),
                            _buildTabContent(controller, controller.searchOsceList, (searchItem) {

                            }),
                            _buildTabContent(controller, controller.searchMunchiesList, (searchItem) {
                              Get.toNamed(RouteHelper.getMunchesDetailsRoute(
                                  searchItem.id.toString(),
                                  searchItem.title.toString()));
                            }),
                            _buildTabContent(controller, controller.searchlearnList, (searchItem) {

                            }),
                            _buildTabContent(controller, controller.searchBasicsList, (searchItem) {

                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabContent(
      SearchDataController controller,
      List<SearchModel>? searchList,
      Function(SearchModel) onTap, // Add onTap parameter
      ) {
    if (controller.isSearchLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (searchList == null || searchList.isEmpty) {
      return Center(child: Text('No results found'));
    } else {
      return ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          final searchItem = searchList[index];
          return ListTile(
            title: Text(searchItem.title),
            onTap: () => onTap(searchItem), // Invoke onTap when the item is tapped
          );
        },
      );
    }
  }
}
