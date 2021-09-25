//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import Cosmos

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
    
    var detail: MovieDetail?
    var comments: [CommentReceive] = []
    
//    lazy var infoView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
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
        guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movie?id=\(id)") else { return }
        
        let sesstion: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = sesstion.dataTask(with: url) { ( data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
                        
            do {
                let apiResponse: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                
                self.detail = apiResponse
                DispatchQueue.main.async {
                    guard let movieDetail: MovieDetail = self.detail else {
                        return
                    }
                    self.navigationItem.title = movieDetail.title
                    
                    self.titleLabel.text = movieDetail.title
                    self.infoLabel.text = movieDetail.info
                    self.dateLabel.text = movieDetail.dateInfo
                    
                    self.reservationLabel.text = movieDetail.reservationInfo
                    self.userRatingLabel.text = "\(movieDetail.user_rating)"
                    self.userRatingCosmosView.rating = movieDetail.user_rating
                    
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                    let result = numberFormatter.string(for: movieDetail.audience)!
                    self.audienceLabel.text = result
                    
                    self.synopsisLabel.text = movieDetail.synopsis
                    
                    self.directorLabel.text = movieDetail.director
                    self.actorLabel.text = movieDetail.actor
                    

                    guard let thumbImage: UIImage = UIImage(named: "img_placeholder") else{
                        print("no thumb image")
                        return
                    }
                    self.thumbImageView.image = thumbImage

                    let gradeName: String = movieDetail.gradeName
                    guard let gradeImage: UIImage = UIImage(named: gradeName) else{
                        print("no grade image")
                        return
                    }
                    self.gradeImageView.image = gradeImage

                    let thumbName: String = movieDetail.image
                    
                    DispatchQueue.global().async {
                        guard let thumbURL: URL = URL(string: thumbName) else { return }
                        guard let thumbData: Data = try? Data(contentsOf: thumbURL) else { return }
                        
                        DispatchQueue.main.async {
                            self.thumbImageView.image = UIImage(data: thumbData)
                        }
                    }
                }


            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
    func commentChange(_ id: String) {
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/comments?movie_id=\(id)") else { return }
        
        let sesstion: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = sesstion.dataTask(with: url) { [weak self] ( data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
                        
            do {
                let apiResponse: CommentAPIReponse = try JSONDecoder().decode(CommentAPIReponse.self, from: data)
                self?.comments = apiResponse.comments
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.reviewViewHeight.constant = self.cellHeight * CGFloat(self.comments.count) + 20
//                     CGFloat(self.comments.count * 120) -> 한줄평 수 * 120(각 셀 별 높이)
                    self.tableView.reloadData()
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        
        dataTask.resume()
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
        
        if let movieDetail: MovieDetail =  detail {
            nextViewController.currentMovie = movieDetail
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: CodeCountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier, for: indexPath) as! CodeCountryTableViewCell
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieCommentTableViewCell
        
//        cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
        let comment: CommentReceive = self.comments[indexPath.row]

        cell.writerLabel.text = comment.writer
        cell.ratingLabel.text = "\(comment.rating)"
        cell.dateLabel.text = "\(comment.timestamp)"
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
