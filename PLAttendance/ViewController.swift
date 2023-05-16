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
        
        cell.mainLabel?.text = "\(indexPath.row + 1)"
        print("Cell \(indexPath.row + 1) created")
        // cell.mainLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row + 1) was tapped")
        
        let alertController = UIAlertController(title: "멤버\(indexPath.row + 1)", message: "상태를 변경합니다.", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "재실", style: .default) { (action) in
            print("You selected Action 1")
        }
        
        let action2 = UIAlertAction(title: "외출", style: .default) { (action) in
            print("You selected Action 2")
        }
        
        let action3 = UIAlertAction(title: "수업", style: .default) { (action) in
            print("You selected Action 2")
        }
        
        let action4 = UIAlertAction(title: "귀가", style: .default) { (action) in
            print("You selected Action 2")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
