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
        _currency = [dictionary valueForKey:@"currency"];
        _translations = [dictionary valueForKey:@"name_translations"];
        _name = [dictionary valueForKey:@"name"];
        _code = [dictionary valueForKey:@"code"];
    }
    
    return self;
}

@end
