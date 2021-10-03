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
    var currentMovie: MovieDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cosmosView.settings.minTouchRating = 0.5
        self.cosmosView.didTouchCosmos = { [weak self] rating in
            self?.changedUserRating(rating: rating)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let movieDetail = currentMovie {
            titleLabel.text = movieDetail.title
            changedUserRating(rating: cosmosView.rating)
            
            if let grade = movieDetail.grade {
                if let gradeName: String = getGradeName(grade)
                {
                    guard let gradeImage: UIImage = UIImage(named: gradeName) else{
                        print("no grade image")
                        return
                    }
                    self.gradeImageView.image = gradeImage
                }
            }
        }
    }
    
    func changedUserRating(rating : Double)
    {
        ratingLabel.text = "\(Int(cosmosView.rating * 2))"
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
        let param: [String: Any] = [ "rating": cosmosView.rating * 2,
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
    }
}
