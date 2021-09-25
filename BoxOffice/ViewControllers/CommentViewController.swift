//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/16.
//

import UIKit
import Cosmos

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
        let currentRating: Double = cosmosView.rating
        guard let writerText: String = nameTextField.text else {
            return
        }

        guard let contentsText: String = contentTextField.text else {
            return
        }

        guard let id: String = currentID else {
            return
        }

//        let timeStamp: Double = Date().timeIntervalSince1970

        let comment: CommentSend = CommentSend(rating: currentRating, writer: writerText, movie_id: id, contents: contentsText)
        dataRequest(comment)
    }
    
    func dataRequest(_ comment: CommentSend) {
        
        guard let uploadData = try? JSONEncoder().encode(comment) else {
            return
        }
        
        let url = URL(string: "http://connect-boxoffice.run.goorm.io/comment")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
            
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
        }
        task.resume()
        
//        let sesstion: URLSession = URLSession(configuration: .default)
//        let dataTask: URLSessionDataTask = sesstion.dataTask(with: url) { ( data: Data?, response: URLResponse?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let apiResponse: MovieAPIResponse = try JSONDecoder().decode(MovieAPIResponse.self, from: data)
////                print(apiResponse.movies);
//                self.movies = apiResponse.movies
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            } catch (let err) {
//                print(err.localizedDescription)
//            }
//        }
//
//        dataTask.resume()
//        self.navigationItem.title = self.orderName(orderType)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
