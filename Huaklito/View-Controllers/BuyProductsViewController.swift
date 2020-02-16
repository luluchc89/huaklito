//
//  BuyProductsViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 14/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit


class BuyProductsViewController: UIViewController {
    
    private let itemsPerRow = 3
    private let itemSeparation: CGFloat = 10.0
    private let reuseIdentifier = "productCell"
    private let productsService = GetProductsService()
    
    var fruits: [Product]? = [] {
        didSet {
            self.productsCollection.reloadData()
        }
    }
    
    
    @IBOutlet weak var productsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollection.dataSource = self
        productsCollection.delegate = self
        
        productsService.getFruits { data in
            self.fruits = data
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//BuyProductsViewController extension to implement UICollectionView methods
extension BuyProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruits!.count
        //return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.productImage.image = UIImage(named: "holder")
        cell.productName.text = fruits![indexPath.item].name
        cell.productPrice.text = String(fruits![indexPath.item].price)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      let paddingSpace = Int(itemSeparation) * (itemsPerRow + 1)
      let availableWidth = Int(collectionView.bounds.size.width) - paddingSpace
      let widthPerItem = availableWidth / itemsPerRow
         
        return CGSize(width: widthPerItem, height: Int(Double(widthPerItem)*1.6))
    }

}
