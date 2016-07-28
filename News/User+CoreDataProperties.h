//
//  User+CoreDataProperties.h
//  News
//
//  Created by lanou3g on 15/12/24.
//  Copyright © 2015年 chuanbao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mail;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pass_word;
@property (nullable, nonatomic, retain) NSString *telphone_number;

@end

NS_ASSUME_NONNULL_END
