//
//  MainViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 12/04/21.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Views
    
    private lazy var buttonsStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15.0
        return stackView
    }()
    
    private lazy var extractPalletButton: UIButton = {
        let button = UIButton(type: .system)
        button.borderColor = .systemGray4
        button.borderWidth = 1
        button.setTitleColor(.label, for: [])
        button.setTitle("Extract palette color", for: [])
        button.addTarget(self, action: #selector(extractPaletteButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
       let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        return controller
    }()
    
    private lazy var myPalletsButton: UIButton = {
        let button = UIButton(type: .system)
        button.borderColor = .systemGray4
        button.borderWidth = 1
        button.setTitleColor(.label, for: [])
        button.setTitle("My palettes", for: [])
        button.addTarget(self, action: #selector(myPalettesButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Actions
    
    @objc private func extractPaletteButtonClicked() {
        present(imagePickerController, animated: true)
    }
    
    @objc private func myPalettesButtonClicked() {
        print("See my palettes")
    }
    
    //MARK: - Navigation
    
    private func showImageUploadViewController(image: UIImage) {
        let imageUploadViewController = ImageUploadViewController(image: image)
        present(imageUploadViewController, animated: false)
    }
    
    //MARK: - Configuration
    
    private func configureViews() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubviews(extractPalletButton, myPalletsButton)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .systemBackground
        
        configureViews()
        
        print("KEY: \(ImaggaApiCredentials.key)")
        print("SECRET: \(ImaggaApiCredentials.secret)")
    }
}

//MARK: - UIImagePickerControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let seletedImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            return
        }
        
        dismiss(animated: true) {
            let vcTest = ExtractedPaletteViewController(image: seletedImage)
            self.navigationController?.pushViewController(vcTest, animated: true)
        }
    }
}
