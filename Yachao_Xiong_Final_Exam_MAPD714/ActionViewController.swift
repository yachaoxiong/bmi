//
//  ActionViewController.swift
//  Yachao_Xiong_Final_Exam_MAPD714
//
//  App Name: BMI
//  Course : MAPD714
//  Author : Yachao Xiong 301298033
//
//
//  App Revision History
//  V1.0 add first screen ui                            -  2022-12-15
//  V1.1 update ui                                      -  2022-12-15
//  V1.2 added first screen functions                   -  2022-12-15
//  V1.3 added first screen functions                   -  2022-12-15
//  V1.4 added list and edit screens and functions      -  2022-12-15
//
//  About the App
//  This app is to calculate and track BMI
//
//  Created by Yachao on 2022-12-15
//
//

import UIKit

class ActionViewController: UIViewController {
    var bmiUnit = "metric"
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var bmiDate: UIDatePicker!
    @IBOutlet weak var bmiValue: UILabel!
    @IBOutlet weak var bmiMessage: UILabel!
    @IBOutlet weak var ImperialBtn: UIButton!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var metricBtn: UIButton!
    var selectedOne = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initActionView()
    }
    func initActionView(){
        if(self.navigationItem.title == "add"){
            screenTitle.text = "Add New BMI"
            metricBtn.backgroundColor = .systemGreen
            metricBtn.tintColor = .systemGreen
            ImperialBtn.backgroundColor = .white
            ImperialBtn.tintColor  = .white
            heightInput.placeholder = "Enter height(cm)"
            weightInput.placeholder = "Enter weight(kg)"
        }else{
            screenTitle.text = "Update Your BMI"
            var arr =  UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
            
            if(arr[selectedOne]["bmiUnit"] == "metric"){
                bmiUnit = "metric"
                metricBtn.backgroundColor = .systemGreen
                metricBtn.tintColor = .systemGreen
                ImperialBtn.backgroundColor = .white
                ImperialBtn.tintColor  = .white
            }else{
                bmiUnit = "imperial"
                metricBtn.backgroundColor = .white
                metricBtn.tintColor = .white
                ImperialBtn.backgroundColor = .systemGreen
                ImperialBtn.tintColor  = .systemGreen
            }
            
            let dateFormatter = DateFormatter()
            print(arr[selectedOne]["date"])
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let newDate = dateFormatter.date(from: arr[selectedOne]["date"] ?? "")
            bmiDate.date = newDate!
            
            weightInput.text = arr[selectedOne]["weight"]
            heightInput.text = arr[selectedOne]["height"]
            bmiValue.text = arr[selectedOne]["bmiValue"]
            bmiMessage.text = arr[selectedOne]["bmiMessage"]
            bmiMessage(Double(arr[selectedOne]["bmiValue"]!) ?? 0)
        }
    }
    @IBAction func backToList(_ sender: Any) {
        goBack()
    }
    
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleBMIUnit(_ sender: UIButton) {
        if(sender.tag == 0){
            print("metric btn")
            bmiUnit = "metric"
            metricBtn.backgroundColor = .systemGreen
            metricBtn.tintColor = .systemGreen
            ImperialBtn.backgroundColor = .white
            ImperialBtn.tintColor  = .white
            
            heightInput.placeholder
             = "Enter height(cm)"
            weightInput.placeholder = "Enter weight(kg)"
        }else{
            print("imperial btn")
            bmiUnit = "imperial"
            metricBtn.backgroundColor = .white
            metricBtn.tintColor  = .white
            ImperialBtn.tintColor = .systemGreen
            ImperialBtn.backgroundColor = .systemGreen
            heightInput.placeholder
             = "Enter height(Inches)"
            weightInput.placeholder = "Enter weight(Pounds)"
        }
        resetForm()
    }
    func resetForm(){
        weightInput.text = ""
        heightInput.text = ""
        bmiValue.text = ""
        bmiMessage.text = ""
        progressBar.progress = 0
    }
    @IBAction func calculateBMI(_ sender: Any) {
        if((weightInput.text == "") || (heightInput.text == "")) {
            let alert = UIAlertController(title: "Warning", message: "Please fill in all information", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: {
                _ in
            }))

            present(alert,animated: true,completion: nil)
        }else{
            
            let currentWeight = Double(weightInput.text!)
            let currentHeight = Double(heightInput.text!)
            var currentBMIValue = round(calculateBMI(currentHeight!, currentWeight!))
            let currentBMIMessage = bmiMessage(currentBMIValue)
            bmiValue.text =  String(currentBMIValue)
            bmiMessage.text = currentBMIMessage
            
        }
        
    }
    @IBAction func AddNewBMI(_ sender: Any) {
        
        var arr =  UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
        if((weightInput.text == "") || (heightInput.text == "")) {
            let alert = UIAlertController(title: "Warning", message: "Please fill in all information", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: {
                _ in
            }))

            present(alert,animated: true,completion: nil)
        }else{
            
      
        let currentWeight = Double(weightInput.text!)
        let currentHeight = Double(heightInput.text!)
        var currentBMIValue = round(calculateBMI(currentHeight!, currentWeight!))
        print(currentBMIValue)
        let currentBMIMessage = bmiMessage(currentBMIValue)
        
        
        
        bmiValue.text =  String(currentBMIValue)
        bmiMessage.text = currentBMIMessage
        let currentDate =  bmiDate.date
        var dict = [String:String]()

        if(self.navigationItem.title == "add"){
            
            dict["weight"] = String(currentWeight!)
            dict["height"] = String(currentHeight!)
            dict["bmiValue"] = String(currentBMIValue)
            dict["bmiMessage"] = currentBMIMessage
            dict["bmiUnit"] = bmiUnit
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dict["date"] = dateFormatter.string(from: bmiDate.date)
            arr.append(dict)
        }else{
            arr[selectedOne]["weight"] = String(currentWeight!)
            arr[selectedOne]["height"] = String(currentHeight!)
            arr[selectedOne]["bmiValue"] = String(currentBMIValue)
            arr[selectedOne]["bmiMessage"] = currentBMIMessage
            arr[selectedOne]["bmiUnit"] = bmiUnit
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            arr[selectedOne]["date"] = dateFormatter.string(from: bmiDate.date)
        }
        UserDefaults.standard.set(arr,forKey:"BMIList")
        goBack()
      }
    }
    
    func calculateBMI( _ height: Double, _ weight:  Double )->Double{
        if(bmiUnit == "metric"){
            return  weight / pow((height / 100), 2)
        }else{
            return weight / (height * height) * 703;
        }
      
    }
    func bmiMessage(_ bmi:Double) -> String {
        if(bmi < 16){
            progressBar.tintColor = .systemRed
            progressBar.progress = 0.1
            return "Servere Thinness"
        }else if(bmi >= 16 && bmi < 17){
            progressBar.tintColor = .systemGray5
            progressBar.progress =  0.2
            return "Moderate Thinness"
        }else if(bmi >= 17 && bmi <= 18.5){
            progressBar.tintColor = .systemGray2
            progressBar.progress = 0.35
            return "Mild Thinness"
        }else if(bmi > 18.5 && bmi <= 25){
            progressBar.tintColor = .systemGreen
            progressBar.progress = 0.50
            return "Normal"
        }else if(bmi > 25 && bmi <= 30){
            progressBar.tintColor = .systemYellow
            progressBar.progress = 0.60
            return "Overweight"
        }else if(bmi > 30 && bmi <= 35){
            progressBar.tintColor = .systemBrown
            progressBar.progress = 0.70
            return "Obese Class |"
        }else if(bmi > 35 && bmi <= 40){
            progressBar.tintColor = .systemRed
            progressBar.progress = 0.80
            return "Obese Class ||"
        }else{
            progressBar.tintColor = .systemRed
            progressBar.progress = 1
            return "Obese Class |||"
        }
    }
}
