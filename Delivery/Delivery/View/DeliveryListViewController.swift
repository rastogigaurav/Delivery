//
//  DeliveryListViewController.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit

class DeliveryListViewController: UIViewController {
    private enum CellIdentifiers {
        static let list = "DeliveryList"
    }
    
    private var viewModel = DeliveryListViewModel.create()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.didLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Methods
    private func setupViewModel(){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DeliveryListViewController : UITableViewDataSource {
    // MARK: Delegate & Datasource methods of UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! DeliveryItemTableViewCell
        cell.configure(with: viewModel.deliveryItem(at: indexPath.row))
        return cell
    }
}
