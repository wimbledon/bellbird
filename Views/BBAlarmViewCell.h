//
//  BBAlarmViewCell.h
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import "BBAlarmModel.h"

@interface BBAlarmViewCell : SWTableViewCell

@property (nonatomic, strong) BBAlarmModel *model;

@end
