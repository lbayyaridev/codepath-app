//
//  ChallengesViewController.swift
//  SendBird-iOS
//
//  Created by user169368 on 5/1/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse
import SendBirdSDK

class ChallengesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{  

    

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataArray = [String]()
    var picArray = [PFFileObject]()
    
    var groupID : SBDGroupChannel? = nil
    

    
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegates
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        // SetupGrid view
        self.setupGridView()
        
        let query = PFQuery(className:"Posts")
        query.whereKey("groupid", equalTo: groupID!.channelUrl)
        query.order(byDescending: "_created_at")
        do {
            let objects = try query.findObjects()
            for object in objects {
                if dataArray.contains(object["challenge"] as! String) {
                    continue
                }
                self.dataArray.append(object["challenge"] as! String)
                self.picArray.append(object["image"] as! PFFileObject)
            }
        } catch {
            print(error)
        }



        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    
    func setupGridView() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.setData(text: self.dataArray[indexPath.row])
        cell.setImage(pic: self.picArray[indexPath.row])
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0

        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWith()
        return CGSize(width: width, height: width)
    }
    
    func calculateWith() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.performSegue(withIdentifier: "showChallenge", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showChallenge"{
            let selectedIndexPath = sender as? NSIndexPath
            let VC = segue.destination as! SingleChallengeViewController
            VC.challengeName = dataArray[selectedIndexPath!.row] as String
            VC.groupID = groupID
        }
    }
    
}



