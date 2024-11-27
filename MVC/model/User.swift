//
//  User.swift
//  MVC
//
//  Created by Muralidhar reddy Kakanuru on 11/27/24.
//


/*  {
 "capital": "Kabul",
 "code": "AF",
 "currency": {
   "code": "AFN",
   "name": "Afghan afghani",
   "symbol": "؋"
 },
 "flag": "https://restcountries.eu/data/afg.svg",
 "language": {
   "code": "ps",
   "name": "Pashto"
 },
 "name": "Afghanistan",
 "region": "AS"
},*/

import Foundation

struct Currency: Codable{
    let code: String
    let name: String
    let symbol: String?
}

struct Language: Codable{
    let code: String?
    let name: String
}

struct User: Codable {
    let capital: String
    let code: String
    let currency: Currency
    let flag: String
    let language: Language
    let name: String
    let region: String
}



