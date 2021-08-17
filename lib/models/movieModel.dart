import 'package:hive/hive.dart';

part 'movieModel.g.dart';

@HiveType(typeId: 0)
class MovieItem {
  @HiveField(0)
  String name;
  @HiveField(1)
  String director;
  @HiveField(2)
  String posterImage;
  MovieItem(this.name, this.director, this.posterImage);
}
