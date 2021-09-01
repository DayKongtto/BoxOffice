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
    var currentID: String?
    var currentTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func touchUpSend()
    {
        guard let ratingText: String = ratingTextField.text else {
            return
        }
        let rating: Double? = Double(ratingText)
        guard let currentRating: Double = rating else {
            return
        }
        
        guard let writerText: String = nameTextField.text else {
            return
        }
        
        guard let contentsText: String = contentTextField.text else {
            return
        }
        
        guard let id: String = currentID else {
            return
        }
        
        let timeStamp: Double = 0
        
        let comment: CommentSend = CommentSend(rating: currentRating, writer: writerText, timestamp: timeStamp, movie_id: id, contents: contentsText)
    }
    
    @IBAction func touchUpSendBarButton()
    {
        self.navigationController?.popViewController(animated: true)
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
