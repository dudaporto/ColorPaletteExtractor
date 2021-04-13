//
//  MainViewController.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 12/04/21.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet private weak var buttonsStackView: UIStackView!
    
    @IBAction private func extractPaletteButtonClicked(_ sender: Any) {
        print("Upload photos")
    }
    
    @IBAction private func myPalettesButtonClicked(_ sender: Any) {
        print("See my palettes")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

