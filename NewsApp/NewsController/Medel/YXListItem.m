//
//  YXListItem.m
//  NewsApp
//
//  Created by Victor Wu on 2019/10/30.
//  Copyright © 2019 Victor Wu. All rights reserved.
//

#import "YXListItem.h"

@implementation YXListItem

- (void)configWithDictionary:(NSDictionary *)dictionary {
# warning type may be not match
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
