//
//  ActividadViewController.swift
//  ProyectoDos
//
//  Created by Universidad Anahac on 12/09/22.
//

import UIKit

class ActividadViewController: UIViewController {

    
    
    let colorTop = UIColor.init(red: 49/255, green: 128/255, blue: 229/255, alpha: 1).cgColor
    let colorBottom = UIColor.init(red: 86/255, green: 77/255, blue: 194/255, alpha: 1 ).cgColor
    let gradient = CAGradientLayer()
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var login: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.colors = [colorTop, colorBottom]
        gradient.frame = topView.bounds
        gradient.shouldRasterize = true
        topView.layer.addSublayer(gradient)
        topView.bringSubviewToFront(image)
        
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.white
        
        login.layer.cornerRadius = 10.0
        login.layer.shadowColor = UIColor.gray.cgColor
        login.layer.shadowOffset = .zero
        login.layer.shadowOpacity = 0.6
        login.layer.shadowRadius = 15.0
        login.layer.shadowPath = UIBezierPath(rect: login.bounds).cgPath
        login.layer.shouldRasterize = true
    
        // Do any additional setup after loading the view.
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
