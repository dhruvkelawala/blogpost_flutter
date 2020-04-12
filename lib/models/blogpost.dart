class Blogpost {
  String id;
  String title;
  String des;
  String image;
  String author;
  String postedOn;

  Blogpost({
    this.id,
    this.title,
    this.des,
    this.image,
    this.author,
    this.postedOn,
  });

  Blogpost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    des = json['des'];
    image = json['image'];
    author = json['author'];
    postedOn = json['posted_on'];
  }
}
