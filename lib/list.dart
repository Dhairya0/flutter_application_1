import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';

Widget customListTile(Article article, BuildContext context) {
  return Center(
      child: Card(
          child: SizedBox(
    width: double.infinity,
    height: 226,
    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Row(
        children: [
          Container(
            height: 250,
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // article.urlToImage != null
                //     ? Container(
                //         height: 200.0,
                //         width: 200,
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: NetworkImage(article.urlToImage),
                //               fit: BoxFit.cover),
                //           borderRadius: BorderRadius.circular(12.0),
                //         ),
                //       )
                //     : Container(
                //         height: 200.0,
                //         width: 200,
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //               image: NetworkImage(
                //                   'https://source.unsplash.com/weekly?coding'),
                //               fit: BoxFit.cover),
                //           borderRadius: BorderRadius.circular(12.0),
                //         ),
                //       ),
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    article.source.name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  article.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  article.publishedAt,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 8.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(article.urlToImage),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )
            ],
          )
        ],
      ),
    ),
  )));
}
