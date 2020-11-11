//
//  AllOrderViewController.swift
//  RestaurantOrder
//
//  Created by Клим on 21.10.2020.
//

import UIKit

class AllOrderViewController: UIViewController {
    
    private let detailSegueId = "showOrder"
    
    @IBOutlet weak var OrderList: UITableView!
    
    //MARK:- Database
    private var Orders = [ Order(dishList: [Dish(name : "Ice Cream", price : 12.0, amount : 2), Dish(name : "Lobster", price : 24.0, amount : 1), Dish(name : "Lobster", price : 24.0, amount : 2), Dish(name : "Lobster", price : 24.0, amount : 3), Dish(name : "Ice Cream", price : 12.0, amount : 2) ], fName: "John", sName: "Malkovich", bill: 0.0, tipAm: 0.0) ]
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureOrderTable()
    }
    
    
    
    @IBAction func AddOrderButton(_ sender: Any) {
        inputNewOrder()
    }
    
    //MARK:- New order input
    func inputNewOrder(){
        let alert = UIAlertController(title: "Input new Order", message: "", preferredStyle: .alert)
        
        let addlButton = UIAlertAction(title: "Add", style: .default){ (action) in
            let firstName = alert.textFields![0].text!
            let secondName = alert.textFields![1].text!
            let order = Order(dishList: [], fName: firstName, sName: secondName, bill: 0.0, tipAm: 0.0)
            
            self.Orders.append(order)
            self.updateUI()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField{(field) in field.placeholder = "First name of client"}
        alert.addTextField{(field) in field.placeholder = "Second name of client"}

        
        alert.addAction(addlButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func configureOrderTable(){
        OrderList.delegate = self
        OrderList.dataSource = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case detailSegueId:
            guard let vc = segue.destination as? DetailedOrderViewController,
                  let order = sender as? Order
            else { fatalError("Invalid data passed") }
            vc.order = order
            vc.parentVC = self
            
        default:
            break
        }
    }
    
    
    func updateUI() {
        OrderList.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }


}


//MARK:- UITable extension
extension AllOrderViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Orders.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Orders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as! OrderCell
        
        let currOrder = Orders[indexPath.row]
        
        cell.ClientName.text = currOrder.fullName
        cell.OrderTitle.text = " Order #\(indexPath.row + 1)"
        cell.billLabel.text = "Total: \(currOrder.bill) $"
        cell.tipLabel.text = "Tip left: \(currOrder.tipAm) $"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = Orders[indexPath.row]
        
        performSegue(withIdentifier: detailSegueId, sender: order)
    }
}

