//
//  ViewController.swift
//  AddPhotoOnTapOnIndexpath
//
//  Created by Appinventiv Mac on 08/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteBTOutlet: UIButton!
    @IBOutlet weak var addBTOutlet: UIButton!
    
    
    var index:Int=0
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 5.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    var imageArray = ["1","2","3","4","5","6","7","8","9","10","12","11"]
    
    
    //MARK: ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func deletePhoto(_ sender: Any) {
        if imageArray.count < 1 {
            let alert = UIAlertController(title: "Attension!!",
                                          message: "No images left",
                                          preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "OK",
                                           style: .default) {
                                            [unowned self] action in
                                            self.deleteBTOutlet.isEnabled = false
                                            return
            }
            
            alert.addAction(saveAction)
            present(alert, animated: true)
        }else{
            self.deleteBTOutlet.isEnabled=true
            imageArray.remove(at: index)
            self.collectionView.reloadData()
        }
        
        
        
    }
    @IBAction func addPhoto(_ sender: Any) {
        self.deleteBTOutlet.isEnabled=true
        imageArray.insert("addimage", at: index)
        self.collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func setView(){
        collectionView.delegate=self
        collectionView.dataSource=self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell
        cell?.imageView.image = UIImage(named: imageArray[indexPath.item])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Attension!!",
                                      message: "Want to add a new image",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default) {
                                        [unowned self] action in
                                        self.imageArray.insert("addimage", at: indexPath.item)
                                        self.index = indexPath.item
                                        self.collectionView.reloadData()
                                        return
        }
        
        let deleteAction = UIAlertAction(title: "Delete",
                                         style: .default) {
                                            [unowned self] action in
                                            if indexPath.item == self.imageArray.count{
                                                self.imageArray.remove(at: indexPath.item)
                                                self.index = indexPath.item - 1
                                            }else{
                                                self.imageArray.remove(at: indexPath.item)
                                                self.collectionView.reloadData()
                                                return
                                            }
        }
        
        alert.addAction(saveAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //MARK: Width calculation
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
        
    }
    
    //MARK: View for supplementary element of kind
    
    //    func collectionView(_ collectionView: UICollectionView,
    //                        viewForSupplementaryElementOfKind kind: String,
    //                        at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //        switch kind {
    //
    //        case UICollectionElementKindSectionHeader:
    //
    //            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "HeaderCollectionReusableView",for: indexPath) as! HeaderCollectionReusableView
    //            return headerView
    //        default:
    //            assert(false, "Unexpected element kind")
    //        }
    //    }
    
    
    
}

