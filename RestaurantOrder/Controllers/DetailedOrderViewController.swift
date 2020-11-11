//
//  DetailedOrderViewController.swift
//  RestaurantOrder
//
//  Created by Клим on 21.10.2020.
//

import UIKit

class DetailedOrderViewController: UIViewController {
    
    
    @IBOutlet private weak var dishStack: UIStackView!
    
    @IBOutlet private weak var blankListLabel: UILabel!
    
    var order: Order!
    private var dishes: [Dish]!
    
    weak var parentVC: AllOrderViewController!

    override func viewDidLoad() {
        dishes = order.dishList
        super.viewDidLoad()
        configureStack()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        order.dishList = dishes
        parentVC.updateUI()
    }
    
    //MARK:- Stack config
    func configureStack(){
        if (dishes.count != 0){
            blankListLabel.isHidden = true
        }
        
        dishes.forEach{ dish in
            let horStc = UIStackView()
            horStc.axis = NSLayoutConstraint.Axis.vertical
            horStc.spacing = 5
            let name = UILabel()
            name.text = dish.name
            let amount = UILabel()
            amount.text = "Amount: \(dish.amount)"
            let price = UILabel()
            price.text = "Total price: \(Double(dish.amount) * dish.price)"
            
            horStc.addArrangedSubview(name)
            horStc.addArrangedSubview(amount)
            horStc.addArrangedSubview(price)
            
            dishStack.addArrangedSubview(horStc)
        }
    }
    
    
    func noAlert(){
        let alert = UIAlertController(title: "You can't do that", message: "", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showBill":
            guard let vc = segue.destination as? TipNBillViewController,
                  let bill = sender as? Double
            else { fatalError("Invalid data passed") }
            vc.bill = bill
            vc.parentVC = self
        
        default:
            break
        }
    }
    
    
    
    
    @IBAction func CalculateSumButton(_ sender: Any) {
        if (dishes.count == 0){
            noAlert()
        }
        else{
        let bill = calculateBill()
        performSegue(withIdentifier: "showBill", sender: bill)
        }
    }
    
    
    func calculateBill() -> Double{
        var sum = 0.0
        dishes.forEach{ dish in
            sum += Double(dish.amount) * dish.price
        }
        return sum
    }
    
    
  
    
    @IBAction func ClearStackButton(_ sender: Any) {
        if (dishes.count == 0){
            noAlert()
        }
        else{
            dishes.removeAll()
            dishStack.removeAllArrangedSubviews()
            blankListLabel.isHidden = false
            configureStack()
            parentVC.updateUI()
        }
    }
    
    
    //MARK:- Add new dish button
    @IBAction func AddDishButton(_ sender: Any) {
        inputNewDish()
    }
    
    
    func inputNewDish(){
        let alert = UIAlertController(title: "Input new Dish", message: "", preferredStyle: .alert)
        
        let addlButton = UIAlertAction(title: "Add", style: .default){ (action) in
            let dishName = alert.textFields![0].text!
            let amount = Int(alert.textFields![1].text!)
            let price = Double(alert.textFields![2].text!)
            let dish = Dish(name: dishName, price: price!, amount: amount!)
            
            self.dishes.append(dish)
            self.dishStack.removeAllArrangedSubviews()
            self.configureStack()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField{(field) in field.placeholder = "Name of the dish"}
        alert.addTextField{(field) in
            field.placeholder = "Amount"
            field.keyboardType = .numberPad
        }
        alert.addTextField{(field) in
            field.placeholder = "Price"
            field.keyboardType = .numberPad
        }

    
        alert.addAction(addlButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}




//MARK:- Clear Stack function

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
