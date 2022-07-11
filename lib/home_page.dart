import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pokemonList = [];

  bool loading = true;

  @override
  void initState() {
    _getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              'https://raw.githubusercontent.com/RafaelBarbosatec/SimplePokedex/master/assets/pokebola_img.png',
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                      title: Text(pokemonList[index].name ?? ''),
                      leading: Image.network(
                          pokemonList[index].thumbnailImage ?? ''),
                      trailing: Text('#${pokemonList[index].number ?? ''}',
                          style: const TextStyle(color: Colors.grey)),
                      onTap: () {
                        Navigator.of(context).pushNamed('/pokemonPage',
                            arguments: pokemonList[index]);
                      }),
                );
              }),
          if (loading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  void _getPokemons() {
    Uri url = Uri.parse('http://104.131.18.84/pokemon/?limit=50&page=0');
    setState(() {
      loading = true;
    });
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        setState(() {
          Map json = const JsonDecoder().convert(value.body);

          for (var element in (json['data'] as List)) {
            pokemonList.add(Pokemon.fromJson(element));
          }
          loading = false;
        });
      }
    });
  }
}

class Pokemon {
  List<String>? abilities;
  String? detailPageUrl;
  int? weight;
  List<String>? weakness;
  String? number;
  int? height;
  String? collectiblesSlug;
  String? featured;
  String? slug;
  String? description;
  String? name;
  String? thumbnailAltText;
  String? thumbnailImage;
  int? id;
  List<String>? type;

  Pokemon(
      {this.abilities,
      this.detailPageUrl,
      this.weight,
      this.weakness,
      this.number,
      this.height,
      this.collectiblesSlug,
      this.featured,
      this.slug,
      this.description,
      this.name,
      this.thumbnailAltText,
      this.thumbnailImage,
      this.id,
      this.type});

  Pokemon.fromJson(Map<String, dynamic> json) {
    abilities =
        json["abilities"] == null ? null : List<String>.from(json["abilities"]);
    detailPageUrl = json["detailPageURL"];
    weight = json["weight"];
    weakness =
        json["weakness"] == null ? null : List<String>.from(json["weakness"]);
    number = json["number"];
    height = json["height"];
    collectiblesSlug = json["collectibles_slug"];
    featured = json["featured"];
    slug = json["slug"];
    description = json["description"];
    name = json["name"];
    thumbnailAltText = json["thumbnailAltText"];
    thumbnailImage = json["thumbnailImage"];
    id = json["id"];
    type = json["type"] == null ? null : List<String>.from(json["type"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (abilities != null) data["abilities"] = abilities;
    data["detailPageURL"] = detailPageUrl;
    data["weight"] = weight;
    if (weakness != null) data["weakness"] = weakness;
    data["number"] = number;
    data["height"] = height;
    data["collectibles_slug"] = collectiblesSlug;
    data["featured"] = featured;
    data["slug"] = slug;
    data["description"] = description;
    data["name"] = name;
    data["thumbnailAltText"] = thumbnailAltText;
    data["thumbnailImage"] = thumbnailImage;
    data["id"] = id;
    if (type != null) data["type"] = type;
    return data;
  }
}
