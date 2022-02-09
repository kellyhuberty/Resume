//
//  ResumeDisplayViewController.swift
//  Resume
//
//  Created by Kelly Huberty on 10/13/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class ResumeDisplayTableViewController: UITableViewController {
    
    var resume: Resume?{
        didSet{
            tableView.reloadData()
        }
    }
    
    enum CellSection: String, CaseIterable {

        case overview = "Overview"
        case schools = "School"
        case jobs = "Job"
        case skills = "Skill"
        case projects = "Project"
        case other = "Other"
    
    }
    
    //MARK: init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        title = NSLocalizedString("Overview", comment: "ResumeDisplayViewController title")
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Checkmark"), tag: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        title = NSLocalizedString("Overview", comment: "ResumeDisplayViewController title")
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(named: "Checkmark"), tag: 0)    }
    
    //MARK: Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.overview.rawValue)
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.schools.rawValue)
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.jobs.rawValue)
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.skills.rawValue)
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.projects.rawValue)
        tableView.register(GeneralTableViewCell.self, forCellReuseIdentifier: CellSection.other.rawValue)
        
        tableView.register(SectionTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        tableView.register(OverviewTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "overviewHeader")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return CellSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let resume = resume else {
            return 0
        }
        
        let section = CellSection.allCases[section]
        
        switch section {
        case .overview:
            return 1
        case .schools:
            return resume.schools.count
        case .jobs:
            return resume.jobs.count
        case .skills:
            return resume.skills.count
        case .projects:
            return resume.projects.count
        case .other:
            return resume.other.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = CellSection.allCases[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: section.rawValue, for: indexPath) as! GeneralCell & UITableViewCell
        
        self.configureCell(cell, for:section, row:indexPath.row)
        
        cell.setNeedsLayout()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == CellSection.overview.index() {
            return 0
        }

        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellSection = CellSection.allCases[section]

        guard cellSection != .overview else{
            let header  = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerOverview")
            return header
        }
        
        
        let header  = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! SectionTableHeaderView
        
        switch cellSection {
        case .overview:
            header.label.text = nil
            return nil
        case .schools:
            header.label.text = resume?.sections.schools.title
        case .jobs:
            header.label.text = resume?.sections.jobs.title
        case .skills:
            header.label.text = resume?.sections.skills.title
        case .projects:
            header.label.text = resume?.sections.projects.title
        case .other:
            header.label.text = resume?.sections.other.title
        }
        
        return header
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (context) in
            
            self.tableView.setNeedsLayout()
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = (tableView.cellForRow(at: indexPath) as? GeneralTableViewCell) else {
            return
        }
        guard let view = (cell.view as? ResumeElementView) else {
            return
        }

        guard let linkable = view.resumeElement as? ExternallyLinkable else {
            return
        }
        guard let url = linkable.url as? URL else {
            return
        }
        
        (UIApplication.shared.delegate as? AppDelegate)?.openRemoteUrlLocally(url)
    }
    
}

//MARK: UITableViewDataSource methods

extension ResumeDisplayTableViewController {
    

    func configureCell(_ cell:GeneralCell, for section:CellSection, row:Int){
        switch section {
        case .overview:
            let view = OverviewView(frame: .zero)
            view.resume = resume
            cell.view = view
        case .schools:
            let view = SchoolView(frame: .zero)
            view.school = resume?.schools[row]
            cell.view = view
        case .jobs:
            let view = JobView(frame: .zero)
            view.job = resume?.jobs[row]
            cell.view = view
        case .skills:
            let view = SkillView(frame: .zero)
            view.skill = resume?.skills[row]
            cell.view = view
        case .projects:
            let view = ProjectView(frame: .zero)
            view.project = resume?.projects[row]
            cell.view = view
        case .other:
            let view = OtherView(frame: .zero)
            view.other = resume?.other[row]
            cell.view = view
        }
        
    }
    
    
}

extension CaseIterable where Self : Equatable{
    
    func index() -> Int{
        
        for (index, item) in type(of:self).allCases.enumerated() {
            
            if item == self{
                return index
            }
            
        }
        
        fatalError()
        
    }
    
}


