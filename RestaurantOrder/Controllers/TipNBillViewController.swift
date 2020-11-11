//
//  TipNBillViewController.swift
//  RestaurantOrder
//
//  Created by Клим on 23.10.2020.
//

import UIKit

class TipNBillViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet private weak var billLabel: UILabel!
    
    @IBOutlet private weak var tipAmount5: UILabel!
    
    @IBOutlet private weak var tipAmount3: UILabel!
    
    @IBOutlet private weak var tipAmount15: UILabel!
    
    @IBOutlet private weak var tipAmount10: UILabel!
    
    @IBOutlet private weak var switch5: UISwitch!
    
    @IBOutlet private weak var switch15: UISwitch!
    
    @IBOutlet private weak var switch10: UISwitch!
    
    @IBOutlet private weak var switch3: UISwitch!
    
    
    var bill: Double!
    private var tip: Double! = 0.0
    private var flag: Bool = false
    
    weak var parentVC: DetailedOrderViewController!

    override func viewDidLoad() {
        billLabel.text = "Total: \(bill!) $"
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        parentVC.order.bill = bill
        parentVC.order.tipAm = tip
    }
    
    
    
    
    @IBAction func countTipButton(_ sender: Any) {
        countTip()
        flag = true
    }
    
    
    func countTip(){
        guard
              let number = bill
        else { return }
        var tipAmount: Double
        
        tipAmount = number * 0.05
        tipAmount5.text = "\(Double(round(1000 * tipAmount)/1000)) $"
        
             tipAmount = number * 0.03
            tipAmount3.text = "\(Double(round(1000 * tipAmount)/1000)) $"
        
                tipAmount = number * 0.1
                tipAmount10.text = "\(Double(round(1000 * tipAmount)/1000)) $"
            
             tipAmount = number * 0.15
            tipAmount15.text = "\(Double(round(1000 * tipAmount)/1000)) $"
        
    }

    @IBAction func leaveTipButton(_ sender: Any) {
        let switches = [switch3, switch5, switch10, switch15]
        let tips = [0.03, 0.05, 0.1, 0.15]
        
        if (flag == false){
            tipAlert()
        }
        else{
            var count = 0
            for idx in 0...switches.count - 1{
                if(switches[idx]!.isOn){
                    tip = Double(round(1000 * bill * tips[idx])/1000)
                    count += 1
                }
            }
            if (count == 1){
                tipGivenAlert()
            }
            else{
                tipAlert()
                tip = 0.0
            }
            
        }
    }
    
    
    //MARK:- Tip Alerts
    func tipAlert(){
        var text = "You should count tips first"
        if (flag == true){
            text = "You should choose one tip option :)"
        }
        
        let alert = UIAlertController(title: text, message: "", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    func tipGivenAlert(){
        let alert = UIAlertController(title: "Thats so generous of you!", message: "", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    

}
