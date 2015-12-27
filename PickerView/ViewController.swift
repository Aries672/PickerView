//
//  ViewController.swift
//  PickerView
//
//  Created by Aries on 15/12/27.
//  Copyright © 2015年 star. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var myPicker:UIPickerView!
    var pickerDic:NSDictionary!
    var provinceArray:NSArray!
    var cityArray:NSArray!
    var townArray:NSArray!
    var selectedArray:NSArray!
    var maskView:UIView!
    var pickerBgView:UIView!
    var btn:UIButton!
    var toolBar:UIToolbar!
    var provinceBtn:UIButton!
    var textFiled:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
        //initView()
        myPicker = UIPickerView(frame: CGRect(x: 0, y: 50, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height))
        myPicker.delegate = self
        myPicker.dataSource = self
        myPicker.hidden = true
        self.view.addSubview(myPicker)
        
        btn = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 40))
        btn.addTarget(self, action:"Show", forControlEvents:.TouchUpInside)
        btn.setTitle("地区", forState:.Normal)
        btn.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(btn)
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 50, width: UIScreen.mainScreen().bounds.width, height: 50))
        toolBar.barStyle = .BlackTranslucent
        toolBar.backgroundColor = UIColor.blackColor()
        let doneBarItem = UIBarButtonItem(title: "完成", style: .Plain, target: self, action:"Dismiss")
        doneBarItem.tintColor = UIColor.whiteColor()
        toolBar.setItems([doneBarItem], animated: true)
        toolBar.hidden = true
        self.myPicker.addSubview(toolBar)
        
        provinceBtn = UIButton(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        provinceBtn.backgroundColor = UIColor.whiteColor()
        provinceBtn.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(provinceBtn)
        
        textFiled = UITextField(frame: CGRect(x: 50, y: 80, width: 200, height: 50))
        textFiled.placeholder = "地址"
        textFiled.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(textFiled)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func Show(){
        self.myPicker.hidden = false
        self.toolBar.hidden = false
        
    }
    
    func Dismiss(){

//
        print("f")
    }
    
    //
    //    func initView(){
    //        self.maskView = UIView.init(frame: self.view.frame)
    //        self.maskView.backgroundColor = UIColor.blackColor()
    //        self.maskView.alpha = 0
    //        self.maskView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: "hideMyPicker"))
    //        //self.pickerBgView.frame.width == UIScreen.mainScreen().bounds.width
    //
    //    }
    //
    //    func hideMyPicker(){
    ////        - (void)hideMyPicker {
    ////            [UIView animateWithDuration:0.3 animations:^{
    ////                self.maskView.alpha = 0;
    ////                self.pickerBgView.top = self.view.height;
    ////                } completion:^(BOOL finished) {
    ////                [self.maskView removeFromSuperview];
    ////                [self.pickerBgView removeFromSuperview];
    ////                }];
    ////        }
    //        UIView.animateWithDuration(0.3, animations: { () -> Void in
    //            self.maskView.alpha = 0
    //            self.pickerBgView.frame.height == self.view.frame.height
    //            }) { (Bool finished) -> Void in
    //                self.maskView.removeFromSuperview()
    //                self.pickerBgView.removeFromSuperview()
    //        }
    //
    //    }
    
    func getPickerData(){
        let path = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")
        self.pickerDic = NSDictionary.init(contentsOfFile: path!)
        self.provinceArray = self.pickerDic.allKeys
        self.selectedArray = self.pickerDic.objectForKey(self.pickerDic.allKeys[0]) as! NSArray
        if (self.selectedArray.count > 0){
            self.cityArray = self.selectedArray[0].allKeys
        }
        
        if (self.cityArray.count > 0){
            self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = UILabel()
        pickerLabel = UILabel.init()
        pickerLabel.font = UIFont(name: "Helvetica", size: 8)
        pickerLabel.adjustsFontSizeToFitWidth = true
        pickerLabel.textAlignment = .Left
        pickerLabel.backgroundColor = UIColor.clearColor()
        pickerLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return pickerLabel
    }
    
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
            return self.provinceArray.count;
        } else if (component == 1) {
            return self.cityArray.count;
        } else {
            return self.townArray.count;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            //return [self.provinceArray objectAtIndex:row];
            return self.provinceArray[row] as? String
        } else if (component == 1) {
            return self.cityArray[row] as? String;
        } else {
            return self.townArray[row] as? String;
        }
        
    }
    
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if (component == 0) {
            return 110;
        } else if (component == 1) {
            return 100;
        } else {
            return 110;
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            self.selectedArray = self.pickerDic.objectForKey(self.provinceArray[row]) as! NSArray
            if (self.selectedArray.count > 0) {
                self.cityArray = self.selectedArray[0].allKeys
            } else {
                self.cityArray = nil;
            }
            if (self.cityArray.count > 0) {
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[0]) as! NSArray
            } else {
                self.townArray = nil;
            }
        }
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
        
        if (component == 1) {
            if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
                
                self.townArray = self.selectedArray[0].objectForKey(self.cityArray[row]) as! NSArray
                
            } else {
                self.townArray = nil;
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
            
        }
        
        pickerView.reloadComponent(2)
        
        provinceBtn.setTitle(self.provinceArray[self.myPicker.selectedRowInComponent(0)] as? String, forState:.Normal)
        textFiled.text = ((self.provinceArray[self.myPicker.selectedRowInComponent(0)] as? String)! + (self.cityArray[self.myPicker.selectedRowInComponent(1)] as! String) as? String)! + (self.townArray[self.myPicker.selectedRowInComponent(2)] as! String) as? String
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

