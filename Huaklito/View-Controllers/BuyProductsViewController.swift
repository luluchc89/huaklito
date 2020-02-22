//
//  BuyProductsViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 14/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit


class BuyProductsViewController: UIViewController {
    
    //Collection View configuration constants
    private let itemsPerRow = 3
    private let itemSeparation : CGFloat = 10.0
    private let reuseIdentifier = "productCell"
    private let collectionHeaderIdentifier = "headerView"
    
    //Service to obtain products
    private let productsService = GetProductsService()
    var products: [[Product]]? = [] {
        didSet {
            self.productsCollection.reloadData()
        }
    }
    
    //Search variables
    var filteredProducts : [Product] = [] {
        didSet {
            self.productsCollection.reloadData()
        }
    }
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    //Kart array for products to buy
    var kartProducts = [ProductInKart]()
    var imagesOfKartProducts = [UIImage]()

    
    @IBOutlet weak var productsCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Collection View Protocols
        productsCollection.dataSource = self
        productsCollection.delegate = self
        
        //Register reusable collection cell
        productsCollection.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,  withReuseIdentifier: collectionHeaderIdentifier)
        
        //Get Data to populate collection
        productsService.getProducts { data in
            self.products = data
        }
        
        //Search Controller Protocols and Configuration
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            ProductDetailViewController, let index =
            productsCollection.indexPathsForSelectedItems?.first {
            destination.delegate = self
            destination.productData = products?[index.section][index.row]
            guard let cell = productsCollection.cellForItem(at: index) as? ProductCollectionViewCell else {return}
            destination.productImageData = cell.productImage.image
        }
        else if let destination = segue.destination as?
            ConfirmOrderViewController {
            destination.productsToBuy = self.kartProducts
        }
    }
    
}


//BuyProductsViewController extension to implement UICollectionView Protocol methods
extension BuyProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isFiltering {
            return 1
        } else {
            return products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredProducts.count
        }
        return products?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var id, name, price : String
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        if isFiltering {
            id = filteredProducts[indexPath.item].id
            name = filteredProducts[indexPath.item].name
            price = String(filteredProducts[indexPath.item].price)
        } else {
            guard let products = self.products else { return cell }
            id = products[indexPath.section][indexPath.item].id
            name = products[indexPath.section][indexPath.item].name
            price = String(products[indexPath.section][indexPath.item].price)
        }
        productsService.getProductImage(productId: id) {data in
            cell.productImage.image = UIImage(data: data!)
        }
        cell.productName.text = name
        cell.productPrice.text = "$\(price)"
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

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionHeaderIdentifier, for: indexPath) as! CollectionHeaderView
        if isFiltering {
            header.titleLabel?.text = "Búsqueda"
        } else {
            let categories : [ProductCategory] = ProductCategory.allCases.map { $0 }
            header.titleLabel?.text = categories[indexPath.section].getCategoryTitle()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.bounds.size.width, height: 50.0)
    }
}



//BuyProductsViewController extension to implement Search Controller Protocol methods
extension BuyProductsViewController :  UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
    
        filteredProducts = products!.joined().filter { (product: Product) -> Bool in
          return product.name.lowercased().contains(searchString!.lowercased())
        }
        
        productsCollection.reloadData()
    }
    
}

//Extension to implement delegate to get data from ProductDetailViewController
extension BuyProductsViewController : ProductDetailViewControllerDelegate {
    
    func addProductToKart(withParameter param: ProductInKart) {
        self.kartProducts.append(param)
    }
    
    
}
