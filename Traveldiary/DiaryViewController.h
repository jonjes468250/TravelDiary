//
//  DiaryViewController.h
//  Traveldiary
//
//  Created by 陳毅麟 on 2016/11/22.
//  Copyright © 2016年 Rin. All rights reserved.
//

#import "ViewController.h"
@protocol PassValueDelegate
-(void)passValue:(NSString*)titile
        location:(NSString*)location
       diaryInfo:(NSString*)diartInfo;
@end
@interface DiaryViewController : ViewController
@property (nonatomic,weak) id<PassValueDelegate> delegate;

@end
