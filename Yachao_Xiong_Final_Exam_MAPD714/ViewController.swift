//
//  ViewController.swift
//  Yachao_Xiong_Final_Exam_MAPD714
//
//  Created by Yachao on 2022-12-09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var historyBtn: UIButton!
    
    @IBOutlet weak var BottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyBtn.layer.cornerRadius = historyBtn.frame.width / 2
        historyBtn.layer.masksToBounds = true
    }

    @IBAction func ListBtn_pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ListScreen") as! ListController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
}

