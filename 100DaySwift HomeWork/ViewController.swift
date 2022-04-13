//
//  ViewController.swift
//  100DaySwift HomeWork
//
//  Created by Роман Зобнин on 11.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countryTableView: UITableView!
    var nameCountryArray = [String]()
    var nameImageArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fileManager()
        tranformArray()
    }
    
    func fileManager() {
        let fm = FileManager.default
        let patch = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: patch)
            for item in items {
            if item.hasSuffix("@2x.png") {
                nameCountryArray.append(item)
                nameImageArray.append(item)
            }
        }
    }
    
    func tranformArray() {
        for item in nameCountryArray {
            let index = nameCountryArray.index(where:{$0 == item})!
            let endIndex = item.index(item.endIndex, offsetBy: -7)
            let transform = item.substring(to: endIndex)
            nameCountryArray.append(transform)
            nameCountryArray.remove(at: index)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameCountryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.countryTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nameCountryArray[indexPath.row]
        cell.imageView!.image = UIImage(named: (nameImageArray[indexPath.row]))
        cell.imageView?.layer.borderWidth = 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countryTableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? detailViewController {
            vc.name = nameCountryArray[indexPath.row]
            vc.image = nameImageArray[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


