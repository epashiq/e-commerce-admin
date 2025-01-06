import 'package:flutter/material.dart';
import 'package:instagram_demo/features/comment/presentation/view/comment_page.dart';
import 'package:instagram_demo/features/home/presentation/provider/person_provider.dart';
import 'package:instagram_demo/features/home/presentation/view/widgets/add_person_dialogue_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      personProvider.fetchPerson();
      personProvider.clearList();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!personProvider.isLoading && !personProvider.noMoreData) {
          personProvider.fetchPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/insta_camera.png'),
        title: const Text(''),
        actions: [
          Image.asset('assets/images/IGTV.png'),
          const SizedBox(width: 20),
          Image.asset('assets/images/share.png'),
        ],
      ),
      body: Consumer<PersonProvider>(
        builder: (context, personPro, child) {
          if (personPro.isLoading && personPro.personList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (personPro.personList.isEmpty) {
            return const Center(
              child: Text('No posts'),
            );
          } else {
            return ListView.builder(
              controller: scrollController,
              itemCount: personPro.personList.length,
              itemBuilder: (context, index) {
                final post = personPro.personList[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const CircleAvatar(radius: 25),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(post.place),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 350,
                          width: MediaQuery.sizeOf(context).width,
                          child: post.imageUrl != null
                              ? Image.network(
                                  post.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                personPro.updateLike(personId: post.id!);
                              },
                              child: Image.asset('assets/images/favourite.png'),
                            ),
                            Text(post.like.toString()),
                            const SizedBox(width: 10),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CommentPage(personId: post.id!),
                                      ));
                                },
                                child:
                                    Image.asset('assets/images/Comment.png')),
                            const SizedBox(width: 10),
                            Image.asset('assets/images/share.png'),
                            const Spacer(),
                            Image.asset('assets/images/Shape.png'),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: post.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const TextSpan(text: '  '),
                                TextSpan(
                                  text: post.descreption,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddPersonDialogueWidget();
            },
          );
        },
        child: const Text('Add post'),
      ),
    );
  }
}
