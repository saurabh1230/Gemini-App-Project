import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radiology/controllers/search_controller.dart';
import 'package:radiology/features/screens/custom_appbar.dart';
import 'package:radiology/helper/route_helper.dart';
import '../../../controllers/notes_controller.dart';
import '../../../data/model/response/search_model.dart';
import '../../../data/repo/note_repo.dart';
import '../../../data/repo/spotters_repo.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  final SpottersRepo spottersRp = Get.put(SpottersRepo(apiClient: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Search', isBackButtonExist: true),
      body: GetBuilder<SearchDataController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
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
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Make tabs scrollable horizontally
                        child: TabBar(
                          isScrollable: true, // Allow tabs to slide
                          tabs: [
                            Tab(text: 'Notes'),
                            Tab(text: 'Spotters'),
                            Tab(text: 'OSCE'),
                            Tab(text: 'Munchies'),
                            Tab(text: 'Watch And Learn'),
                            Tab(text: 'Back To Basics'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTabContent(
                              controller,
                              controller.searchNoteList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getNoteDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
                            _buildTabContent(
                              controller,
                              controller.searchSpottersList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getSpottersDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
                            _buildTabContent(
                              controller,
                              controller.searchOsceList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getOsceDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
                            _buildTabContent(
                              controller,
                              controller.searchMunchiesList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getMunchesDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
                            _buildTabContent(
                              controller,
                              controller.searchlearnList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getWatchAndLearnDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
                            _buildTabContent(
                              controller,
                              controller.searchBasicsList,
                                  (searchItem) {
                                Get.toNamed(RouteHelper.getBasicDetailsRoute(
                                    searchItem.id.toString(),
                                    searchItem.title.toString()));
                              },
                            ),
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
