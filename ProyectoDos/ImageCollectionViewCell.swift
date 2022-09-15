//
//  ImageCollectionViewCell.swift
//  ProyectoDos
//
//  Created by Universidad Anahac on 07/09/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    var pokemons: Pokemon? = nil
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func loadImage(url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!){ data, response, error in
            if let data = data{
                let image = UIImage.init(data:data)
                DispatchQueue.main.sync{
                    self.pokemonImageView.image = image
                }
            }
        }
        task.resume()
    }
    
    func loadPokemon(url: String){
        if let pokemon = pokemons {
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.url)!) { data, response, error in
                let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data!)
                self.loadPokemonImage(urlImage: pokemonDetail.sprites.other.home.front_default)
            }
            task.resume()
        }
    }
    func loadPokemonImage(urlImage: String) {
        let task = URLSession.shared.dataTask(with: URL(string: urlImage)!) {data, response, error in
            if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.sync {
                    self.pokemonImageView.image = image
                }
            }
        }
        task.resume()
    }

}
