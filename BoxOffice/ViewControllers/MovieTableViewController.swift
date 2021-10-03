//
//  MovieTableViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit
import Alamofire

class MovieTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedCellIndexRow: Int?
    
//    var movies: [Movie] = []
    var movieModels: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(cellType: MovieTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableOrderChange(0)
    }
    
    @IBAction func touchUpShowActionSOrderButton()
    {
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func tableOrderChange(_ orderType: Int) {
        AF.request("\(BASE_URL)/movies?order_type=\(orderType)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            if let result = response.value as? [String : Any], let movieResponseModel = MovieResponseModel(JSON: result) {
                self?.movieModels = movieResponseModel.movies
                self?.tableView.reloadData()
                self?.navigationItem.title = self?.orderName(orderType)
            }
        }
    }
    
    func  showAlertController(style: UIAlertController.Style) {
        
        let alertController: UIAlertController
        alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: style)
        
        let rateAction: UIAlertAction
        rateAction = UIAlertAction(title: "예매율", style: UIAlertAction.Style.default) { (action) in
            self.tableOrderChange(0)
        }
        
        let curationAction: UIAlertAction
        curationAction = UIAlertAction(title: "큐레이션", style: UIAlertAction.Style.default) { (action) in
            self.tableOrderChange(1)
        }
        
        let dateAction: UIAlertAction
        dateAction = UIAlertAction(title: "개봉일", style: UIAlertAction.Style.default) { (action) in
            self.tableOrderChange(2)
        }
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(rateAction)
        alertController.addAction(curationAction)
        alertController.addAction(dateAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func orderName(_ orderType: Int) -> String {
        switch orderType {
        case 0:
            return "예매율"
        case 1:
            return "큐레이션"
        case 2:
            return "개봉일"
        default:
            return "no"
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        guard let nextViewController: MovieDetailViewController = segue.destination as? MovieDetailViewController else {
            return
        }
        
        if let index: Int = selectedCellIndexRow {
            nextViewController.currentID = movieModels[index].id
        }
    }

}

extension MovieTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: CodeCountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndentifier, for: indexPath) as! CodeCountryTableViewCell
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieTableViewCell
        
//        cell.leftLabel.text = self.dateFormatter.string(from: self.dates[indexPath.row])
        let movie: MovieModel = self.movieModels[indexPath.row]

        cell.titleLabel.text = movie.title
        cell.infoLabel.text = "평점:\(movie.userRating ?? 0) 예매순위:\(movie.reservationGrade ?? 0) 예매율:\(movie.reservationRate ?? 0)"
        cell.dateLabel.text = "개봉일: \(movie.date ?? "")"

        guard let thumbImage: UIImage = UIImage(named: "img_placeholder") else{
            print("no thumb image")
            return cell
        }
        cell.thumbImageView.image = thumbImage
        
        if let grade = movie.grade {
            if let gradeName: String = getGradeName(grade)
            {
                guard let gradeImage: UIImage = UIImage(named: gradeName) else{
                    print("no grade image")
                    return cell
                }
                cell.gradeImageView.image = gradeImage
            }
        }

        //kingfisher
        guard let thumbName: String = movie.thumb else { return cell}
        
        DispatchQueue.global().async {
            guard let thumbURL: URL = URL(string: thumbName) else { return }
            guard let thumbData: Data = try? Data(contentsOf: thumbURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.thumbImageView.image = UIImage(data: thumbData)
                    }
                }
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellIndexRow = indexPath.row
        print("select! \(indexPath.row)")
        
        performSegue(withIdentifier: "showTableDetailView", sender: self)
    }
}
