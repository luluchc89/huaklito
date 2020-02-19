//
//  CollectionHeaderView.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 17/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionTitle()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCollectionTitle()
        setUpLayout()
    }
    
    func setUpCollectionTitle() {
        titleLabel = UILabel()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.backgroundColor = .lightGray
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        titleLabel?.textAlignment = .center
        
        addSubview(titleLabel!)
    }
    
    func setUpLayout() {
        titleLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
        
}
