//
//  BBAlarmViewCell.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "BBAlarmViewCell.h"

@interface BBAlarmViewCell()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation BBAlarmViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:20.0];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.detailLabel = [[UILabel alloc]init];
        self.detailLabel.font = [UIFont systemFontOfSize:14.0];
        self.detailLabel.textColor = [UIColor darkGrayColor];
        self.iconView = [[UIImageView alloc]init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.detailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.detailLabel];
        
        NSString *v1 = [NSString stringWithFormat:@"V:[mainView]-(%1$f)-[detailView1]", 8.0];
        NSString *v3 = [NSString stringWithFormat:@"V:|-(8)-[thumbnail]-(8)-|"];
        NSString *h1 = [NSString stringWithFormat:@"H:|-s-[thumbnail]-[mainView(>=100)]"];
        NSString *h2 = [NSString stringWithFormat:@"H:|-s-[thumbnail]-[detailView1]-s-|"];
        
        NSDictionary *viewsDict = @{@"thumbnail":self.iconView, @"mainView":self.titleLabel, @"detailView1": self.detailLabel};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: v1
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:viewsDict]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: v3
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:viewsDict]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: h1
                                                                                 options:0
                                                                                 metrics:@{@"s":@(4.0)}
                                                                                   views:viewsDict]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: h2
                                                                                 options:0
                                                                                 metrics:@{@"s":@(4.0)}
                                                                                   views:viewsDict]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.iconView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:1
                                                                      constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0]];
        
        self.iconView.image = [UIImage imageNamed:@"alarmIcon"];
        
        
        
        self.rightUtilityButtons = [BBAlarmViewCell _rightButtons];
    }
    return self;
}

- (void)setModel:(BBAlarmModel *)model
{
    if (_model != model) {
        _model = model;
       
        self.titleLabel.text = model.body;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dts = [dateFormatter stringFromDate:model.createdAt];
        
        self.detailLabel.text = [NSString stringWithFormat:@"votes: %lu  created: %@", model.votes, dts];
    }
}

+ (NSArray *)_rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"downVoteIcon"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"upVoteIcon"]];
    
    return rightUtilityButtons;
}

@end
