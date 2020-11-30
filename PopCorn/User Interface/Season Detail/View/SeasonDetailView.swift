//
//  SeasonDetailView.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

final class SeasonDetailView: UIView, CodeView {
    static let cellIdentifier = "episodeCell"
    
    //MARK: - View Components
    @ViewCodeComponent
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    @ViewCodeComponent
    private var contentView: UIView = {
        let content = UIView(frame: .zero)
        return content
    }()
    
    @ViewCodeComponent
    var airDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Air Date: "
        return label
    }()
    
    @ViewCodeComponent
    var seasonNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        label.text = "Season: "
        return label
    }()
    
    @ViewCodeComponent
    private var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Overview:"
        return label
    }()
    
    @ViewCodeComponent
    var overviewTextView: UITextView = {
        let textview = UITextView(frame: .zero)
        textview.isEditable = false
        textview.textColor = .label
        textview.backgroundColor = UIColor.secondarySystemBackground
        textview.font = UIFont.systemFont(ofSize: 14)
        textview.text = "..."
        return textview
    }()
    
    @ViewCodeComponent
    private var episodesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Episodes:"
        return label
    }()
    
    @ViewCodeComponent
    var episodesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.allowsSelection = false
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    @ViewCodeComponent
    var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    

    //MARK: - Super Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    //MARK: - Methods
    func setupComponents() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(airDateLabel)
        contentView.addSubview(seasonNumberLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewTextView)
        contentView.addSubview(episodesLabel)
        contentView.addSubview(episodesTableView)
        contentView.addSubview(loadingView)
    }
    
    func setupConstraints() {
        scrollViewConstraints()
        contentViewConstraints()
        airDateConstraints()
        seasonNumberConstraints()
        overviewConstraints()
        episodesConstraints()
        loadingConstraints()
    }
    
    func setupExtraConfigurations() {
        backgroundColor = UIColor.systemBackground
    }
    
    //MARK: - Constraint Methods
    private func scrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func contentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
    }
    
    private func airDateConstraints() {
        airDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Dimens.medium).isActive = true
        airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimens.little).isActive = true
        airDateLabel.trailingAnchor.constraint(equalTo: seasonNumberLabel.leadingAnchor, constant: -Dimens.little).isActive = true
    }
    
    private func seasonNumberConstraints() {
        seasonNumberLabel.topAnchor.constraint(equalTo: airDateLabel.topAnchor).isActive = true
        seasonNumberLabel.bottomAnchor.constraint(equalTo: airDateLabel.bottomAnchor).isActive = true
        seasonNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.little).isActive = true
    }
    
    private func overviewConstraints() {
        //Label
        overviewLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: Dimens.medium).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: airDateLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Dimens.little).isActive = true
        
        //TextView
        overviewTextView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Dimens.little).isActive = true
        overviewTextView.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor).isActive = true
        overviewTextView.trailingAnchor.constraint(equalTo: overviewLabel.trailingAnchor).isActive = true
        overviewTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func episodesConstraints() {
        //Label
        episodesLabel.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: Dimens.medium).isActive = true
        episodesLabel.leadingAnchor.constraint(equalTo: overviewTextView.leadingAnchor).isActive = true
        episodesLabel.trailingAnchor.constraint(equalTo: overviewTextView.trailingAnchor).isActive = true
        
        //TableView
        episodesTableView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: Dimens.little).isActive = true
        episodesTableView.leadingAnchor.constraint(equalTo: episodesLabel.leadingAnchor).isActive = true
        episodesTableView.trailingAnchor.constraint(equalTo: episodesLabel.trailingAnchor).isActive = true
        episodesTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Dimens.medium).isActive = true
    }
    
    private func loadingConstraints() {
        loadingView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
