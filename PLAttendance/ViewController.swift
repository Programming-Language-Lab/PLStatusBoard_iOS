//
//  ViewController.swift
//  PLAttendance
//
//  Created by 이지훈 on 2023/05/09.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet weak var status: UIView!
    @IBOutlet weak var statusHome: UIView!
    @IBOutlet weak var statusClass: UIView!
    @IBOutlet weak var statusOut: UIView!
    
    @IBOutlet weak var mainCollection: UICollectionView!
    
    let db = Firestore.firestore()
    var memberNames: [String] = []
    var memberStatuses: [String] = []  // 이 배열은 각 멤버의 상태를 저장합니다.
    


//
   let imageNames = ["changwoo", "dojin", "goeun", "haesung", "hyunsoo",  "juyeon"                   , "ockjihoon"  , "yijihoon", "yoojin"]
//    let memberNames = ["이창우", "김도진","옥지훈", "최고은", "이혜성", "전현수", "정주연" , "이지훈", "신유진"]
//
    let nameToDocId = ["창우": "changwoo", "도진": "dojin", "옥지훈": "ockjihoon", "이ㅎㅅ": "haesung", "현수": "hyunsoo", "주연": "juyeon", "이지훈": "yijihoon", "유진": "yoojin", "고은": "goeun"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "MemberCollectionViewCell", bundle: nil)
        self.mainCollection.register(nib, forCellWithReuseIdentifier: "MemberCollectionViewCell")
        
        
        status.layer.cornerRadius = 12
        statusOut.layer.cornerRadius = 12
        statusClass.layer.cornerRadius = 12
        statusHome.layer.cornerRadius = 12
        
        
        // mainCollection의 크기를 화면의 절반으로 설정
           let screenHeight = UIScreen.main.bounds.height
        mainCollection.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: screenHeight * 0.55)
        
        let docRef = db.collection("Members").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let memberName = document.get("name") as? String ?? ""
                    let memberStatus = document.get("status") as? String ?? ""

                    self.memberNames.append(memberName)
                    self.memberStatuses.append(memberStatus)
                }
                DispatchQueue.main.async {
                    self.mainCollection.reloadData()  // 데이터를 가져온 후 컬렉션 뷰를 다시 로드
                }
            }
        }

        
        mainCollection.delegate = self
        mainCollection.dataSource = self

        
       }
    }
    

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell

        // 멤버 이름과 상태는 각각의 배열에서 가져옵니다.
        cell.mainLabel?.text = memberNames[indexPath.row]
        //cell.statusLabel?.text = memberStatuses[indexPath.row]
        
        // 이미지 파일명은 이미지 이름 배열에서 가져옵니다.
        if indexPath.row < imageNames.count {
            let imageName = imageNames[indexPath.row]
            cell.memberImage?.image = UIImage(named: imageName)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberNames.count // 배열 memberNames의 개수를 반환합니다.
    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
//
//        // 이미지 파일명은 이미지 이름 배열에서 가져옵니다.
//        let imageName = imageNames[indexPath.row]
//        cell.memberImage?.image = UIImage(named: imageName)
//
//        // 멤버 이름과 상태는 각각의 배열에서 가져옵니다.
//        cell.mainLabel?.text = memberNames[indexPath.row]
//     //cell.statusLabel?.text = memberStatuses[indexPath.row]
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return memberNames.count // 배열 memberNames의 개수를 반환합니다.
//
//
//    }
    
    func updateMemberStatus(at indexPath: IndexPath, status: String) {
        let memberName = memberNames[indexPath.row]
        let docRef = db.collection("Members").document(memberName)
        self.reloadMemberStatus(memberName: self.nameToDocId[self.memberNames[indexPath.row]] ?? "", newStatus: "재실")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData([
                    "status": status
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            } else {
                docRef.setData([
                    "name": memberName,
                    "status": status
                ]) { err in
                    if let err = err {
                        print("Error setting document: \(err)")
                    } else {
                        print("Document successfully set")
                    }
                }
            }
        }
    }

    
    func reloadMemberStatus(memberName: String, newStatus: String) {
        let docRef = db.collection("Members").document(memberName)
        
        // check if document exists
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // if document exists, update the status
                docRef.updateData([
                    "status": newStatus
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        self.mainCollection.reloadData()
                    }
                }
            } else {
                // if document does not exist, create a new document
                docRef.setData([
                    "name": memberName,
                    "status": newStatus
                ]) { err in
                    if let err = err {
                        print("Error setting document: \(err)")
                    } else {
                        print("Document successfully set")
                        self.mainCollection.reloadData()
                    }
                }
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row + 1) was tapped")

        let alertController = UIAlertController(title: "멤버\(indexPath.row + 1)", message: "상태를 변경합니다.", preferredStyle: .actionSheet)

        let inLab = UIAlertAction(title: "재실", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 재실중입니다")
            let docId = self.nameToDocId[self.memberNames[indexPath.row]] ?? ""
            self.reloadMemberStatus(memberName: docId, newStatus: "재실")
        }

        let goOut = UIAlertAction(title: "외출", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 외출중입니다")
            let docId = self.nameToDocId[self.memberNames[indexPath.row]] ?? ""
            self.reloadMemberStatus(memberName: docId, newStatus: "외출")
        }

        let inClass = UIAlertAction(title: "수업", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 수업중입니다")
            let docId = self.nameToDocId[self.memberNames[indexPath.row]] ?? ""
            self.reloadMemberStatus(memberName: docId, newStatus: "수업")
        }

        let goHome = UIAlertAction(title: "귀가", style: .default) { (action) in
            print("멤버\(indexPath.row + 1)가 집에 가버렷습니다!!!")
            let docId = self.nameToDocId[self.memberNames[indexPath.row]] ?? ""
            self.reloadMemberStatus(memberName: docId, newStatus: "귀가")
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
