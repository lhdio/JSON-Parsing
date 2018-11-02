//
//  CollectionViewProtocol.swift
//  JSON Parsing
//
//  Created by Raju on 11/2/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

protocol CollectionReusableView: class {
    static var reuseIdentifier: String { get }
}

extension CollectionReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension MovieCollectionCell: CollectionReusableView {
}

protocol CollectionNibLoadableView: class {
    static var colectionNibName: String { get }
}

extension CollectionNibLoadableView where Self: UIView {
    static var colectionNibName: String {
        return String(describing: self)
    }
}

extension MovieCollectionCell: CollectionNibLoadableView {
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: CollectionReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: CollectionReusableView, T: CollectionNibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.colectionNibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: CollectionReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
