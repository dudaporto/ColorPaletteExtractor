//
//  UIStackView.swift
//  ColorPaletteExtractor
//
//  Created by Maria Eduarda Porto on 16/04/21.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
