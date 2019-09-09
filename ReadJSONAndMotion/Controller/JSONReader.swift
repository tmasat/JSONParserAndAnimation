//
//  JSONReader.swift
//  ReadJSONAndMotion
//
//  Created by Çağrı Tuğberk MASAT on 6.09.2019.
//  Copyright © 2019 Çağrı Tuğberk MASAT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let DataUrl = "https://5d710cc4d3448a001411b3c5.mockapi.io/tugberk/data"

var dataNames : String = "" //This variable will help me to request .get method by using parameter
var namesArray = [String]()
let params : [String : String] = ["people" : dataNames]
let imageArray = ["pokemon1", "pokemon2", "pokemon3", "pokemon4", "pokemon5"]
let backgroundImageArray = ["pokemonBackground1", "pokemonBackground2", "pokemonBackground3", "pokemonBackground4", "pokemonBackground5", ]


    
class JSONReader: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: - Protocols
        /***********************************************************************************/
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        getMyDatas(DataUrl: DataUrl, parameters: params)
    }
    
    
    //MARK: - Networking
    /***********************************************************************************/
    
   func getMyDatas(DataUrl: String, parameters: [String : String]){
        
        Alamofire.request(DataUrl, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                //Success !
                let namesJSON : JSON = JSON(response.result.value!)
                self.updateMyDatas(json: namesJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***********************************************************************************/
    
    //Writing updateMyDatas
    //This function will take JSONDatas as a variable from getMyDatas function
    //Then append values inside of namesArray variable
    
    func updateMyDatas(json : JSON){
        
        //First i need to learn how many people are inside of people array(JSON)
        let peopleNumber : Int = json["people"].count
        
        //Now I will create a FOR loop to append all names one by one
            for i in 0..<peopleNumber{
                namesArray.append("\(json["people"][i])")
            }

        //myTableView loaded without namesArray variables.
        self.myTableView.reloadData()
        
    }
        
        
        
        //MARK: - UI Update For TableView
        /***********************************************************************************/
    
        // 1 - How many elements inside of namesArray
        // 2 - Create a new cell for each data
        // 3 - Create a function that makes clickable for each cells then navigate to new page with clicked cell's informations
    
            
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return namesArray.count
            }
            

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
                
                cell.imgImage.image = UIImage(named: imageArray[indexPath.row])
                cell.lblname.text = namesArray[indexPath.row]

                return cell
            }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                let Storyboard = UIStoryboard(name: "Main", bundle: nil)
                let DvC = Storyboard.instantiateViewController(withIdentifier: "Motion") as! Motion
        
                var temp : Int = indexPath.row
            
                    if temp > 4 { //imageArray contains 5 different images. That means 6. person will not have an image without it.
                            temp = Int.random(in: 0 ... 4)
                                }
        
                DvC.getBackgroundImage = backgroundImageArray[temp]
                DvC.getImage = imageArray[temp]
                DvC.getName = namesArray[indexPath.row]
        
        
                self.navigationController?.pushViewController(DvC, animated: true)
        
    }
}
        


