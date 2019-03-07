//
//  ViewController.swift
//  demfirebase
//
//  Created by abdul ahad on 01/03/2019.
//  Copyright © 2019 abdul ahad. All rights reserved.

import UIKit
import Firebase
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    @IBOutlet weak var EnterFname: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    var ref = DatabaseReference.init()
    var arrdata = [Chatmodel]()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rec = arrdata[indexPath.row]
        
        let alertController = UIAlertController(title: rec.name, message: "get new value to update", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            let Id = rec.id
            let name = alertController.textFields?[0].text
            let text = alertController.textFields?[1].text
            self.updateRec(Id: Id!, name: name!, text: text!)

        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
         self.deleteRec(Id: rec.id!)
        }
        alertController.addTextField { (textField) in
            textField.text = rec.name
        }
        
        alertController.addTextField { (textField) in
            textField.text = rec.text
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present(alertController,animated: true,completion: nil)
    }
    func updateRec(Id: String, name: String, text: String) {
         let rec = [
                    "name": name,
                    "text": text
                  ]
        
    //    let chats = "\(ref)" + "chat"  (for update method)
        
        ref.child("chat").child(Id).updateChildValues(rec)
    }
    func deleteRec(Id: String){
        ref.child("chat").child(Id).setValue(nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.getFIRdata()
        
        let tapGesture = UITapGestureRecognizer()
        myimgView.isUserInteractionEnabled = true
        myimgView.addGestureRecognizer(tapGesture)
        
        
    //  let double = 20.156
      //  let str = String(format: "%.f", double) "CONVERT decimal to int "
    //  self.ref.child("chat").childByAutoId().setValue(str)
        
        //let arrdata = [["name":"asf", "text":123], ["name":"asf", "text":123],["arr":[["name":"asf", "text":123], ["name":"asf", "text":123]]]] "Array and Dictionary"
      //  self.ref.child("chat").childByAutoId().setValue(arrdata)
    }
    
    @IBOutlet weak var myimgView: UIImageView!
    
    @IBAction func savebtn(_ sender: UIButton) {
       
        self.saveFIRdata()
             self.getFIRdata()
       
    
    }
    
    func saveFIRdata() {
        let dict = ["name":EnterFname.text!, "text":txtName.text!]
        self.ref.child("chat").childByAutoId().setValue(dict)
        

       
    }
    func getFIRdata() {
        self.ref.child("chat").queryOrderedByKey().observe(.value) { (snapshot) in
            self.arrdata.removeAll()
            print(snapshot)
            if let postDict = snapshot.value as? [String : AnyObject] {
                for key in postDict.keys {
                    print(postDict[key])
                    if let mainDict = postDict[key] as? [String: AnyObject]{
                        let Id =    key
                        let name = mainDict["name"] as? String
                        let text = mainDict["text"] as? String
                        self.arrdata.append(Chatmodel(id: Id, name: name!, text: text!))
                    }
                }
            }
            self.tblView.reloadData()
        }
        
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.chatmodel = arrdata[indexPath.row]
        
        return cell
    }
    
}


