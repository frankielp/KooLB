import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/host/host.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/renter/renter.dart';

Renter renter1 = Renter('Melida Colly', 'username', 'melida.colly@gmail.com',
    'fb.com/melidacolly', '22/09/1990', 'USA', 'Dollars', 'English');

Host host1 = Host('Kreacher Pierson', 'caprabi@gmail.com',
    'fb.com/kreacherhotel', '40/09/1989', 'Germany', 'Euro', 'English');

Place place1 = Place('Cung An Định', GeoPoint(16.456661, 107.5960929));
