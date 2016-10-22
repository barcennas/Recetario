//
//  MainTableViewController.swift
//  Recetario
//
//  Created by Abraham Barcenas M on 10/21/16.
//  Copyright © 2016 bardev. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class MainTableViewController: UITableViewController {

    var recetas : [Receta] = []
    let DBref = FIRDatabase.database().reference(withPath: "Recetas")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        self.DBref.observe(.value, with: { snapshot in
            
            var newRecepies : [Receta] = []
            
            for recepie in snapshot.children {
                let receta = Receta(snapshot: recepie as! FIRDataSnapshot)
                newRecepies.append(receta)
            }
            
            self.recetas = newRecepies
            self.tableView.reloadData()
            
        })
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recetas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recetaCell", for: indexPath) as! recetaCell

        let recepie = recetas[indexPath.row]
        
        cell.imagen.image = recepie.image
        cell.nombre.text = recepie.name
        cell.descripcion.text = recepie.description
        cell.tiempo.text = String(recepie.coockTime)
        
        cell.imageView?.layer.cornerRadius = 45
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
     
    // MARK: - UIBarButton Functions
     
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try FIRAuth.auth()?.signOut()
            KVNProgress.showSuccess(withStatus: "Nos vemos pronto 👋🏻", completion: {
                self.navigationController?.isNavigationBarHidden = true
                self.performSegue(withIdentifier: "unwindLogout", sender: nil)
            })
        } catch {
            
        }
    }
    
    @IBAction func addRecepie(_ sender: AnyObject) {
        
    }
    
    
     
     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
