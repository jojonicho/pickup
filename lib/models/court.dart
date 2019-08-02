//import 'package:flutter/material.dart';

class Court {
  final String name;
  final String address;
  final int id;

  Court({
    this.id, 
    this.name, 
    this.address
    });

  static Court fetchByID(int courtID){
    List<Court> courts = Court.fetchAll();
    for (var i = 0; i < courts.length; i++) {
      if (courts[i].id == courtID) {
        return courts[i];
      }
    }
    return null;
  }
    
  static List<Court> fetchAll() {
    return [
      Court(
        id: 1, 
        name: 'Blok M', 
        address: 'Jl Kencana Utama V'),
      Court(
        id: 2, 
        name: 'Blok E', 
        address: 'Lupa hehe'),
      Court(
        id: 3, 
        name: 'Kanisius', 
        address: 'Jl Menteng Raya 64'),
      Court(
        id: 4, 
        name: 'Taman Menteng', 
        address: 'situ'),
      Court(
        id: 5, 
        name: 'Lapangan Banteng', 
        address: 'deket sanur'),
      Court(
        id: 6, 
        name: 'Rumah hansen', 
        address: 'tanya hansen'),
    ];
  }
}