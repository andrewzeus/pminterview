//

//

//

//

//  Created by Andrew XU

//  Copyright (c) 2016 . All rights reserved.

//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
                                                                 failure:(void (^)(NSError *error))failure;

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
