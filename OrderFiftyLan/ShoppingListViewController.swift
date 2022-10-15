//
//  ShoppingListViewController.swift
//  OrderFiftyLan
//
//  Created by kuani on 2022/10/7.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countLabel: UILabel!
    
    let url = URL(string: "https://sheetdb.io/api/v1/3ygweb47u7mgi")!
    
    var orderList = [OrderList]()
    //var sum = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
        //totalLabel.text = String(sum)
    }
    
    //進購物車頁面再抓一次資料
    func fetchData(){
        var sum = 0     //位置很重要
        var index = 0
        let url = URL(string: "https://sheetdb.io/api/v1/3ygweb47u7mgi")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data{
                do{
                    let decoder = JSONDecoder()
                    self.orderList = try decoder.decode([OrderList].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        for _ in self.orderList{
                            
                            //var index = 0
                            sum += Int(self.orderList[index].price) ?? 0
                            index += 1
                            self.totalLabel.text = String(sum)
                            self.countLabel.text = String(index)
                        }
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func sentAndDelete(_ sender: UIButton) {
        if totalLabel.text == "" || totalLabel.text == "0"{
            let alertController = UIAlertController(title: "錯誤", message:"訂單異常！", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            totalLabel.text = ""
            countLabel.text = ""
        }
        
        else{
            //送出訂單清空資料
            let alertController = UIAlertController(title: "確認訂餐", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default) { _ in
                var request = URLRequest(url: URL(string: "https://sheetdb.io/api/v1/3ygweb47u7mgi/orderno/1")!)
                
                request.httpMethod = "delete"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if data != nil{
                        DispatchQueue.main.async {
                            self.fetchData()
                            self.tableView.reloadData()
                            self.totalLabel.text = ""
                            self.countLabel.text = ""
                        }
                    }
                }.resume()
                let controller = UIAlertController(title: "完成", message: "成功完成訂餐", preferredStyle: .alert)
                let iKnowAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(iKnowAction)
                self.present(controller, animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
}

extension ShoppingListViewController:UITableViewDelegate,UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "\(ShoppingListTableViewCell.self)", for: indexPath) as! ShoppingListTableViewCell
         let item = orderList[indexPath.row]
         
         
         cell.drinksPic.image = UIImage(named: item.pic)
         cell.drinksName.text = item.name
         cell.drinksSize.text = item.size
         cell.drinksSugar.text = item.sugar
         cell.drinksIce.text = item.ice
         cell.drinksPrice.text = item.price
         /*
         item.itemNumber = String(indexPath.row + 1)
         cell.drinksItemNumber.text = item.itemNumber
          */
         /*
         if item.size == "大杯"{
             sum += Int(item.price)!
         }
         else if item.size == "中杯"{
             sum += Int(item.price)!
         }
         */
         
     return cell
     }
    
    //刪除單筆欄位
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let sum = 0     
        let index = 0
        let alertController = UIAlertController(title: "確定要刪除嗎?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default) { _ in
            
            var request = URLRequest(url: URL(string: "https://sheetdb.io/api/v1/3ygweb47u7mgi/userName/\(self.orderList[indexPath.row].userName)")!)
            
            request.httpMethod = "delete"
            URLSession.shared.dataTask(with: request){ data, response, error in
                if data != nil{
                    DispatchQueue.main.async {
                        self.fetchData()
                        self.tableView.reloadData()
                        self.totalLabel.text = String(sum)
                        self.countLabel.text = String(index)
                        }
                }
            }.resume()
            let controller = UIAlertController(title: "完成", message: "成功刪除訂單", preferredStyle: .alert)
            let iKnowAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(iKnowAction)
            self.present(controller, animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
