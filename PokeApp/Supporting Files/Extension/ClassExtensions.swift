//
//  Extensions.swift
//  PokeApp
//
//  Created by Christian Castro on 05/09/22.
//

import UIKit

/// Base ViewController, set here any layout and will be applied on every ViewController that affiliates to it
class PokeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
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
        backgroundColor = .red
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
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 12
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
}
