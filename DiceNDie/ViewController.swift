//
//  ViewController.swift
//  DiceNDie
//
//  Created by Nate Chiang on 2018-04-18.
//  Copyright © 2018 Nate Chiang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rolls = [Roll]()
    let randomTexts = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib.init(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchRolls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToRollList(sender: UIStoryboardSegue) {
        if sender.source is CreationViewController {
            fetchRolls()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roll = rolls[indexPath.row]
        let desc = roll.getRolls()
        let alert = UIAlertController(title: "You rolled: \(String(roll.total))", message: desc, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rolls.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.lblHeader.text = rolls[indexPath.row].name
        cell.lblDescription.text = rolls[indexPath.row].desc
        return cell
    }
    
    
    
    private func fetchRolls()
    {
        rolls.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rolls")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            let typesDice = [4,6,8,10,12,20]
            for data in result as! [NSManagedObject] {
                let roll = Roll(name: data.value(forKey: "name") as! String, mod: data.value(forKey: "mod") as! Int, desc: data.value(forKey: "desc") as! String)
                let diceDictionary = data.value(forKey: "dice") as! NSDictionary
                for type in typesDice {
                    let numDice = Int(((diceDictionary["d\(type)"] as! NSString) as String))
                    if ( numDice != 0) {
                        for _ in (0 ... numDice! - 1) {
                            roll.addDice(die: Die(max: type))
                        }
                    }
                }
                rolls.append(roll)
            }
        } catch {
            print("Failed to get roll data")
        }
        collectionView.reloadData()
    }
}

