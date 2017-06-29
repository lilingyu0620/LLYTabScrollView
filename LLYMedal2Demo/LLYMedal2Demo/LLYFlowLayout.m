//
//  LLYFlowLayout.m
//  LLYMedal2Demo
//
//  Created by lly on 2017/6/28.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYFlowLayout.h"

@implementation LLYFlowLayout


-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];

    NSMutableArray *headerAttArray = [NSMutableArray array];
    //遍历superArray，改变header结构信息中的参数，使它可以在当前section还没完全离开屏幕的时候一直显示
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        //如果当前item是header
        if ([attribute.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
        {
            [headerAttArray addObject:attribute];
        }
    }

    int curSection = 100;
    for (UICollectionViewLayoutAttributes *attribute in headerAttArray) {
        if (attribute.indexPath.section < curSection) {
            curSection = (int)attribute.indexPath.section;
        }
    }
    NSLog(@"cur section %d",curSection);

    //转换回不可变数组，并返回
    return attributes;
}



//return YES;表示一旦滑动就实时调用上面这个layoutAttributesForElementsInRect:方法
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}


@end
