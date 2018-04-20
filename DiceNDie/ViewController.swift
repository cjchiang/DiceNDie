//
//  ViewController.swift
//  DiceNDie
//
//  Created by Nate Chiang on 2018-04-18.
//  Copyright © 2018 Nate Chiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let randomTexts = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.register(UINib.init(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
        collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToRollList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CreationViewController {
            
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomTexts.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.lblDescription.text = randomTexts[indexPath.row]
        return cell
    }
}

