//
//  PokeHomeViewController.swift
//  PokeApp
//
//  Created by Christian Castro on 04/09/22.
//

import UIKit

protocol PokeHomeViewControllerProtocol: PokeViewControllerBaseProtocol, AnyObject {
    func showPoke(poke: PokeModel, image: UIImage)
    func showFavorite(success: Bool)
}

class PokeHomeViewController: PokeViewController {
    var interactor: PokeInteratorProtocol?
    var pokeModel: PokeModel?
    private var searchForPoke = ""
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
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        self.view.addSubview(button)
        button.tintColor = .label
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemYellow
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTextField)))
        return button
    }()
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        self.view.addSubview(button)
        button.tintColor = .label
        button.layer.cornerRadius = 25
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTextField)))
        return button
    }()
    private lazy var searchTextField: PokeTextField = {
        let textField = PokeTextField()
        self.view.addSubview(textField)
        textField.delegate = self
        textField.isHidden = true
        textField.attributedPlaceholder = NSAttributedString(string: "Search your poke here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemBackground.withAlphaComponent(0.3)])
        return textField
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
        
        interactor?.getMainPoke(name: "bulbasaur", id: nil)
    }
    
    private func setupView() {
        pokeImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pokeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        
        pokeNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pokeNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pokeNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pokeNameLabel.topAnchor.constraint(equalTo: pokeImageView.bottomAnchor, constant: 20).isActive = true
        
        favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -3).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -3).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        searchTextField.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 5).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        if view.frame.width > view.frame.height {
             NSLayoutConstraint.activate(landscapeOrientation)
         } else {
             NSLayoutConstraint.activate(portraitOrientation)
         }
    }
    
    @objc func markFavorite() {
        guard let pokeModel = pokeModel else {
            return
        }
        interactor?.postPoke(poke: pokeModel)
    }
    
    @objc func showTextField() {
        DispatchQueue.main.async {
            self.searchTextField.isHidden = !self.searchTextField.isHidden
        }
    }
    
    @objc func menuTapped() {
        var cellData: [PokeCellModel] {
            return [PokeCellModel(description: "Generation I", image: pokeModel?.sprites?.versions?.generationI?.yellow?.frontDefault),
                    PokeCellModel(description: "Generation II", image: pokeModel?.sprites?.versions?.generationIi?.crystal?.frontDefault),
                    PokeCellModel(description: "Generation VII", image: pokeModel?.sprites?.versions?.generationVii?.icons?.frontDefault),
                    PokeCellModel(description: "Generation V", image: pokeModel?.sprites?.versions?.generationV?.blackWhite?.frontDefault)]
        }
        navigationController?.pushViewController(PokeFactory.getPokeListViewController(poke: cellData), animated: true)
    }
}

extension PokeHomeViewController: PokeHomeViewControllerProtocol {
    func showFavorite(success: Bool) {
        DispatchQueue.main.async {
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            UIAlertController.customAlert(title: "Saved", message: "We saved your poke as favorite", controller: self)
        }
    }
    
    func showPoke(poke: PokeModel, image: UIImage) {
        DispatchQueue.main.async {
            self.pokeNameLabel.text = poke.name
            self.pokeImageView.image = image
        }
        pokeModel = poke
    }
}

extension PokeHomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            searchForPoke = (text as NSString).replacingCharacters(in: range, with: string)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !searchTextField.isHidden {
            showTextField()
        }
        interactor?.getMainPoke(name: (textField.text ?? "").lowercased(), id: nil)
        return textField.resignFirstResponder()
    }
}
