//
//  ViewController.swift
//  players
//
//  Created by Nirendra Singh Rawal on 15/05/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var referencePlayers: DatabaseReference!
    
    
    @IBOutlet weak var textFieldPlayerName: UITextField!
    @IBOutlet weak var textFieldSportName: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var tablePlayers: UITableView!
    
    var playerList = [PlayerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        referencePlayers = Database.database().reference().child("players")
        
        referencePlayers.observe(DataEventType.value, with:{(DataSnapshot) in
            if DataSnapshot.childrenCount > 0 {
                self.playerList.removeAll()
                
                for players in DataSnapshot.children.allObjects as![DataSnapshot] {
                    let playerObject = players.value as? [String: AnyObject]
                    let playerName = playerObject? ["playerName"]
                    let playerSport = playerObject? ["sportName"]
                    let playerAge = playerObject? ["playerAge"]
                    let playerCountry = playerObject? ["country"]
                    let playerId = playerObject? ["id"]
                    
                    let player = PlayerModel(id: playerId as? String, name: playerName as? String, sport: playerSport as? String, age: (playerAge as! String), country: playerCountry as! String)
                   
                    self.playerList.append(player)
                }
                self.tablePlayers.reloadData()
            }
        })
        
        textFieldPlayerName.clearButtonMode = .always
        textFieldSportName.clearButtonMode = .always
        textFieldAge.clearButtonMode = .always
        textFieldCountry.clearButtonMode = .always
    }
    //-----------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = playerList[indexPath.row]
        let alert = UIAlertController(title: player.name, message: "Update or Delete player", preferredStyle: .alert)
        let update = UIAlertAction(title: "Update", style: .default){ (_) in
            let id = player.id
            
            let name = alert.textFields?[0].text
            let sport = alert.textFields?[1].text
            let age = alert.textFields?[2].text
            let country = alert.textFields?[3].text
            
            self.updatePlayer(id: id!, name: name!, sport: sport!, age: age!, country: country!)
        }
        let delete = UIAlertAction(title: "Delete", style: .default){ (_) in
            self.deletePlayer(id: player.id!)
        }
        
        alert.addTextField{(textField) in
            textField.text = player.name
        }
        
        alert.addTextField{(textField) in
            textField.text = player.sport
        }
        
        alert.addTextField{(textField) in
            textField.text = player.age
        }
        
        alert.addTextField{(textField) in
            textField.text = player.country
        }
        
        alert.addAction(update)
        alert.addAction(delete)
        
        present(alert, animated: true, completion: nil)
    }

    
    //-----------------------------------------------------------------------------
    
    @IBAction func buttonAddPlayer(_ sender: UIButton) {
        addPlayer()
    }
    
    //-----------------------------------------------------------------------------
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! ViewControllerTableViewCell
        
        let player: PlayerModel
        
        player = playerList[indexPath.row]
        
        cell.labelName.text = player.name
        cell.labelAge.text = player.age
        cell.labelSport.text = player.sport
        cell.labelCountry.text = player.country
        
        return cell
    }
    
    //-----------------------------------------------------------------------------
   

    func addPlayer(){
        let key = referencePlayers.childByAutoId().key
        let player = ["id": key,
                      "playerName": textFieldPlayerName.text! as String,
                      "sportName": textFieldSportName.text! as String,
                      "playerAge": textFieldAge.text! as String,
                      "country": textFieldCountry.text! as String
                      
                        ]
        referencePlayers.child(key!).setValue(player)
        labelMessage.text = "Player added on the database"
    }
   
    //-----------------------------------------------------------------------------

    func updatePlayer(id: String, name: String, sport: String, age: String, country: String) {
        let player = ["id": id,
                      "playerName": name,
                      "sportName": sport,
                      "playerAge": age,
                      "country": country
                        ]
        referencePlayers.child(id).setValue(player)
        labelMessage.text = "Player Updated"
    }
    
    //-----------------------------------------------------------------------------
    
    func deletePlayer(id: String) {
        referencePlayers.child(id).setValue(nil)
    }
}


