//
//  ViewController.swift
//  PLAttendance
//
//  Created by 이지훈 on 2023/05/09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UIView!
    @IBOutlet weak var statusHome: UIView!
    @IBOutlet weak var statusClass: UIView!
    @IBOutlet weak var statusOut: UIView!
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    let imageNames = ["changwoo", "dojin",  "ockjihoon","goeun", "haesung", "hyunsoo", "juyeon"
                      , "yijihoon", "yoojin"]
    let memberNames = ["이창우", "김도진","옥지훈", "최고은", "이혜성", "전현수", "정주연" , "이지훈", "신유진"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "MemberCollectionViewCell", bundle: nil)
        self.mainCollection.register(nib, forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        
        status.layer.cornerRadius = 12
        statusOut.layer.cornerRadius = 12
        statusClass.layer.cornerRadius = 12
        statusHome.layer.cornerRadius = 12
    }
    
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        
        //collectionView.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        
        cell.memberImage?.image = UIImage(named: imageNames[indexPath.row])
        cell.mainLabel?.text = memberNames[indexPath.row]
        
        print("Cell \(indexPath.row + 1) created")
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row + 1) was tapped")
        
        let alertController = UIAlertController(title: "멤버\(indexPath.row + 1)", message: "상태를 변경합니다.", preferredStyle: .actionSheet)
        
        let inLab = UIAlertAction(title: "재실", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 재실중입니다")
            
        }
        
        let goOut = UIAlertAction(title: "외출", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 외출중입니다")
        }
        
        let inClass = UIAlertAction(title: "수업", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 수업중입니다")
        }
        
        let goHome = UIAlertAction(title: "귀가", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 집에 가버렷습니다!!!")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(inLab)
        alertController.addAction(goOut)
        alertController.addAction(inClass)
        alertController.addAction(goHome)
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
