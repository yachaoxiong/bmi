//
//  BMITableViewCell.swift
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

class BMITableViewCell: UITableViewCell {
    
    @IBOutlet weak var weight: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bmi: UILabel!
}
