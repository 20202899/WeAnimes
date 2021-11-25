//
//  UIView+Extension.swift
//  WeAniList
//
//  Created by Carlos Silva on 21/11/21.
//

import UIKit

extension UIView {
    func anchor(
        top: (NSLayoutYAxisAnchor, CGFloat)? = nil,
        left: (NSLayoutXAxisAnchor, CGFloat)? = nil,
        right: (NSLayoutXAxisAnchor, CGFloat)? = nil,
        bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: top?.0 ?? self.topAnchor, constant: top?.1 ?? .zero),
            self.leftAnchor.constraint(equalTo: left?.0 ?? self.leftAnchor, constant: left?.1 ?? .zero),
            self.rightAnchor.constraint(equalTo: right?.0 ?? self.rightAnchor, constant: right?.1 ?? .zero),
            self.bottomAnchor.constraint(equalTo: bottom?.0 ?? self.bottomAnchor, constant: bottom?.1 ?? .zero)
        ])
    }
}
