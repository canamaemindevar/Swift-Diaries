//
//  Model.swift
//  favoriteBook
//
//  Created by Emincan on 11.01.2023.
//

import Foundation

struct FavModel: Identifiable {
    
    var id =  UUID()
    var title: String
    var elements: [FavElements]
    
}

struct FavElements: Identifiable {
    
    var id = UUID()
    var name: String
    var imageName: String
    var descreption: String
    
}

let metallice = FavElements(name: "Metallica", imageName: "satis1", descreption: "Best Band")
let systemofdomw = FavElements(name: "SystemOfADown", imageName: "satis2", descreption: "Best Band")
let gripin = FavElements(name: "Gripin", imageName: "satis", descreption: "Best Band")


let favBands = FavModel(title: "FavBands", elements: [metallice,systemofdomw,gripin])

//


let lotr = FavElements(name: "lotr", imageName: "godfather", descreption: "Best Band")
let batman = FavElements(name: "batman", imageName: "godfather", descreption: "Best Band")
let fightClub = FavElements(name: "fightClub", imageName: "godfather", descreption: "Best Band")


let favMovies = FavModel(title: "FavMovies", elements: [lotr,batman,fightClub])
//

let myFavs = [favBands,favMovies]
