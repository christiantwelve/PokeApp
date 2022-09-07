//
//  Extensions.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

protocol PokeViewControllerBaseProtocol {
    func showError(error: String)
    func showLoading(_ should: Bool)
}

/// Base ViewController, set here any layout and will be applied on every ViewController that affiliates to it
class PokeViewController: UIViewController, PokeViewControllerBaseProtocol {
    
    private let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupAnimations()
    }
    
    private func setupAnimations() {
        self.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate(
            [loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
             loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor, constant: 100),
             loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
             loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)])
    }
    
    func showLoading(_ should: Bool) {
        DispatchQueue.main.async {
            self.loadingIndicator.isAnimating = should
        }
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            UIAlertController.customAlert(title: "Ops.. We had a issue here", message: error, controller: self)
        }
    }
}

class PokeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
               layer.borderColor = UIColor.label.cgColor
           }
       }
    }
    
    private func setup() {
        borderStyle = .none
        backgroundColor = .label
        textColor = .black
        textAlignment = .center
        layer.cornerRadius = 12
        minimumFontSize = 7
        adjustsFontSizeToFitWidth = true
        font = UIFont.systemFont(ofSize: 18)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class PokeTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        numberOfLines = 1
        textColor = .label
        clipsToBounds = true
        minimumScaleFactor = 4
        backgroundColor = .systemRed
        textAlignment = .center
        layer.cornerRadius = 15
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
}

class PokeImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               // ColorUtils.loadCGColorFromAsset returns cgcolor for color name
               layer.borderColor = UIColor.label.cgColor
           }
       }
    }
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
}
