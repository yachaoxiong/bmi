//
//  ViewController.swift
//  Yachao_Xiong_Final_Exam_MAPD714
//
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

class ViewController: UIViewController {
    
    var bmiUnit = "metric"

    @IBOutlet weak var backToList: UIButton!
    @IBOutlet weak var metricBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var ImperialBtn: UIButton!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var pregressBar: UIProgressView!
    @IBOutlet weak var bmiValue: UILabel!
    @IBOutlet weak var bmiMessage: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var genderInput: UITextField!
    @IBOutlet weak var ageInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBtn.layer.cornerRadius = doneBtn.frame.width / 2
        doneBtn.layer.masksToBounds = true
        backToList.layer.cornerRadius = backToList.frame.width / 2
        backToList.layer.masksToBounds = true
        metricBtn.backgroundColor = .systemGreen
        metricBtn.tintColor = .systemGreen
        ImperialBtn.backgroundColor = .white
        ImperialBtn.tintColor  = .white
        pregressBar.tintColor = .systemRed
        pregressBar.progress = 0
        heightInput.placeholder
         = "Enter height(cm)"
        weightInput.placeholder = "Enter weight(kg)"
        initMain()
    }
    
    func initMain(){
        let userInfo =  UserDefaults.standard.object(forKey: "userInfo") as? [String:String] ?? [:]
        var arr =  UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
        backToList.isHidden =  true
        if(arr.count > 0){
            nameInput.text = userInfo["name"]
            ageInput.text = userInfo["age"]
            genderInput.text = userInfo["gender"]
            backToList.isHidden = false
        }
    }
    @IBAction func backToList_pressed(_ sender: Any) {
        if(self.navigationItem.title == "view info"){
            dismiss(animated: true, completion: nil)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: "ListScreen") as! ListController
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: true)
        }
    }
    @IBAction func done_pressed(_ sender: Any) {
        var arr =  UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
            
       if((weightInput.text == "") || (heightInput.text == "") || (ageInput.text == "") || (nameInput.text == "") || (genderInput.text == "")) {
                    let alert = UIAlertController(title: "Warning", message: "Please fill in all information", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: {
                        _ in
                    }))
                    
                    present(alert,animated: true,completion: nil)
                }else{
                    let currentWeight = Double(weightInput.text!)
                    let currentHeight = Double(heightInput.text!)
                    let currentAge = Double(ageInput.text!)
                    let currentName = nameInput.text!
                    let currentGender =  genderInput.text!
                    var currentBMIValue = round(calculateBMI(currentHeight!, currentWeight!))
                    print(currentBMIValue)
                    let currentBMIMessage = bmiMessage(currentBMIValue)
                    
                    let currentDate =  Date()
                    var userInfo = [String:String]()
                    var dict = [String:String]()
                    userInfo["name"] = currentName
                    userInfo["age"] = String(currentAge!)
                    userInfo["gender"] = currentGender
                    
                    
                    dict["weight"] = String(currentWeight!)
                    dict["height"] = String(currentHeight!)
                    dict["bmiValue"] = String(currentBMIValue)
                    dict["bmiMessage"] = currentBMIMessage
                    dict["bmiUnit"] = bmiUnit
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    dict["date"] = dateFormatter.string(from: currentDate)
                    arr.append(dict)
                    UserDefaults.standard.set(arr,forKey:"BMIList")
                    UserDefaults.standard.set(userInfo,forKey:"userInfo")
                    
                    let vc = storyboard?.instantiateViewController(identifier: "ListScreen") as! ListController
                    vc.modalPresentationStyle = .fullScreen
                    present(vc,animated: true)
                }
    }
    // calculate the bmi value and store it using user
    @IBAction func submit_pressed(_ sender: Any) {
        
        if((weightInput.text == "") || (heightInput.text == "") || (ageInput.text == "") || (nameInput.text == "") || (genderInput.text == "")) {
            let alert = UIAlertController(title: "Warning", message: "Please fill in all information", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default,handler: {
                _ in
            }))

            present(alert,animated: true,completion: nil)
        }else{
            
      
        let currentWeight = Double(weightInput.text!)
        let currentHeight = Double(heightInput.text!)
        let currentAge = Double(ageInput.text!)
        let currentName = nameInput.text!
        let currentGender =  genderInput.text!
        var currentBMIValue = round(calculateBMI(currentHeight!, currentWeight!))
        print(currentBMIValue)
        let currentBMIMessage = bmiMessage(currentBMIValue)
        
        
        
        bmiValue.text =  String(currentBMIValue)
        bmiMessage.text = currentBMIMessage
            
        
        }
    }
    @IBAction func bmiUnit_toggle(_ sender: UIButton) {

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
        
    }
    
    @IBAction func resetBMIForm_pressed(_ sender:  UIButton) {
        nameInput.text = ""
        ageInput.text = ""
        weightInput.text = ""
        heightInput.text = ""
        genderInput.text = ""
        bmiValue.text = ""
        bmiMessage.text = ""
        pregressBar.progress = 0
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
            pregressBar.tintColor = .systemRed
            pregressBar.progress = 0.1
            return "Servere Thinness"
        }else if(bmi >= 16 && bmi < 17){
            pregressBar.tintColor = .systemGray5
            pregressBar.progress =  0.2
            return "Moderate Thinness"
        }else if(bmi >= 17 && bmi <= 18.5){
            pregressBar.tintColor = .systemGray2
            pregressBar.progress = 0.35
            return "Mild Thinness"
        }else if(bmi > 18.5 && bmi <= 25){
            pregressBar.tintColor = .systemGreen
            pregressBar.progress = 0.50
            return "Normal"
        }else if(bmi > 25 && bmi <= 30){
            pregressBar.tintColor = .systemYellow
            pregressBar.progress = 0.60
            return "Overweight"
        }else if(bmi > 30 && bmi <= 35){
            pregressBar.tintColor = .systemBrown
            pregressBar.progress = 0.70
            return "Obese Class |"
        }else if(bmi > 35 && bmi <= 40){
            pregressBar.tintColor = .systemRed
            pregressBar.progress = 0.80
            return "Obese Class ||"
        }else{
            pregressBar.tintColor = .systemRed
            pregressBar.progress = 1
            return "Obese Class |||"
        }
    }
}

