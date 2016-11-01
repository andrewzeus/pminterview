//

//

//

//

//  Created by Andrew XU

//  Copyright (c) 2016 . All rights reserved.

//

#import "HttpTool.h"
#import "AFNetworking.h"

#import "AFURLRequestSerialization.h"


@implementation HttpTool

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    
    
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    
    NSString * withEndPoint = url;
    
    
    NSError * error;
    
    
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:withEndPoint parameters:parameters error:&error];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            failure(error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
           
            if (error) {
                failure(error);
            } else {
                
                success(results);
            }
        }
    }];
    [task resume];
    
    
}



+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    

    
    NSURLSession * session = [NSURLSession sharedSession];
    
    
    NSString * withEndPoint = url;
    
   
    
    NSError * error;
    
    
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:withEndPoint parameters:parameters error:&error];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            failure(error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            
            if (error) {
                failure(error);
            } else {
               
                success(results);
            }
        }
    }];
    [task resume];
   
    
}


@end
