import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/search/result_search.dart';
import 'package:location/location.dart';

class FilterPage extends StatefulWidget {
  FilterPage(
      {super.key,
      required this.listCategory,
      required this.listAccommodation,
      required this.rating,
      required this.budget,
      required this.sortBy,
      required this.currentPosition});

  List<Category> listCategory;
  List<Accommodation> listAccommodation;
  double budget;
  double rating;
  Sort sortBy;
  LocationData currentPosition;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final Color _chooseColor = Turquois;
  final Color _notChooseColor = NaturalBlue;

  TextEditingController? budgetTextController;
  TextEditingController? ratingTextController;

  @override
  void initState() {
    super.initState();
    budgetTextController =
        TextEditingController(text: widget.budget.toString());
    ratingTextController =
        TextEditingController(text: widget.rating.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _selectBudget(),
              _defaultDivider(),
              _selectMinimumRating(),
              _defaultDivider(),
              _selectCategory(),
              _defaultDivider(),
              _selectSortBy(),
              _defaultDivider(),
              _searchButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _selectBudget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your budget',
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
            child: TextFormField(
              controller: budgetTextController,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                hintText: 'Enter your budget',
                hintStyle: Theme.of(context).textTheme.bodyText2,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectMinimumRating() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Minimum Rating',
          style: Theme.of(context).textTheme.headline6,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
            child: TextFormField(
              controller: ratingTextController,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                hintText: 'Enter your budget',
                hintStyle: Theme.of(context).textTheme.bodySmall,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.end,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectCategory() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Category',
          style: Theme.of(context).textTheme.headline6,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(Icons.house, 'Shared Home', Category.SharedHome),
              _categoryChoice(Icons.apartment, 'Apartment', Category.Apartment),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(Icons.gite, 'Hostel', Category.Hostel),
              _categoryChoice(Icons.hotel, 'Hotel', Category.Hotel),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(Icons.cottage, 'Homestead', Category.Homestead),
              _categoryChoice(Icons.breakfast_dining, 'Breakfast Included',
                  Category.BreakfastIncluded),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(Icons.spa, 'Spa', Category.Spa),
              _categoryChoice(Icons.pool, 'Pool', Category.Pool),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(
                  Icons.ac_unit, 'Air Conditioning', Category.AirConditioning),
              _categoryChoice(Icons.local_parking_rounded, 'Parking Lot',
                  Category.ParkingLot),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _categoryChoice(
                  Icons.other_houses, 'Double Room', Category.DoubleRoom),
              _categoryChoice(
                  Icons.location_city_rounded, 'Near City', Category.NearCity),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
          child:
              _categoryChoice(Icons.shield, 'High Safety', Category.HighSafety),
        ),
      ],
    );
  }

  Widget _defaultDivider() {
    return const Divider(
      thickness: 0.5,
      color: BlueJean,
    );
  }

  _selectSortBy() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: Theme.of(context).textTheme.headline6,
        ),
        ListTile(
          title: Text(
            'Price',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: Radio(
            value: Sort.price,
            groupValue: widget.sortBy,
            onChanged: (Sort? value) {
              setState(() {
                widget.sortBy = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Rating',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: Radio(
            value: Sort.rating,
            groupValue: widget.sortBy,
            onChanged: (Sort? value) {
              setState(() {
                widget.sortBy = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text(
            'Distance',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: Radio(
            value: Sort.distance,
            groupValue: widget.sortBy,
            onChanged: (Sort? value) {
              setState(() {
                widget.sortBy = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  _categoryChoice(IconData icons, String text, Category category) {
    bool isContain = widget.listCategory.contains(category);
    return InkWell(
      onTap: (() {
        setState(() {
          if (isContain) {
            widget.listCategory.removeWhere((element) => element == category);
          } else {
            widget.listCategory.add(category);
          }
          isContain = !isContain;
        });
      }),
      child: Container(
        padding: const EdgeInsets.all(5.0),
        width: (MediaQuery.of(context).size.width - 20) / 2 - 5,
        height: 100,
        decoration: BoxDecoration(
          color: isContain ? Colors.grey.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: BlueJean, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icons),
            const SizedBox(
              height: 0.5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  _searchButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            widget.budget = double.parse(budgetTextController!.text);
            widget.rating = double.parse(ratingTextController!.text);
            widget.listAccommodation = filterResult(widget.listAccommodation,
                widget.listCategory, widget.rating, widget.budget);
            widget.listAccommodation =
                sortAccommodation(widget.listAccommodation, widget.sortBy);

            Map<String, dynamic> ret = {
              'category': widget.listCategory,
              'accommodation': widget.listAccommodation,
              'rating': widget.rating,
              'budget': widget.budget,
              'sortBy': widget.sortBy,
            };
            Navigator.pop(context, ret);
          },
          child: Text('Search again')),
    );
  }

  List<Accommodation> filterResult(List<Accommodation> accommodation,
      List<Category> requirement, double rating, double budget) {
    accommodation.retainWhere(
        (element) => filterRequirement(element, requirement, rating, budget));
    return accommodation;
  }

  bool filterRequirement(Accommodation accommodation,
      List<Category> requirement, double rating, double budget) {
    for (Category categories in requirement) {
      if (!accommodation.category.contains(categories)) return false;
    }
    if (accommodation.rating < rating) return false;
    if (accommodation.price > budget) return false;
    return true;
  }

  List<Accommodation> sortAccommodation(
      List<Accommodation> accommodation, Sort sort) {
    // GeoPoint currentLocation;
    if (sort == Sort.price) {
      accommodation.sort((b, a) => a.price.compareTo(b.price));
    } else if (sort == Sort.rating) {
      accommodation.sort((b, a) => a.rating.compareTo(b.rating));
    } else if (sort == Sort.distance && widget.currentPosition != null) {
      accommodation.sort((b, a) => Geolocator.distanceBetween(
              a.location.latitude,
              a.location.longitude,
              widget.currentPosition.latitude!,
              widget.currentPosition.longitude!)
          .compareTo(Geolocator.distanceBetween(
              b.location.latitude,
              b.location.longitude,
              widget.currentPosition.latitude!,
              widget.currentPosition.longitude!)));
    }
    return accommodation;
  }
}
