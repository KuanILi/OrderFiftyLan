//
//  EditTableViewController.swift
//  OrderFiftyLan
//
//  Created by kuani on 2022/10/7.
//

import UIKit

class EditTableViewController: UITableViewController,UITextFieldDelegate {
    
    var drinksInfo:DrinksInfo!
    var orderInfo = [OrderList]()
  
    

    @IBOutlet weak var drinksPicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aPriceLabel: UILabel!
    
    @IBOutlet weak var largeSizeBtn: UIButton!
    @IBOutlet weak var smallSizeBtn: UIButton!
    
    @IBOutlet weak var normalSugar: UIButton!
    @IBOutlet weak var halfSugar: UIButton!
    @IBOutlet weak var alittleSugar: UIButton!
    @IBOutlet weak var noSugar: UIButton!
    
    @IBOutlet weak var normalIce: UIButton!
    @IBOutlet weak var alittleIce: UIButton!
    @IBOutlet weak var noIce: UIButton!
    
    @IBOutlet weak var userName: UITextField!
    
    var size = ""
    var sugar = ""
    var ice = ""
    var no = 1
    
    let url = URL(string: "https://sheetdb.io/api/v1/3ygweb47u7mgi")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        drinksPicture.image = UIImage(named: drinksInfo.drinksPicture)
        nameLabel.text = drinksInfo.chName
       //fetchData()
        userName.delegate = self
    }
    //按return關閉鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
            return true
    }
    
    /*
    func fetchData(){
        let url = URL(string: "https://sheetdb.io/api/v1/s6eajx0aof1ij")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data{
                do{
                    let decoder = JSONDecoder()
                    self.orderInfo = try decoder.decode([OrderList].self, from: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch{
                    print(error)
                }
            }
        }.resume()
    }
    */
    
    
    //選擇大小杯
    
    @IBAction func selectSize(_ sender: UIButton) {
        largeSizeBtn.isSelected = true
        //largeSizeBtn.setTitle(nil, for: .selected)
        aPriceLabel.text = drinksInfo.larPrice
        smallSizeBtn.isSelected = false
        size = "大杯"
        
    }
    @IBAction func selectSmallSize(_ sender: UIButton) {
        smallSizeBtn.isSelected = true
        //smallSizeBtn.setTitle(nil, for: .selected)
        aPriceLabel.text = drinksInfo.midPrice
        largeSizeBtn.isSelected = false
        size = "中杯"
    }
    
    //選擇甜度
    
    @IBAction func selectNormalSugar(_ sender: UIButton) {
        normalSugar.isSelected = true
        halfSugar.isSelected = false
        alittleSugar.isSelected = false
        noSugar.isSelected = false
        sugar = "正常"
    }
    
    @IBAction func selectHalfSugar(_ sender: UIButton) {
        normalSugar.isSelected = false
        halfSugar.isSelected = true
        alittleSugar.isSelected = false
        noSugar.isSelected = false
        sugar = "半糖"
    }
    
    @IBAction func selectAlittleSugar(_ sender: UIButton) {
        normalSugar.isSelected = false
        halfSugar.isSelected = false
        alittleSugar.isSelected = true
        noSugar.isSelected = false
        sugar = "微糖"
    }
    
    @IBAction func selectNoSugar(_ sender: UIButton) {
        normalSugar.isSelected = false
        halfSugar.isSelected = false
        alittleSugar.isSelected = false
        noSugar.isSelected = true
        sugar = "無糖"
    }
    
    //選擇冰塊
    
    @IBAction func selectNormalIce(_ sender: UIButton) {
        normalIce.isSelected = true
        alittleIce.isSelected = false
        noIce.isSelected = false
        ice = "正常"
    }
   
    @IBAction func selectAlittleIce(_ sender: UIButton) {
        normalIce.isSelected = false
        alittleIce.isSelected = true
        noIce.isSelected = false
        ice = "少冰"
    }
    
    @IBAction func selectNoIce(_ sender: UIButton) {
        normalIce.isSelected = false
        alittleIce.isSelected = false
        noIce.isSelected = true
        ice = "去冰"
    }
    
    
    //上傳資料
    @IBAction func sentData(_ sender: Any) {
    /*https://sheetdb.io/api/v1/s6eajx0aof1ij*/
   
        let name = nameLabel.text ?? ""
        let size = size
        let sugar = sugar
        let ice = ice
        let pic = drinksInfo.drinksPicture
        let price = aPriceLabel.text ?? ""
        let number = no
        let user = userName.text ?? ""
        let orderList = OrderList(name: name, size: size, sugar: sugar, ice: ice, pic: pic, price: price, orderno: String(number),userName: user)
        
        var request = URLRequest(url: url)
        
        //檢查欄位是否都有選擇
        if largeSizeBtn.isSelected == true || smallSizeBtn.isSelected == true,
           normalSugar.isSelected == true || halfSugar.isSelected == true || alittleSugar.isSelected == true || noSugar.isSelected == true,
           normalIce.isSelected == true || alittleIce.isSelected == true || noIce.isSelected == true {
            if userName.text != ""{
                let alertController = UIAlertController(title: "完成", message: "成功加入購物車！", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
                request.httpMethod = "post"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let encoder = JSONEncoder()
                let data = try? encoder.encode(orderList)
                request.httpBody = data
                URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                    if data != nil{
                        
                        //print("123")
                        /*
                         let decoder = JSONDecoder()
                         let createUserResponse = try decoder.decode(DrinksInfo.self, from: data)
                         
                         print(createUserResponse)
                         */
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    
                }.resume()
           }
            else{
                let alertController = UIAlertController(title: "錯誤", message:"表單填寫異常！", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }else{
            let alertController = UIAlertController(title: "錯誤", message:"表單填寫異常！", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

