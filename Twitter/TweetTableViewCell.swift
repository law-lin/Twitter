//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Lawrence Lin on 3/2/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setRetweeted(_isRetweeted: Bool){
        if (_isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for:
                UIControl.State.normal)
            retweetButton.isEnabled = false
        } else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for:
                UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(_isRetweeted: true)
        }, failure: { (error) in
            print("Error in retweeting: \(error)")
        })
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    func setFavorite(_isFavorited:Bool){
        favorited = _isFavorited
        if (favorited){
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for:
                UIControl.State.normal)
        } else{
            favoriteButton.setImage(UIImage(named:"favor-icon"), for:
                UIControl.State.normal)
        }
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(_isFavorited: false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
}
