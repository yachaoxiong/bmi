//
//  ListController.swift
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

class ListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var viewInfo: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var listTable: UITableView!
    var bmiList = [[String:String]]()
    let userInfo =  UserDefaults.standard.object(forKey: "userInfo") as? [String:String] ?? [:]
    @IBOutlet weak var listTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
        addBtn.layer.cornerRadius = addBtn.frame.width / 2
        addBtn.layer.masksToBounds = true
        viewInfo.layer.cornerRadius = addBtn.frame.width / 2
        viewInfo.layer.masksToBounds = true
        initData()
        listTable.dataSource = self
        listTable.delegate = self
        listTitle.text = String((userInfo["name"] ?? "") + " BMI List")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initData()
        listTable.dataSource = self
        listTable.delegate = self
        listTable.reloadData()
    }
    // init data
    func initData(){
        bmiList = UserDefaults.standard.object(forKey: "BMIList") as? [[String:String]] ?? [[String:String]]()
    }
    // table rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bmiList.count
    }
   func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       // Make the first row larger to accommodate a custom cell.
      if indexPath.row != -1 {
          return 60
       }

       // Use the default size for all other rows.
       return UITableView.automaticDimension
    }
    // set data for every row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list =  bmiList[indexPath.row]
        let cell =  listTable.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as? BMITableViewCell
        if(list["bmiUnit"] == "metric"){
            cell?.weight.text = String((list["weight"]!) + "Kg")
        }else{
            cell?.weight.text = String((list["weight"]!) + "Ibs")
        }
      
        cell?.bmi.text = list["bmiValue"]
        cell?.date.text = list["date"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let config = UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath),
            updateBMIRecord(forRowAt: indexPath)
        ])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    // remove the row data from the table and storage.
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
          return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
              
                   // remove the row and  data from table
                   self.bmiList.remove(at: indexPath.row)
                   self.listTable.deleteRows(at: [indexPath], with: .automatic)
              
                   // update the data from storage
                   UserDefaults.standard.set(self.bmiList, forKey:"BMIList")
                   
              if(self.bmiList.count == 0){
                  let vc = self.storyboard?.instantiateViewController(identifier: "main") as! ViewController
                  vc.modalPresentationStyle = .fullScreen
                  self.present(vc,animated: true)
              }
                    
                   completion(true)
             
          }
    }
    private func updateBMIRecord(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let config = UIContextualAction(style: .normal, title: "update") { (action, swipeButtonView, completion) in
              
            let index = indexPath.row
            let vc =  self.storyboard?.instantiateViewController(identifier: "action") as! ActionViewController
            vc.title = "update"
            vc.selectedOne = index
            self.present(vc,animated: true)
            
          }
        // set swipe color
        config.backgroundColor = .systemYellow
        
        return config
       
    }

    @IBAction func AddNew(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "action") as! ActionViewController
        vc.title = "add"
        present(vc,animated: true)
    }
    
    @IBAction func backToMain(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "main") as! ViewController
        vc.title = "view info"
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
}
