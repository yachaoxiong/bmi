//
//  ViewController.swift
//  Yachao_Xiong_Final_Exam_MAPD714
//
//  Created by Yachao on 2022-12-09.
//

import UIKit

class ViewController: UIViewController {
    
    var bmiUnit = "metric"
    @IBOutlet weak var metricBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
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
        historyBtn.layer.cornerRadius = historyBtn.frame.width / 2
        historyBtn.layer.masksToBounds = true
        metricBtn.backgroundColor = .systemGreen
        metricBtn.tintColor = .systemGreen
        ImperialBtn.backgroundColor = .white
        ImperialBtn.tintColor  = .white
        
        pregressBar.tintColor = .systemRed
        pregressBar.progress = 0
    }

    @IBAction func ListBtn_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ListScreen") as! ListController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    // calculate the bmi value and store it using user
    @IBAction func submit_pressed(_ sender: Any) {
        var arr =  UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
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
        
        var dict = [String:String]()
        dict["name"] = currentName
        dict["age"] = String(currentAge!)
        dict["weight"] = String(currentWeight!)
        dict["height"] = String(currentHeight!)
        dict["gender"] = currentGender
        dict["bmiValue"] = String(currentBMIValue)
        dict["bmiMessage"] = currentBMIMessage
        arr.append(dict)
        UserDefaults.standard.set(arr,forKey:"BMIList")
    }
    @IBAction func bmiUnit_toggle(_ sender: UIButton) {
        print("pressed")
        sender.backgroundColor = .white
        sender.tintColor = .white
        if(sender.tag == 0){
            print("metric btn")
            bmiUnit = "metric"
            metricBtn.backgroundColor = .systemGreen
            metricBtn.tintColor = .systemGreen
            ImperialBtn.backgroundColor = .white
            ImperialBtn.tintColor  = .white
        }else{
            print("imperial btn")
            bmiUnit = "imperial"
            metricBtn.backgroundColor = .white
            metricBtn.tintColor  = .white
            ImperialBtn.tintColor = .systemGreen
            ImperialBtn.backgroundColor = .systemGreen
         
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

