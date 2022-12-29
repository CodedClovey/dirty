import 'package:flutter/material.dart';
import 'package:movieapp/get.dart';
import 'package:movieapp/remote_service.dart';

class Mpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Mpage();
}

class _Mpage extends State<Mpage> {
  Get? gets,gett,getu;
  var isL = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    gets = await RemoteService().getGets('https://api.themoviedb.org/3/movie/popular?api_key=880f8e230bef550d07fc5dff5ccd42bb&language=en-US');
    gett = await RemoteService().getGets('https://api.themoviedb.org/3/movie/top_rated?api_key=880f8e230bef550d07fc5dff5ccd42bb&language=en-US');
    getu = await RemoteService().getGets('https://api.themoviedb.org/3/movie/now_playing?api_key=880f8e230bef550d07fc5dff5ccd42bb&language=en-US');
    if (gets != null) {
      setState(() {
        isL = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff171c21),
        appBar: AppBar(
          backgroundColor: const Color(0xff171c21),
          title: const Text("Movies"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Trending Movies",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 200,
              child: Visibility(
                visible: isL,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      width: 100,
                      child: Column(
                        children: [
                          Image.network('https://image.tmdb.org/t/p/original' +
                              gets!.results[index].posterPath),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            gets!.results[index].originalTitle,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              "Top Rated Movies",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 200,
              child: Visibility(
                visible: isL,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      width: 100,
                      child: Column(
                        children: [
                          Image.network('https://image.tmdb.org/t/p/original' +
                              gett!.results[index].posterPath),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            gett!.results[index].originalTitle,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              "Now Playing",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 200,
              child: Visibility(
                visible: isL,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      width: 100,
                      child: Column(
                        children: [
                          Image.network('https://image.tmdb.org/t/p/original' +
                              getu!.results[index].posterPath),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            getu!.results[index].originalTitle,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
