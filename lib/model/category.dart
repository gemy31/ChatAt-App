class Category{
  static String moviesId = 'movies';
  static String sportsId = 'sports';
  static String musicId = 'music';
  String id ;
  late String title ;
  late String image;
  Category({required this.id,required this.title,required this.image});
  Category.fromId({required this.id}){
    // image = 'assets/images/$id.png';
    // title = id ;
    if(id == 'movies'){
      title = 'Movies';
      image = 'assets/images/movies.png';
    }else if (id == 'sports'){
      title = 'Sports';
      image = 'assets/images/sports.png';
    }else if (id == 'music'){
      title = 'Music';
      image = 'assets/images/music.png';
    }
  }
  static List<Category> getCategories(){
    return [
      Category.fromId(id: moviesId),
      Category.fromId(id: sportsId),
      Category.fromId(id: musicId),
    ];
  }
}