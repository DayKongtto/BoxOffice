//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import Cosmos
import Alamofire

class MovieDetailViewController: UIViewController {
    var currentID: String?
    @IBOutlet weak var reviewViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradeImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var userRatingCosmosView: CosmosView!
    @IBOutlet weak var audienceLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    var detailModel: MovieDetailModel?
    var commentModels: [CommentReceiveModel] = []
    
    let cellHeight: CGFloat = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(cellType: MovieCommentTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id: String = currentID {
            self.detailChange(id)
            self.commentChange(id)
        }
    }
    
    func detailChange(_ id: String) {
        AF.request("\(BASE_URL)/movie?id=\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {
            [weak self] response in
            if let result = response.value as? [String : Any], let movieDetailModel = MovieDetailModel(JSON: result) {
                self?.detailModel = movieDetailModel
                
                self?.navigationItem.title = movieDetailModel.title

                self?.titleLabel.text = movieDetailModel.title
                self?.infoLabel.text = "\(movieDetailModel.genre ?? "")/\(movieDetailModel.duration ?? 0)분"
                self?.dateLabel.text = "\(movieDetailModel.date ?? "") 개봉"

                self?.reservationLabel.text = "\(movieDetailModel.reservationGrade ?? 0)위  \(movieDetailModel.reservationRate ?? 0)%"
                self?.userRatingLabel.text = "\(movieDetailModel.userRating ?? 0)"
                if let userRating = movieDetailModel.userRating {
                    self?.userRatingCosmosView.rating = userRating * 0.5
                }
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let result = numberFormatter.string(for: movieDetailModel.audience)!
                self?.audienceLabel.text = result

                self?.synopsisLabel.text = movieDetailModel.synopsis

                self?.directorLabel.text = movieDetailModel.director
                self?.actorLabel.text = movieDetailModel.actor
                
                guard let thumbImage: UIImage = UIImage(named: "img_placeholder") else{
                    print("no thumb image")
                    return
                }
                self?.thumbImageView.image = thumbImage
                
                if let grade = movieDetailModel.grade {
                    if let gradeName: String = getGradeName(grade)
                    {
                        guard let gradeImage: UIImage = UIImage(named: gradeName) else{
                            print("no grade image")
                            return
                        }
                        self?.gradeImageView.image = gradeImage
                    }
                }

                if let thumbName: String = movieDetailModel.image{
                    DispatchQueue.global().async {
                        guard let thumbURL: URL = URL(string: thumbName) else { return }
                        guard let thumbData: Data = try? Data(contentsOf: thumbURL) else { return }

                        DispatchQueue.main.async {
                            self?.thumbImageView.image = UIImage(data: thumbData)
                        }
                    }
                }


            }
        }
    }
    
    func commentChange(_ id: String) {
        AF.request("\(BASE_URL)/comments?movie_id=\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            if let result = response.value as? [String : Any], let commentResponseModel = CommentResponseModel(JSON: result) {
                self?.commentModels = commentResponseModel.comments
                if let count = self?.commentModels.count {
                    if let heigt = self?.cellHeight {
                        self?.reviewViewHeight.constant = heigt * CGFloat(count) + 20
        //                     CGFloat(self.comments.count * 120) -> 한줄평 수 * 120(각 셀 별 높이)
                    }
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        guard let nextViewController: CommentViewController = segue.destination as? CommentViewController else {
            return
        }
        
        if let id: String = currentID {
            nextViewController.currentID = id
        }
        
        if let movieDetail: MovieDetailModel =  detailModel {
            nextViewController.currentMovie = movieDetail
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieCommentTableViewCell
        
        let comment: CommentReceiveModel = self.commentModels[indexPath.row]

        cell.writerLabel.text = comment.writer
        if let cosmosRating = comment.rating {
            cell.cosmosView.rating = cosmosRating * 0.5
        }
//        if let date: String = timeFormatter(timestamp: TimeInterval(comment.timestamp ?? 0)) {
        if let timestamp = comment.timestamp, let date: String = timestamp.timeFormatter() {
            cell.dateLabel.text = "\(date)"
        }
        cell.commentLabel.text = comment.contents

        guard let profileImage: UIImage = UIImage(named: "ic_user_loading") else{
            print("no profile image")
            return cell
        }
        cell.profileImageView.image = profileImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
