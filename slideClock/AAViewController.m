//
//  AAViewController.m
//  slideClock
//
//  Created by Arno Appenzeller on 14.09.13.
//  Copyright (c) 2013 Arno Appenzeller. All rights reserved.
//

#import "AAViewController.h"

@interface AAViewController ()


@end

static const int yDifference = 55;
@implementation AAViewController

- (UILabel *)deepLabelCopy:(UILabel *)label {
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:label.frame];
    duplicateLabel.text = label.text;
    duplicateLabel.font = label.font;
    duplicateLabel.textColor = label.textColor;
    // etc... anything else which is important to your ULabel
    
    return duplicateLabel;
}

- (void)viewDidLoad
{
    self.prevmin = 0;
    self.prevhour = 0;
    self.date = [NSDate date];
    self.container.clipsToBounds = YES;
    if(self.timer == nil){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                    selector:@selector(refreshTimeLabel:)
                                                    userInfo:nil repeats:YES];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)refreshTimeLabel:(NSTimer *)timer{
    NSDate *theTime = [NSDate date];
    NSCalendar *theCalender = [NSCalendar currentCalendar];
    NSDateComponents *theComponentsDiv = [theCalender components:NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit fromDate:self.date toDate:theTime options:0];
    UILabel *newH, *newM , *newS;
    
    newS = [self deepLabelCopy:self.secondount];
    newS.text = [NSString stringWithFormat:@"02i",theComponentsDiv.second];
    newS.frame = CGRectMake(newS.frame.origin.x, newS.frame.origin.y - yDifference, newS.frame.size.width, newS.frame.size.height);
    newS.alpha = 0;
    [self.container addSubview:newS];
    
    if (theComponentsDiv.hour != self.prevhour) {
        newH = [self deepLabelCopy:self.hourcount];
        newH.text = [NSString stringWithFormat:@"02i",theComponentsDiv.hour];
        newH.frame = CGRectMake(newH.frame.origin.x, newH.frame.origin.y - yDifference, newH.frame.size.width, newH.frame.size.height);
        newH.alpha = 0;
        [self.container addSubview:newH];
    }
    
    if (theComponentsDiv.minute != self.prevmin) {
        newM = [self deepLabelCopy:self.minutecount];
        newM.text = [NSString stringWithFormat:@"02i",theComponentsDiv.minute];
        newM.frame = CGRectMake(newM.frame.origin.x, newM.frame.origin.y - yDifference, newM.frame.size.width, newM.frame.size.height);
        newM.alpha = 0;
        [self.container addSubview:newM];
    }
    
    
    [UIView animateWithDuration:0.8 animations:^{
        if (theComponentsDiv.hour != self.prevhour) {
            newH.alpha = 1;
            newH.frame = CGRectMake(newH.frame.origin.x, newH.frame.origin.y + yDifference, newH.frame.size.width, newH.frame.size.height);
            self.hourcount.alpha = 0;
            self.hourcount.frame = CGRectMake(self.hourcount.frame.origin.x, self.hourcount.frame.origin.y + yDifference, self.hourcount.frame.size.width, self.hourcount.frame.size.height);
        }
        if (theComponentsDiv.minute != self.prevmin) {
            newM.alpha = 1;
            newM.frame = CGRectMake(newM.frame.origin.x, newM.frame.origin.y + yDifference, newM.frame.size.width, newM.frame.size.height);
            self.minutecount.alpha = 0;
            self.minutecount.frame = CGRectMake(self.minutecount.frame.origin.x, self.minutecount.frame.origin.y + yDifference, self.minutecount.frame.size.width, self.minutecount.frame.size.height);
        }
        newS.alpha = 1;
        newS.frame = CGRectMake(newS.frame.origin.x, newS.frame.origin.y + yDifference, newS.frame.size.width, newS.frame.size.height);
        self.secondount.alpha = 0;
        self.secondount.frame = CGRectMake(self.secondount.frame.origin.x, self.secondount.frame.origin.y + yDifference, self.secondount.frame.size.width, self.secondount.frame.size.height);
        
        
    }completion:^(BOOL finished){
        self.secondount = newS;
        if (theComponentsDiv.minute != self.prevmin){
            self.minutecount = newM;
            self.prevmin = theComponentsDiv.minute;
        }
        if (theComponentsDiv.hour != self.prevhour) {
            self.hourcount = newH;
            self.prevhour = theComponentsDiv.hour;
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
