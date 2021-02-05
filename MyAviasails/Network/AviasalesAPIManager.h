//
//  AviasalesAPIManager.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 28.01.2021.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "Ticket.h"


NS_ASSUME_NONNULL_BEGIN

#define API_TOKEN @"9cfb220fbf225dc196d63ea213925fc8"
#define API_URL_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="
#define API_URL_MAP_PRICE @"https://map.aviasales.ru/prices.json?origin_iata="


@class City;

@interface AviasalesAPIManager : NSObject

+ (instancetype) sharedInstance;
- (void)cityForCurrentIP:(void (^)(City *city))completion;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
- (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;

@end

NS_ASSUME_NONNULL_END
