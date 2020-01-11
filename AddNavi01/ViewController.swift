//
//  ViewController.swift
//  AddNavi01
//
//  Created by 中塚富士雄 on 2020/01/11.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
//書き始めでclass ViewController　を　拒否られて、この位置でnumberOfRowsInSection、と　cellForRowAtを書くように求められましたが、cellに関する記述の後（67行目以降）でも問題はありませんでした。
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.selectionStyle = .none
//    }
    

    @IBOutlet weak var tableView: UITableView!
    var dataModel = DataModel()
    var mobileArray = [String]()
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
    
       getdata()
    
      
        
        
    }
    
//　　　　　　　　return 1 は、let cell ---- return cell と　競合？するので、拒否られたため、コメントアウトしています。
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//              return 1
//          }
//
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
              cell.selectionStyle = .none
            
            let label1 = cell.contentView.viewWithTag(1) as! UILabel
            label1.adjustsFontSizeToFitWidth = true
            label1.text = self.nameArray[indexPath.row]
            
            let label2 = cell.contentView.viewWithTag(2) as! UILabel
            label2.adjustsFontSizeToFitWidth = true
            label2.text = self.mobileArray[indexPath.row]
            
            return cell
                    
          }
          
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//          return dataModel.count
        print(nameArray.count)
        return(nameArray.count)
        
        
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
          return view.frame.size.height/3
          
      }
    func getdata(){
        
        let text = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=16237d30816b7d5ad81b72368adddef3&name=&address=&category_l="

        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        AF.request(url,method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            
            switch response.result {
                
            case.success:
//                let json : JSON = JSON(response.data as Any)
                for i in 0...9{
                    
                     let json : JSON = JSON(response.data as Any)
                     let name = json["rest"][i]["name"].string
                     let mobile = json["rest"][i]["coupon_url"]["mobile"].string
                    
                    self.nameArray.append(name!)
                    self.mobileArray.append(mobile!)
                    
                }
                break
            
            case.failure(let error):
                print (error)
                break
                
                
            }
            
            self.tableView.reloadData()
            
            
        }
        
    }
    
    
}

