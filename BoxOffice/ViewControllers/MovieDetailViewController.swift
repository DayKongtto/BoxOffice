//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by PSJ on 2021/08/14.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var currentID: String?
    @IBOutlet weak var reviewViewHeight: NSLayoutConstraint!
    
    var reviewArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reviewViewHeight.constant = CGFloat(reviewArray.count * 70) + 20
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
