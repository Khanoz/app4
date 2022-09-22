//
//  PokemonListViewController.swift
//  ProyectoDos
//
//  Created by Universidad Anahuac on 29/08/22.
//

import UIKit

struct PokemonList: Decodable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Pokemon]
}

struct Pokemon: Decodable {
    var name: String
    var url: String
}

class GoToPokemon{
    var title: String
    var segueId: String
    
    init(title: String, segueId: String){
        self.title = title
        self.segueId = segueId
    }
}

struct Hero: Decodable {
    var name: String
    var url: String
}

class PokemonListViewController: UIViewController {

    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var pokemons: [Pokemon] = []
    var heroes: [Hero] = []
    var test: [String] = ["1", "2", "3"]
    var currentPokemon: Pokemon? = nil
    var currentHero: Hero? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentHero = Hero(name: "hola", url: "ad")
        pokemonTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
        pokemonTableView.dataSource = self
        loadingIndicatorView.hidesWhenStopped = true
        loadingIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            //self.loadPokemons()
            self.loadHeroes(index: 1)
        }
        pokemonTableView.delegate = self

    }
    
    func loadHeroes(index: Int){
        let urlBase = "https://www.superheroapi.com/api.php/423212276549393/\(index)/image"
        
        let listHeroEndPoint = URL.init(string: "\(urlBase)")!
        print(listHeroEndPoint)
        let task = URLSession.shared.dataTask(with: listHeroEndPoint){data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let result = try! jsonDecoder.decode(Hero.self, from: data)
                self.heroes.append(result)
                if(index == 5){
                    self.currentHero = result
                    DispatchQueue.main.sync {
                        self.loadingIndicatorView.stopAnimating()
                        self.pokemonTableView.reloadData()
                    }
                }
                else{
                    self.loadHeroes(index: index+1)
                }
            }
        }
        task.resume()
        

        print(self.heroes)
        print(self.currentHero!)
    }
    
    func loadPokemons(){
        let urlBase = "https://pokeapi.co/api/v2/"
        let listPokemonEndPoint = URL.init(string: "\(urlBase)pokemon?limit=100000&offset=0")!
        let task = URLSession.shared.dataTask(with: listPokemonEndPoint){data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let result = try! jsonDecoder.decode(PokemonList.self, from: data)
                self.pokemons = result.results
                DispatchQueue.main.sync {
                    self.loadingIndicatorView.stopAnimating()
                    self.pokemonTableView.reloadData()
                }
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "especificPokemonSegue" {
            let detailedPokemonViewController = segue.destination as? DetailedPokemonViewController
            detailedPokemonViewController?.pokemons = currentPokemon
        }
    }

}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell") as? PokemonTableViewCell
        if(cell == nil){
            cell = PokemonTableViewCell()
        }
        let item = heroes[indexPath.row]
        //cell?.textLabel?.text = item.name
        cell?.setupView(hero: item)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentHero = heroes[indexPath.row]
        performSegue(withIdentifier: "especificPokemonSegue", sender: nil)
    }

}
