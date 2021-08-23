//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/16.
//

import UIKit

class CommentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    var currentMovieDetail: MovieDetail?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let movieDetail: MovieDetail = currentMovieDetail else { return }
        
        titleLabel.text = movieDetail.title
    }
    
    @IBAction func touchUpSend()
    {
        var comment: CommentSend
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
