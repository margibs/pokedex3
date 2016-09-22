//
//  Pokemon.swift
//  pokedex3
//
//  Created by margibs on 21/09/2016.
//  Copyright © 2016 margibs. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }

    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        
        Alamofire.request(self._pokemonURL, method: .get).responseJSON{ response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }//End let weight
                
                if let height = dict["height"] as? String {
                    self._height = height
                }//End let height
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }//End let attack
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }//End let defense
                
                if let types = dict["types"] as? [Dictionary<String,String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                        
                    }//End let name
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                                
                            }//End let name
                            
                        }//End For
                        
                    }//End end types.count
                    
                } else {
                    
                    self._type = ""
                    
                }//End let types
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL, method: .get).responseJSON{ response in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                }
                            }
                            completed()
                        }//End Alamofire request
                        
                    }//END let url
                    
                } else {
                    
                    self._description = ""
                    
                }//End let descArr
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                        }//End if nextevo range
                        
                        
                    }//End if let next evo
                    
                    if let lvlExist = evolutions[0]["level"] as? Int {
                        
                        self._nextEvolutionLevel = "\(lvlExist)"
                        
                    }else {
                        
                        self._nextEvolutionLevel = ""
                        
                    }//End if let nextEvoLevel
                    
                    if let nextEvoId = evolutions[0]["resource_uri"] as? String {
                        
                        let newString = nextEvoId.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let nextEvoId2 = newString.replacingOccurrences(of: "/", with: "")
                        
                        self._nextEvolutionId = nextEvoId2
                        
                    }
                    
                } else {
                    
                }//END if let evolutions
                
            }//End let dict
            completed()
            
        }//END alamofire request
        
    }//END downloadPokemonDetail
    
    
}
