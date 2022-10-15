//
//  DrinksMenuTableViewController.swift
//  OrderFiftyLan
//
//  Created by kuani on 2022/10/7.
//

import UIKit

class DrinksMenuTableViewController: UITableViewController {
    
    
    
    var drinksMenu = [DrinksInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDrinks()
        
    }
    /*
    let homeVC = DrinksMenuTableViewController()
    let tabbarController = UITabBarController()
    func goHome(){
        tabbarController.selectedIndex = homeVC
    }
    */
    
    //抓飲料目錄
    func showDrinks(){
        if let urlString = "https://sheetdb.io/api/v1/0inuu5ns8mxcw".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data{
                    let decoder = JSONDecoder()
                    do{
                        let result = try decoder.decode([DrinksInfo].self, from: data)
                        self.drinksMenu = result
                        
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
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinksMenu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DrinksMenuTableViewCell.self)", for: indexPath) as! DrinksMenuTableViewCell
        let item = drinksMenu[indexPath.row]
        cell.drinksPicture.image = UIImage(named: item.drinksPicture)
        cell.chineseName.text = item.chName
        cell.englishName.text = item.engName
        cell.midPrice.text = item.midPrice
        cell.larPrice.text = item.larPrice
        // Configure the cell...

        return cell
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEdit"{
            if let indexpath = tableView.indexPathForSelectedRow{
                let controller = segue.destination as! EditTableViewController
                controller.drinksInfo = drinksMenu[indexpath.row]
            }
        }
    }
    /*
    @IBAction func unwindToDrinksMenuTableView(_ unwindSegue: UIStoryboardSegue) {
      
        let source = unwindSegue.source as! EditTableViewController
        

        // Use data from the view controller which initiated the unwind segue
    }
     */
}


