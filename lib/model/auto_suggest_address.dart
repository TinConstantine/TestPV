class AutoSuggestAddress {
   List<Item> items;
   List<dynamic> queryTerms;
  AutoSuggestAddress({
    this.items = const[],
    this.queryTerms = const[],
  });
  factory AutoSuggestAddress.fromJson(Map<String, dynamic> json){
    return AutoSuggestAddress(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      queryTerms: json["queryTerms"] == null ? [] : List<dynamic>.from(json["queryTerms"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x?.toJson()).toList(),
    "queryTerms": queryTerms.map((x) => x).toList(),
  };

}

class Item {
  Item({
    required this.title,
    required this.id,
    required this.resultType,
    required this.localityType,
    required this.address,
    required this.position,
    required this.distance,
    required this.mapView,
    required this.highlights,
    required this.access,
    required this.categories,
    required this.references,
  });

  final String? title;
  final String? id;
  final String? resultType;
  final String? localityType;
  final ItemAddress? address;
  final PositionModel? position;
  final int? distance;
  final MapView? mapView;
  final Highlights? highlights;
  final List<PositionModel> access;
  final List<Category> categories;
  final List<Reference> references;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      title: json["title"],
      id: json["id"],
      resultType: json["resultType"],
      localityType: json["localityType"],
      address: json["address"] == null ? null : ItemAddress.fromJson(json["address"]),
      position: json["position"] == null ? null : PositionModel.fromJson(json["position"]),
      distance: json["distance"],
      mapView: json["mapView"] == null ? null : MapView.fromJson(json["mapView"]),
      highlights: json["highlights"] == null ? null : Highlights.fromJson(json["highlights"]),
      access: json["access"] == null ? [] : List<PositionModel>.from(json["access"]!.map((x) => PositionModel.fromJson(x))),
      categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
      references: json["references"] == null ? [] : List<Reference>.from(json["references"]!.map((x) => Reference.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "resultType": resultType,
    "localityType": localityType,
    "address": address?.toJson(),
    "position": position?.toJson(),
    "distance": distance,
    "mapView": mapView?.toJson(),
    "highlights": highlights?.toJson(),
    "access": access.map((x) => x?.toJson()).toList(),
    "categories": categories.map((x) => x?.toJson()).toList(),
    "references": references.map((x) => x?.toJson()).toList(),
  };

}

class PositionModel {
  PositionModel({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  factory PositionModel.fromJson(Map<String, dynamic> json){
    return PositionModel(
      lat: json["lat"],
      lng: json["lng"],
    );
  }

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };

}

class ItemAddress {
  ItemAddress({
    required this.label,
  });

  final String? label;

  factory ItemAddress.fromJson(Map<String, dynamic> json){
    return ItemAddress(
      label: json["label"],
    );
  }

  Map<String, dynamic> toJson() => {
    "label": label,
  };

}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.primary,
  });

  final String? id;
  final String? name;
  final bool? primary;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
      primary: json["primary"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "primary": primary,
  };

}

class Highlights {
  Highlights({
    required this.title,
    required this.address,
  });

  final List<Title> title;
  final HighlightsAddress? address;

  factory Highlights.fromJson(Map<String, dynamic> json){
    return Highlights(
      title: json["title"] == null ? [] : List<Title>.from(json["title"]!.map((x) => Title.fromJson(x))),
      address: json["address"] == null ? null : HighlightsAddress.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title.map((x) => x?.toJson()).toList(),
    "address": address?.toJson(),
  };

}

class HighlightsAddress {
  HighlightsAddress({
    required this.label,
  });

  final List<dynamic> label;

  factory HighlightsAddress.fromJson(Map<String, dynamic> json){
    return HighlightsAddress(
      label: json["label"] == null ? [] : List<dynamic>.from(json["label"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "label": label.map((x) => x).toList(),
  };

}

class Title {
  Title({
    required this.start,
    required this.end,
  });

  final int? start;
  final int? end;

  factory Title.fromJson(Map<String, dynamic> json){
    return Title(
      start: json["start"],
      end: json["end"],
    );
  }

  Map<String, dynamic> toJson() => {
    "start": start,
    "end": end,
  };

}

class MapView {
  MapView({
    required this.west,
    required this.south,
    required this.east,
    required this.north,
  });

  final double? west;
  final double? south;
  final double? east;
  final double? north;

  factory MapView.fromJson(Map<String, dynamic> json){
    return MapView(
      west: json["west"],
      south: json["south"],
      east: json["east"],
      north: json["north"],
    );
  }

  Map<String, dynamic> toJson() => {
    "west": west,
    "south": south,
    "east": east,
    "north": north,
  };

}

class Reference {
  Reference({
    required this.supplier,
    required this.id,
  });

  final Supplier? supplier;
  final String? id;

  factory Reference.fromJson(Map<String, dynamic> json){
    return Reference(
      supplier: json["supplier"] == null ? null : Supplier.fromJson(json["supplier"]),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "supplier": supplier?.toJson(),
    "id": id,
  };

}

class Supplier {
  Supplier({
    required this.id,
  });

  final String? id;

  factory Supplier.fromJson(Map<String, dynamic> json){
    return Supplier(
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
  };

}
