//
//  BaseViewController.swift
//  KlarnaWeatherForecastChallenge
//
//  Created by Mehmet Can Seyhan on 2019-07-04.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkComingDataContent(text:Double?) -> String {
        if let newTetxt = text {
            return String(newTetxt)
        }
        return ""
    }
    
    func checkComingDataContent(text:Int?) -> String {
        if let newTetxt = text {
            return String(newTetxt)
        }
        return ""
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
