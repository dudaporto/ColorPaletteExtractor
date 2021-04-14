//
//  ImageUploadViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 13/04/21.
//

import UIKit

class ImageUploadViewController: UIViewController {
    let image: UIImage
    
    private let defaultInset: CGFloat = 20.0
    
    //MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.cornerRadius = 10
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: [])
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    @objc private func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //MARK: - Configuration
    
    private func configureViews() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultInset),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultInset),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultInset),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: defaultInset)
        ])
    }
    
    //MARK: - Lifecycle
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should never be called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureViews()
    }
}
