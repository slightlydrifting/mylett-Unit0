//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Lisa Mylett on 8/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
        
    @IBOutlet weak var tipRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //change textfield's keyboard to number pad with decimal
        billAmountTextField.keyboardType = .decimalPad
        //set first responder
        billAmountTextField.becomeFirstResponder()
    }
    
    //bill amount changed, so grab the current tip rate and recalculate total
    @IBAction func billAmountChanged(_ sender: Any) {
        let tipRate = getCurrentTipRate()
        calculateTip(tipPercent: Double(tipRate))
    }
    
    //gets current tip rate as int
    //i had to do this in its own function
    //when implemented inside another event, it crashed due to unwrapping nil
    func getCurrentTipRate() -> Double{
        let tipRate = Double(tipRateLabel.text!) ?? 0
        return tipRate/100
    }
    
    //This function adds a tip to the Bill amount and outputs a total amount
    //This function is called when the textfield is edited
    //This function is called when the Tip Rate has changed
    func calculateTip(tipPercent: Double){
        var tip = 0.00
        var total = 0.00
        
        //Get Bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //Get Total tip by multiplying tip * Percentage
        tip = bill * tipPercent
        total = bill + tip
        
        //Update Tip Rate text field
        //Tricking the
        tipRateLabel.text = String(format: "%.0f", tipPercent * 100)
        //Update Tip Amount Label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        //Update Total Amount
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    //Segmented control selection value has changed
    //recalculate tip and total
    @IBAction func tipPresetChanged(_ sender: Any) {
        let tipPercentages = [0.15,0.18,0.2,0.25]
        let tip = tipPercentages[tipControl.selectedSegmentIndex]
        tipSlider.value = Float(tip * 100)
        calculateTip(tipPercent: tip)
    }
    
    //Slider bar control value has changed
    //recalculate tip and total
    @IBAction func tipSliderChanged(_ sender: Any) {
        let sliderInt = Int(tipSlider.value)
        let tip = Double(sliderInt) * 0.01
        calculateTip(tipPercent: tip)
    }
    
}

