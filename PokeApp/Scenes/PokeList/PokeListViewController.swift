//
//  PokeListViewController.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

protocol PokeListViewControllerProtocol: AnyObject {
    
}

class PokeListViewController: PokeViewController {
    var interactor: PokeListInteractorProtocol?
    var pokeModel: PokeModel?
    var pokeList: [Any]?
    
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
    }
    
    private func setupView() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension PokeListViewController: PokeListViewControllerProtocol {
    
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokeTableViewCell, let poke = pokeModel else { return UITableViewCell() }
        
        cell.configureCell(image: UIImage(), description: poke.name ?? "")
        
        return cell
    }
}
