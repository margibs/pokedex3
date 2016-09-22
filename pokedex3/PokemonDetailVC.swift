//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by margibs on 21/09/2016.
//  Copyright © 2016 margibs. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        
        nameLbl.text = pokemon.name.capitalized
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            // Whatever we write here will only be called after the network call is complete!
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        weightLbl.text = "\(pokemon.weight)"
        heightLbl.text = "\(pokemon.height)"
        attackLbl.text = "\(pokemon.attack)"
        defenseLbl.text = "\(pokemon.defense)"
        typeLbl.text = "\(pokemon.type)"
        descriptionLbl.text = "\(pokemon.description)"
        
        
        if pokemon.nextEvolutionLevel == "" {
           evoLbl.text = "Final Evolution"
            nextEvoImg.isHidden = true
        } else {
           evoLbl.text = "Next Evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)"
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvolutionId)")
        }
        
        
    
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }

}
