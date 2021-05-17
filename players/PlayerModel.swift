//
//  PlayerModel.swift
//  players
//
//  Created by Nirendra Singh Rawal on 16/05/2021.
//

class PlayerModel {
    var id : String?
    var name : String?
    var sport : String?
    var age : String?
    var country : String?
    
    init(id:String?, name:String?, sport:String?, age:String?, country:String) {
        self.id = id
        self.name = name
        self.sport = sport
        self.age = age
        self.country = country
        
    }
}
