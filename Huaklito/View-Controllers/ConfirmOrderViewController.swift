//
//  ConfirmOrderViewController.swift
//  Huaklito
//
//  Created by Ma. de Lourdes Chaparro Candiani on 21/02/20.
//  Copyright © 2020 sgh. All rights reserved.
//

import UIKit

class ConfirmOrderViewController: UIViewController {
    
    
    @IBOutlet weak var productsToBuyTable: UITableView!
    @IBOutlet weak var totalToPayLabel: UILabel!
    @IBOutlet weak var confirmOrderButton: UIButton!
    
    let client = FirebaseClient<Order>()
    
    var productsToBuy : [ProductInKart]?
    var imagesOfProductsToBuy : [UIImage]?
    var userEmail : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView Protocols
        productsToBuyTable.dataSource = self
        productsToBuyTable.delegate = self

        confirmOrderButton.layer.cornerRadius = 5
        
        let total = String(calculateTotalToPay(products: productsToBuy))
        totalToPayLabel.text = "Total: $\(total)"
    }
    

    func calculateTotalToPay(products: [ProductInKart]?) -> Double {
        var totalToPay: Double = 0.0
        if let products = products {
            for product in products {
                totalToPay += (product.product.price*Double(product.quantity))
            }
        }
           return totalToPay
       }
    
    
    @IBAction func confirmOrder(_ sender: UIButton) {
        let order = Order(orderPlacedAt: Date(), totalToPay: calculateTotalToPay(products: productsToBuy))
        client.insertToCollectionWithinDocument(rootCollection: .users, document: userEmail, innerCollection: .orders, objectToInsert: order) {error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
}



//Extension to implement Table View methods
extension ConfirmOrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productsToBuy?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let product = productsToBuy![indexPath.row]
        let totalToPay = Double(product.quantity)*product.product.price
        cell.textLabel?.text = "\(product.quantity) x $\(product.product.price) = $\(totalToPay)"
        cell.detailTextLabel?.text = product.product.name
        cell.imageView?.image = imagesOfProductsToBuy?[indexPath.row]
        return cell
    }

}
