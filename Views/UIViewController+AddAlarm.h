//
//  UIViewController+AddAlarm.h
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AddAlarm)

- (void)presentAddAlarmViewWithCompletedBlock:(void (^)(BOOL isCompleted))completedBlock;

@end
