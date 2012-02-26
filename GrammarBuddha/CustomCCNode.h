//
//  CustomCCNode.h
//  Coco2dTest2
//
//  Created by Ethan Mick on 3/11/10.
//  Copyright 2010 Wayfarer. All rights reserved.
//

#import "cocos2d.h"


@interface CustomCCNode : CCSprite <CCTargetedTouchDelegate> {
    
}

@property (nonatomic, readonly) CGRect rect;
@property (nonatomic, assign) CustomCCNode* linkedNode;
@property (nonatomic, readwrite) BOOL isSelected;

@end