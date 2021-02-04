//
//  Country.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "Country.h"

@implementation Country

- (instancetype)initWithDictionary:(NSDictionary*) dictionary
{
    if (self = [super init]) {
        self.currency = [dictionary valueForKey:@"currency"];
        self.translations = [dictionary valueForKey:@"name_translations"];
        self.name = [dictionary valueForKey:@"name"];
        self.code = [dictionary valueForKey:@"code"];
    }
    
    return self;
}

@end
