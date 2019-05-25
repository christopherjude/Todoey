//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Christopher Jude on 5/25/19.
//  Copyright © 2019 Christopher Jude. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    @IBOutlet var categoryView: UITableView!
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCategories()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
 
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = self.textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            self.textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert,animated: true,completion: {
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
        
        textField.becomeFirstResponder()
        
    }
    
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveCategories(){
        
        do {
            try self.context.save()
        } catch{
            print("Error saving categories => \(error)")
        }
        
        tableView.reloadData()
    }
    
    func getCategories(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error fetching request ! \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    //MARK: - TableView DataSource Methods
    
    //MARK: - TableView Delegate Methods
    
    //MARK: - Data Manipulation Methods
    
}
