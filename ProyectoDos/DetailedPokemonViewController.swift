//
//  DetailedPokemonViewController.swift
//  ProyectoDos
//
//  Created by Universidad Anahuac on 31/08/22.
//

import UIKit

class DetailedPokemonViewController: UIViewController {
    
    var pokemons: Pokemon? = nil
    var imageList: [String] = []

    @IBOutlet weak var carouselCollection: UICollectionView!
    @IBOutlet weak var nombrePokemon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageList.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/132.png")
        imageList.append("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/132.png")
        carouselCollection.dataSource = self
        carouselCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        nombrePokemon.text = pokemons?.name
        loadPokemon()
    }
    
    func loadPokemon(){
        if let pokemon = pokemons {
            let task = URLSession.shared.dataTask(with: URL(string: pokemon.url)!) { data, response, error in
                let pokemonDetail = try! JSONDecoder().decode(PokemonDetail.self, from: data!)
                print(pokemonDetail)
                //self.loadPokemonImage(urlImage: pokemonDetail.sprites.other.home.front_default)
            }
            task.resume()
        }
    }
    /*
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
    }*/

}



extension DetailedPokemonViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionViewCell
        if cell == nil{
            cell = ImageCollectionViewCell()
        }
        
        let url = imageList[indexPath.row]
        cell?.loadImage(url: url)
        return cell!
    }
    
    
}
