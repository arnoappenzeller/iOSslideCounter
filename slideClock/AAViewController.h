//
//  AAViewController.h
//  slideClock
//
//  Created by Arno Appenzeller on 14.09.13.
//  Copyright (c) 2013 Arno Appenzeller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *hourcount;
@property (weak, nonatomic) IBOutlet UILabel *minutecount;
@property (weak, nonatomic) IBOutlet UILabel *secondount;
@property (nonatomic,retain) NSTimer* timer;
@property (nonatomic, retain) NSDate *date;
@property int prevmin,prevhour;
@property (weak, nonatomic) IBOutlet UIView *container;

@end
