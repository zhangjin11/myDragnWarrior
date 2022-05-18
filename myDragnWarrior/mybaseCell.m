//
//  mybaseCell.m
//  myDragnWarrior
//
//  Created by jin on 2020/6/29.
//  Copyright © 2020 jin. All rights reserved.
//

#import "mybaseCell.h"

@implementation mybaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
