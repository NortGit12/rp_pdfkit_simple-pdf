//
//  MainPDFTableViewController.swift
//  SimplePDF
//
//  Created by Jeff Norton on 2/8/18.
//  Copyright © 2018 Jeff Norton. All rights reserved.
//

import PDFKit
import UIKit

class MainPDFTableViewController: UITableViewController {
    
    //==================================================
    // MARK: - _Properties
    //==================================================
    
    var documents: [String]?
    
    //==================================================
    // MARK: - _View Lifecycle
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    private func loadDocuments() {
        documents = try? FileManager.default.contentsOfDirectory(atPath: FileUtilities.contractsDirectory())
        documents = documents?.filter { path -> Bool in
            return (path as NSString).pathExtension == "pdf"
        }
        
        tableView.reloadData()
    }
    
    //==================================================
    // MARK: - Navigation
    //==================================================
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            print("ERROR: Could not access the segue's identifier.")
            return
        }
        
        if segueIdentifier == "newPDFTemplate" {
            guard let pdfPath = Bundle.main.path(forResource: "system-purchase-agreement", ofType: "pdf"),
                let destination = segue.destination as? DocumentViewController else {
                    print("ERROR: Could not identify the segue's destination.")
                    return
            }
            
            destination.document = PDFDocument(url: URL(fileURLWithPath: pdfPath))
            destination.title = "New PDF"
            destination.delegate = self
            
        } else if segueIdentifier == "existingPDF" {
            guard let destination = segue.destination as? DocumentViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let documents = documents else {
                    print("ERROR: Could not access the cell's document(s).")
                    return
            }
            
            let document = documents[indexPath.row]
            destination.title = document
            
            let path = FileUtilities.contractsDirectory().appending("/\(document)")
            destination.document = PDFDocument(url: URL(fileURLWithPath: path))
            destination.delegate = self
        }
    }
    
    //==================================================
    // MARK: - Table view data source
    //==================================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
}

extension MainPDFTableViewController: DocumentViewControllerDelegate {
    func didSaveDocument() {
        loadDocuments()
    }
}









