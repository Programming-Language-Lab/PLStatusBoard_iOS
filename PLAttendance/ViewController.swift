//
//  ViewController.swift
//  PLAttendance
//
//  Created by 이지훈 on 2023/05/09.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        
        collectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
       // cell.mainLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    
}
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let numberOfItemsPerRow: CGFloat = 3
            let spacingBetweenCells: CGFloat = flowLayout.minimumInteritemSpacing
            let totalSpacing = (2 * flowLayout.sectionInset.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) // The amount of total spacing in a row

            let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }
        return CGSize(width: 0, height: 0)
    }
}


// 기능이 뭐가 들어가야될까
/*
 상태변경: 재실 외출 수업 귀가
 상태를 나타내기!!!!
 
 내꺼만 바꾸기
 드래그해서 뷰
 
 
 
 알람보내기: 밥먹을사람~~~~~
 정산하기-> 밥먹은사람 지정해서 가격적으면 알람이 간다
 
 

 */
