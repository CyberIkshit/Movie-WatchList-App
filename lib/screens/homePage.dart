import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/models/movieModel.dart';
import 'package:movie_app/provider/signInProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<MovieItem> movieBox;
  TextEditingController _movieName = new TextEditingController();
  TextEditingController _directorName = new TextEditingController();
  TextEditingController _posterURL = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieBox = Hive.box<MovieItem>(movieBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.3,
              child: customAppBar()),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: movieBox.listenable(),
              builder: (context, Box<MovieItem> movie, _) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return movieCard(
                          movie.getAt(index)!.name,
                          movie.getAt(index)!.director,
                          movie.getAt(index)!.posterImage,
                          index);
                    },
                    // separatorBuilder: (BuildContext context, int index) =>
                    // const Divider(
                    //   thickness: 3,
                    // ),
                    itemCount: movieBox.keys.toList().length);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget customAppBar() {
    return ClipPath(
      clipper: CustomShapeHome(),
      child: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.29,
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      final provider =
                          Provider.of<signInProvider>(context, listen: false);
                      provider.logout();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "WatchList",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  GestureDetector(
                      onTap: () {
                        addData(movieBox.keys.toList().length);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          "Add Item",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movieCard(String name, String director, String image, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Material(
        elevation: 10,
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.all(Radius.circular(35)),
        animationDuration: Duration(seconds: 3),
        child: Container(
          // margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          padding: EdgeInsets.fromLTRB(25, 15, 25, 10),
          decoration: BoxDecoration(
            // color: Colors.white12,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black,
            //     blurRadius: 2.0,
            //     spreadRadius: 10.0, // shadow direction: bottom right
            //   )
            // ],
            // image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          // border:
          //     Border.fromBorderSide(BorderSide(width: 4, color: Colors.black))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
                  // SizedBox(height: 30),
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: 150,
                        height: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.fill),
                        ),
                        // child: Image.network(image),
                      ),
                    ),
                    SizedBox(
                      width: 28,
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text: name,
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "\n$director",
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ]),
              SizedBox(height: 15),
              Container(
                // padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _movieName.text = movieBox.getAt(index)!.name;
                          _directorName.text = movieBox.getAt(index)!.director;
                          _posterURL.text = movieBox.getAt(index)!.posterImage;
                          addData(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "UPDATE",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          movieBox.deleteAt(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "DELETE",
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addData(int index) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add/Update Item",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _movieName,
                    decoration: InputDecoration(
                      labelText: "Movie Name",
                      hintText: "Enter Movie Name",
                      prefixIcon: Icon(Icons.movie_creation_outlined),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text("Movie Director Name"),
                  TextFormField(
                    controller: _directorName,
                    decoration: InputDecoration(
                      labelText: "Director Name",
                      hintText: "Enter name of movie director",
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  // Text("Movie Poster URL"),

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _posterURL,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.image_outlined),
                      labelText: "Poster URL",
                      hintText: "Enter link of movie poster",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        //Default Image of KGF 2 movie poster
                        String image =
                            "https://lh3.googleusercontent.com/proxy/dteDSW_STMMmI3tEkg6-CrooFMKGhE79UAhcQuVJBj2oUyFWNUlpXIzl44HVuDCziVBbrWU9DdI05qlN6sGk-wdqJija1FbgKWvqYpW0RjPFiMQoDD6lKx-TUnVpWbcO-4kijlZ8qLvQ1nVa-A";

                        if (_posterURL.text != null &&
                            _posterURL.text.length > 5) image = _posterURL.text;

                        MovieItem item = new MovieItem(
                            _movieName.text, _directorName.text, image);
                        // int n =
                        //     movieBox.keys.toList().length;
                        if (index < movieBox.keys.toList().length)
                          movieBox.putAt(index, item);
                        else
                          movieBox.put(item.name + item.director, item);
                        // print(movieBox
                        //     .get(0)!
                        //     .name
                        //     .toString());
                        Navigator.pop(context);
                        _movieName.clear();
                        _directorName.clear();
                        _posterURL.clear();
                      },
                      child: Text(
                        "Ok",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                ],
              ),
            ),
          );
        });
  }
}

class CustomShapeHome extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = 75;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height + 50);
    path.quadraticBezierTo(0, height + 10, 30, height);
    path.lineTo(width - 30, height);
    path.quadraticBezierTo(width, height + 10, width, height + 40);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
