//
//  TimerInsert.swift
//  PhamMichael-HW7
//
//  Created by Michael Pham on 10/24/22.
//

import UIKit

class ViewTimer: Equatable{
    var cellEvent: String
    var cellLocation: String
    var cellRemainingTime: Int32
    
    init(event: String, location: String, time: Int32) {
        cellEvent = event
        cellLocation = location
        cellRemainingTime = time
    }
    
    func update(time: Int32){
        cellRemainingTime = time
    }
    
    func getRemainingTime() -> Int32{
        return cellRemainingTime
    }
    
    static func == (lhs: ViewTimer, rhs: ViewTimer) -> Bool{
        return lhs.cellEvent ==
        rhs.cellEvent && lhs.cellLocation == rhs.cellLocation
    }
}
class TimerCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    var timer: ViewTimer!
    
    //openstack initialization code
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //view configuration without core data
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
