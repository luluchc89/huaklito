//
//  ProductDetailViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 19/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit

protocol ProductDetailViewControllerDelegate {
    func addProductToKart(withParameter param: ProductInKart)
}

class ProductDetailViewController: UIViewController {
    
    var delegate: ProductDetailViewControllerDelegate!
    
    var productData: Product!
    var productImageData: UIImage!
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var pricePerUnitLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var quantityToBuyLabel: UILabel!
    @IBOutlet weak var quantityToBuyStepper: UIStepper!
    @IBOutlet weak var buyButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quantityToBuyLabel.layer.borderColor = UIColor.darkGray.cgColor
        quantityToBuyLabel.layer.borderWidth = 1.5
        
        productImage.image = productImageData
        productNameLabel.text = productData.name
        unitLabel.text = productData.unit
        pricePerUnitLabel.text = "$\(String(productData.price))"
        
        quantityToBuyStepper.minimumValue = 1.0
        quantityToBuyStepper.maximumValue = 100.0
        quantityToBuyStepper.stepValue = 1.0
        quantityToBuyStepper.value = 1.0
        quantityToBuyLabel.text = String(Int(quantityToBuyStepper.value))
        
        buyButton.layer.cornerRadius = 5
    }
    
    @IBAction func changeQuantity(_ sender: UIStepper) {
        quantityToBuyLabel.text = String(Int(quantityToBuyStepper.value))
    }
    
    
    @IBAction func buyProduct(_ sender: UIButton) {
        let quantity = Int(quantityToBuyLabel.text ?? "0")!
        let productToBuy = ProductInKart(product: productData, quantity: quantity)
        if let delegate = delegate {
            delegate.addProductToKart(withParameter: productToBuy)
        }

        let addToCartConfirmation = UIAlertController(title: "Producto agregado", message: productData.name, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: {action in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        addToCartConfirmation.addAction(okAction)
        present(addToCartConfirmation, animated: true, completion: nil)
    }
    

}
