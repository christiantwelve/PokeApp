//
//  PokeListViewController.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

protocol PokeListViewControllerProtocol: PokeViewControllerBaseProtocol, AnyObject {
    func showPokeList(pokes: [PokeCellModel]?)
}

class PokeListViewController: PokeViewController {
    var interactor: PokeListInteractorProtocol?
    var pokeList: [PokeCellModel]?
    var pokeModel: PokeModel?
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokeTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        interactor?.getPictures(pokes: pokeModel)
    }
    
    private func setupView() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension PokeListViewController: PokeListViewControllerProtocol {
    func showPokeList(pokes: [PokeCellModel]?) {
        DispatchQueue.main.async {
            self.pokeList = pokes
            self.tableView.reloadData()
        }
    }
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokeTableViewCell,
              let poke = pokeList?[indexPath.row] else { return UITableViewCell() }
        
        cell.configureCell(image: poke.contentImage ?? UIImage(), description: poke.description ?? "")
        
        return cell
    }
}
