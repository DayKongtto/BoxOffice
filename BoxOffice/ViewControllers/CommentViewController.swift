//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/16.
//

import UIKit
import Cosmos
import Alamofire

class CommentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    var currentID: String?
    var currentMovie: MovieDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cosmosView.didTouchCosmos = { [weak self] rating in
            self?.changedUserRating(rating: rating)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let test: Test = Test()
//        test.tapEvent = { [weak self] value in
//            self?.changedUserRating(rating: value)
//        }
        
        if let movieDetail: MovieDetail = currentMovie {
            titleLabel.text = movieDetail.title
            
            let gradeName: String = movieDetail.gradeName
            guard let gradeImage: UIImage = UIImage(named: gradeName) else{
                print("no grade image")
                return
            }
            self.gradeImageView.image = gradeImage
        }
    }
    
    func changedUserRating(rating : Double)
    {
        ratingLabel.text = "\(cosmosView.rating)"
    }
    
    @IBAction func cancelTouchUP()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeTouchUp()
    {
        sendComment()
    }
    
    func sendComment()
    {
        let param: [String: Any] = [ "rating": cosmosView.rating,
                                     "writer": nameTextField.text ?? "",
                                     "movie_id": currentID ?? "",
                                     "contents": contentTextField.text ?? ""]
        
        AF.request("\(BASE_URL)/comment", method: .post, parameters: param, encoding: JSONEncoding.default).response { [weak self] response in
            if let statusCode = response.response?.statusCode, (200...299).contains(statusCode){
                self?.navigationController?.popViewController(animated: true)
            } else {
                print("error")
            }
        }
        
//        let currentRating: Double = cosmosView.rating
//        guard let writerText: String = nameTextField.text else {
//            return
//        }
//
//        guard let contentsText: String = contentTextField.text else {
//            return
//        }
//
//        guard let id: String = currentID else {
//            return
//        }
//
////        let timeStamp: Double = Date().timeIntervalSince1970
//
//        let comment: CommentSend = CommentSend(rating: currentRating, writer: writerText, movie_id: id, contents: contentsText)
//        dataRequest(comment)
    }
    
//    func dataRequest(_ comment: CommentSendModel?) {
//
//        guard let uploadData = try? JSONEncoder().encode(comment) else {
//            return
//        }
//
//        let url = URL(string: "http://connect-boxoffice.run.goorm.io/comment")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
//            if let error = error {
//                print ("error: \(error)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse,
//                (200...299).contains(response.statusCode) else {
//                print ("server error")
//                return
//            }
//            if let mimeType = response.mimeType,
//                mimeType == "application/json",
//                let data = data,
//                let dataString = String(data: data, encoding: .utf8) {
//                print ("got data: \(dataString)")
//            }
//
//
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//        task.resume()
        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
