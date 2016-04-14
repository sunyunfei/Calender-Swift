//
//  CalenderView.swift
//  Calender-Swift
//
//  Created by 孙云 on 16/4/13.
//  Copyright © 2016年 haidai. All rights reserved.
//

import UIKit

class CalenderView: UIView,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var date:NSDate!
    var weekArray:[String] = []
   static func createView()-> AnyObject{
    
        return NSBundle.mainBundle().loadNibNamed("CalenderView", owner: nil, options: nil).last!;
    }

    override func awakeFromNib() {
        //当前时间
        date = NSDate()
        //星期日期排布
        weekArray = ["一","二","三","四","五","六","日"]
        
        //九宫格注册单元格
        collectionView .registerNib(UINib.init(nibName: "CalenderCell", bundle: nil), forCellWithReuseIdentifier: "CalenderCell")
        collectionView.backgroundColor = UIColor.whiteColor()
        //显示时间
        self.showLabelString(date)
        
        //设置九宫格
        self.setCollectionViewLayout()
    }
    /**
     上一个月
     
     - parameter sender: <#sender description#>
     */
    @IBAction func clickPreBtn(sender: AnyObject) {
        
        let dateComponents:NSDateComponents = NSDateComponents.init()
        dateComponents.month = -1;
        
        let newDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: .WrapComponents)!
        
        self.showLabelString(newDate)
        //把时间赋予当前date
        date = newDate;
        collectionView .reloadData()
    }
    /**
     下一个月
     
     - parameter sender: <#sender description#>
     */
    @IBAction func clickNextBtn(sender: AnyObject) {
        
        let dateComponents:NSDateComponents = NSDateComponents.init()
        dateComponents.month = +1;
        
        let newDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: .WrapComponents)!
        
        self.showLabelString(newDate)
        //把时间赋予当前date
        date = newDate;
        collectionView.reloadData()
    }
    
    /**
     表的行数
     
     - parameter tableView: <#tableView description#>
     - parameter section:   <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    /**
     加载表数据
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "cell"
        let cell:UITableViewCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: ID)
        
        cell.textLabel?.text = "张三"
        return cell
    }
    /**
     九宫格的布局,把cell的大小和边距
     */
    func setCollectionViewLayout(){
    
       //屏幕的宽度
        let width:CGFloat = UIScreen.mainScreen().bounds.size.width
        let layOut:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layOut.itemSize = CGSizeMake(width / 7, width / 9)
        layOut.minimumLineSpacing = 0.0
        layOut.minimumInteritemSpacing = 0.0
        collectionView.setCollectionViewLayout(layOut, animated: true)
        
    }
    /**
     九宫格段数
     
     - parameter collectionView: <#collectionView description#>
     
     - returns: <#return value description#>
     */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2;
    }
    /**
     九宫格cell个数
     
     - parameter collectionView: <#collectionView description#>
     - parameter section:        <#section description#>
     
     - returns: <#return value description#>
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return weekArray.count
        }else{
        
            return 42
        }
    }
    /**
     数据加载
     
     - parameter collectionView: <#collectionView description#>
     - parameter indexPath:      <#indexPath description#>
     
     - returns: <#return value description#>
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CalenderCell = collectionView.dequeueReusableCellWithReuseIdentifier("CalenderCell", forIndexPath: indexPath) as! CalenderCell
        if indexPath.section == 0 {
            cell.timerLabel.text = weekArray[indexPath.row]
            cell.timerLabel.textColor = UIColor ( red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5 )
        }else{
        
           cell.timerLabel.textColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5 )
            var allDayArray:[String] = []
            //首先前面的空格
            let day:Int = self.currentFirstDay(date)
            var OneI = 0
            while OneI < day {
                allDayArray.append("")
                OneI += 1
            }
            //中间的日历显示
            OneI = 1
            let days = self.currentMonthOfDays(date)
            while OneI < days {
                allDayArray.append(String(OneI))
                OneI += 1
            }
            
            //后面的空格
            OneI = allDayArray.count
            while OneI < 42 {
                allDayArray.append("")
                OneI += 1
            }
            //数据加载
            cell.timerLabel.text = allDayArray[indexPath.row]
            
        }
        
        return cell
    }
    /**
     时间标签显示
     
     - parameter date: <#date description#>
     
     - returns: <#return value description#>
     */
    func showLabelString(date:NSDate){
    
        //显示出来年月
        showLabel.text = String(self.currentYear(date)) + "年" + String(self.currentMonth(date)) + "月"
    }
    /**
     *  获取当前的月的年份
     */
    func currentYear(date:NSDate)->Int{
    
        let componentsYear:NSDateComponents = NSCalendar.currentCalendar().components([.Year,.Month,.Day], fromDate: date)
        
        return componentsYear.year
    }
    /**
     *  获取当前的月的月份
     */
    func currentMonth(date:NSDate)->Int{
    
        let componentsYear:NSDateComponents = NSCalendar.currentCalendar().components([.Year,.Month,.Day], fromDate: date)
        
        return componentsYear.month
    }
    /**
     *  获取当前月的天数
     */
    func currentDay(date:NSDate)->Int{
    
        let componentsYear:NSDateComponents = NSCalendar.currentCalendar().components([.Year,.Month,.Day], fromDate: date)
        
        return componentsYear.day
    }
    /**
     *  获取本月有几天
     */
    func currentMonthOfDays(date:NSDate)->Int{
    
        let totalDaysInMonth:NSRange = NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: date)
        return totalDaysInMonth.length
        
    }
    /**
     *  本月第一天是星期几
     */
    func currentFirstDay(date:NSDate)->Int{
    
        let calender:NSCalendar = NSCalendar.currentCalendar()
        calender.firstWeekday = 2
       
        
        let comp:NSDateComponents = calender.components([.Year,.Month,.Day], fromDate: date)
        comp.day = 1
        
        let  firstDayOfMonthDate = calender.dateFromComponents(comp)
        let firstWeekDay = calender.ordinalityOfUnit(NSCalendarUnit.Weekday, inUnit: NSCalendarUnit.WeekOfMonth, forDate: firstDayOfMonthDate!)
        
     return firstWeekDay - 1
    }
}
