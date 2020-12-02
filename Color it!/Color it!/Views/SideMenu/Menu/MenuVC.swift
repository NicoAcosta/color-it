//
//  Menu.swift
//  Color it!
//
//  Created by Nicolás Acosta on 01/12/2020.
//

import Foundation
import UIKit
import InteractiveSideMenu

class MenuVC: MenuViewController, Storyboardable {
    
    @IBOutlet fileprivate weak var tableView: UITableView!

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        overrideUserInterfaceStyle = .light
        
        // Select the initial row
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.none)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: [blue, lightblue])
        
        //  Alto de fila = alto de tableView / cantidad de items -> aprovechar todo el alto posible
        let rows = 5
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let tableViewHeight = safeAreaHeight - 400
        tableView.rowHeight = tableViewHeight / CGFloat(rows)
        
    }

    deinit{
        print()
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuContainerViewController?.contentViewControllers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SampleTableCell.self), for: indexPath) as? SampleTableCell else {
            preconditionFailure("Unregistered table view cell")
        }
        
        cell.titleLabel.text = menuContainerViewController?.contentViewControllers[indexPath.row].title ?? "A Controller"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }

        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        menuContainerViewController.hideSideMenu()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
}
