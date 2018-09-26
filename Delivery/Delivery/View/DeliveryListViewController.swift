//
//  DeliveryListViewController.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/23/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit
import TableviewPaginator

class DeliveryListViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private var tableviewPaginator: TableviewPaginator?
    
    private enum CellIdentifiers {
        static let list = "DeliveryList"
    }
    
    private var viewModel = DeliveryListViewModel.create()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        customSetup()
        viewModel.didLoad()
        tableviewPaginator = TableviewPaginator.init(paginatorUI: self, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    private func customSetup(){
        indicatorView.color = UIColor.darkGray
        indicatorView.startAnimating()
        
        self.title = self.viewModel.title()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    private func setupViewModel(){
        self.viewModel.reload = {[unowned self](success, dataCount) in
            if success {
                self.tableviewPaginator?.incrementOffsetBy(delta: dataCount)
            }
            
            if self.indicatorView.isAnimating {
                self.indicatorView.stopAnimating()
            }

            self.tableviewPaginator?.partialDataFetchingDone()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDeliveryDetail"{
            let deliveryDetailViewController = segue.destination as! DeliveryDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            deliveryDetailViewController.viewModel.delivery = self.viewModel.delivery(at: (indexPath?.row)!)
        }
    }
}

extension DeliveryListViewController : UITableViewDataSource {
    // MARK: Delegate & Datasource methods of UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let yourCurrentNumberOfRows = viewModel.numberOfRows()
        let tableviewPagiantorLoadeMoreCells = (tableviewPaginator?.rowsIn(section: section) ?? 0)
        return yourCurrentNumberOfRows + tableviewPagiantorLoadeMoreCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableviewPaginator?.cellForLoadMore(at: indexPath) {
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! DeliveryItemTableViewCell
        cell.configure(with: viewModel.delivery(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if let height = tableviewPaginator?.heightForLoadMore(cell: indexPath) {
            return height
        }
        
        return UITableViewAutomaticDimension
    }
}

extension DeliveryListViewController: TableviewPaginatorUIProtocol {
    func getTableview() -> UITableView {
        return self.tableView
    }
    
    func shouldAddRefreshControl() -> Bool {
        return true
    }
    
    func getPaginatedLoadMoreCellHeight() -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func getPaginatedLoadMoreCell() -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell") as? LoadMoreTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func getRefreshControlTintColor() -> UIColor {
        return UIColor.darkGray
    }
}

extension DeliveryListViewController: TableviewPaginatorProtocol {
    func loadPaginatedData(offset: Int, shouldAppend: Bool) {
        // call your data populating method here
        // i.e given below
        self.viewModel.fetchData(offset: offset, limit: limit, shouldAppend: shouldAppend)
    }
}

extension DeliveryListViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableviewPaginator?.scrollViewDidScroll(scrollView)
    }
}
