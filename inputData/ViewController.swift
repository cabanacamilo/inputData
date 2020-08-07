//
//  ViewController.swift
//  inputData
//
//  Created by Camilo Cabana on 7/08/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var frecuencyFlyerTextField: UITextField!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var departurePicker: UIDatePicker!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var returnPicker: UIDatePicker!
    @IBOutlet weak var adultsLabel: UILabel!
    @IBOutlet weak var adultsStepper: UIStepper!
    @IBOutlet weak var chldrenLabel: UILabel!
    @IBOutlet weak var chldrenStepper: UIStepper!
    @IBOutlet weak var mealSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        departurePicker.minimumDate = midnightToday
        updateDateView()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let flyerNumber = frecuencyFlyerTextField.text ?? ""
        let departureDate = departurePicker.date
        let returnDate = returnPicker.date
        let numberOfAdults = Int(adultsStepper.value)
        let numberOfChildren = Int(chldrenStepper.value)
        let hasMeal = mealSwitch.isOn
        
        print(firstName, lastName, flyerNumber, departureDate, returnDate, numberOfAdults, numberOfChildren, hasMeal)
    }
    
    func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        returnPicker.minimumDate = departurePicker.date.addingTimeInterval(86400)
        departureLabel.text = dateFormatter.string(from: departurePicker.date)
        returnLabel.text = dateFormatter.string(from: returnPicker.date)
    }
    
    //valueChange action
    
    @IBAction func departurePicker(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    @IBAction func returnPicker(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    let departurePickerCell = IndexPath(row: 1, section: 1)
    let returnPickerCell = IndexPath(row: 3, section: 1)
    let departureCell = IndexPath(row: 0, section: 1)
    let returnCell = IndexPath(row: 2, section: 1)
    
    var isDeparturePickerShown: Bool = false {
        didSet {
            departurePicker.isHidden = !isDeparturePickerShown
        }
    }
    
    var isReturnPickerShown: Bool = false {
        didSet {
            returnPicker.isHidden = !isReturnPickerShown
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case departurePickerCell:
            if isDeparturePickerShown {
                return 215
            } else {
                return 0
            }
        case returnPickerCell:
            if isReturnPickerShown {
                return 215
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case departureCell:
            if isDeparturePickerShown {
                isDeparturePickerShown = false
            } else if isReturnPickerShown {
                isReturnPickerShown = false
                isDeparturePickerShown = true
            } else {
                isDeparturePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case returnCell:
            if isReturnPickerShown {
                isReturnPickerShown = false
            } else if isDeparturePickerShown {
                isDeparturePickerShown = false
                isReturnPickerShown = true
            } else {
                isReturnPickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    func updateNumberOfPassengers() {
        adultsLabel.text = "\(adultsStepper.value)"
        chldrenLabel.text = "\(chldrenStepper.value)"
    }
    
    @IBAction func stepperValueChange(_ sender: UIStepper) {
        updateNumberOfPassengers()
    }
    
    
    @IBAction func mealSwich(_ sender: UISwitch) {
        print("meal has changed")
    }
}

