//
//  PokeHomeViewController.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import UIKit

protocol PokeHomeViewControllerProtocol: AnyObject {
    func showPoke(poke: PokeModel, image: UIImage)
    func showError(error: String)
}

class PokeHomeViewController: PokeViewController {
    var interactor: PokeInteratorProtocol?
    var pokeModel: PokeModel?
    private lazy var portraitOrientation: [NSLayoutConstraint] = [
        pokeImageView.heightAnchor.constraint(equalToConstant: 250),
        pokeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)]
    private lazy var landscapeOrientation: [NSLayoutConstraint] = [
        pokeImageView.heightAnchor.constraint(equalToConstant: 150),
        pokeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5)]
    
    private lazy var pokeImageView: PokeImageView = {
        let imageView = PokeImageView(frame: .zero)
        self.view.addSubview(imageView)
        return imageView
    }()
    private lazy var pokeNameLabel: PokeTitleLabel = {
        let label = PokeTitleLabel()
        self.view.addSubview(label)
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Poke Detail", style: .plain, target: self, action: #selector(menuTapped)), animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if size.width > size.height {
                NSLayoutConstraint.deactivate(self.portraitOrientation)
                NSLayoutConstraint.activate(self.landscapeOrientation)
            } else {
                NSLayoutConstraint.deactivate(self.landscapeOrientation)
                NSLayoutConstraint.activate(self.portraitOrientation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.getMainPoke(name: "bulbasaur")
    }
    
    private func setupView() {
        pokeImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pokeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        pokeNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pokeNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pokeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pokeNameLabel.topAnchor.constraint(equalTo: pokeImageView.bottomAnchor, constant: 20).isActive = true
        
        if view.frame.width > view.frame.height {
             NSLayoutConstraint.activate(landscapeOrientation)
         } else {
             NSLayoutConstraint.activate(portraitOrientation)
         }
    }
    
    @objc func menuTapped() {
        navigationController?.pushViewController(PokeFactory.getPokeListViewController(poke: pokeModel), animated: true)
    }
}

extension PokeHomeViewController: PokeHomeViewControllerProtocol {
    func showPoke(poke: PokeModel, image: UIImage) {
        DispatchQueue.main.async {
            self.pokeNameLabel.text = poke.name
            self.pokeImageView.image = image
        }
        pokeModel = poke
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            UIAlertController.customAlert(title: "Ops.. We had a issue here", message: error, controller: self)
        }
    }
}
