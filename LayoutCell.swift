
class LayoutCell: UITableViewCell {
    //MARK: - initializers
    init(section: ProfileTableViewController.ProfileSections) {
        guard let section: ProfileTableViewController.ProfileSections = section else { fatalError(ProfileTableViewController.ProfileSections.errorMessage) }

        var sectionTitle: String!
        switch section {
        case .ManagerGoals:
            sectionTitle = NSLocalizedString("GOALS", comment: "GOALS")
        case .Projects:
            sectionTitle = NSLocalizedString("PROJECTS", comment: "PROJECTS")
        }
        
        sectionTitleLabel.text = sectionTitle
        super.init(style: .Default, reuseIdentifier: HeaderTableViewCell.reuseIdentifier)
        backgroundColor = .whiteColor()
        selectionStyle = .None
        addSubview(sectionTitleLabel)
        //this is crucial to layout goalView inside cell and to resize cell to the size of its subview
        layoutIfNeeded()
        contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - properties
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    var proportionalLengthProvider: ProvidesProportionalLength? {
        didSet {
            guard var proportionalLength = proportionalLengthProvider?.proportionalLength else { return }
        }
    }
    
    var sectionTitleLabel = TitleLabel.init(text: "")
    
}
    // MARK: - UIView
    extension HeaderTableViewCell {
        override func didAddSubview(subview: UIView) {
            super.didAddSubview(subview)
            
            switch subview {
            case sectionTitleLabel:
                NSLayoutConstraint.activateConstraints([
                    NSLayoutConstraint(item: sectionTitleLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .LeadingMargin),
                    NSLayoutConstraint(item: sectionTitleLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .TopMargin),
                    NSLayoutConstraint(item: sectionTitleLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .TrailingMargin),
                    NSLayoutConstraint(item: sectionTitleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .BottomMargin)
                    ])
            default:
                return
            }
        }
    }

