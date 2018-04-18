//
//  ViewController.swift
//  JSON Parsing
//
//  Created by BS-195 on 4/17/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Course List"
        // Parse JSON
        parseJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func parseJSON() {
        
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase // Swift 4.1
                    let websiteDescription = try decoder.decode(WebsiteDescription.self, from: data)
                    print(websiteDescription.name,websiteDescription.description)
                    self.courses = websiteDescription.courses
                    self.tableView.reloadData()
                    
                    /* Swift 2, 3
                     let dataAsString = String(data: data, encoding: .utf8)
                     guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                     
                     let websiteDescription = WebsiteDescription(json: json)
                     print(websiteDescription.name)
                     */
                } catch let jsonError {
                    print("Error decoding JSON: \(jsonError)")
                }
            }
        }.resume()
        
    }
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellID")
        let course = self.courses[indexPath.row]
        cell.textLabel?.text = course.name
        cell.detailTextLabel?.text = course.link//String(course.numberOfLessons)
        
        return cell
    }


}

