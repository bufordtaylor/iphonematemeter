#import "ServerAdapter.h"
#import "CJSONDeserializer.h"
#import "ApiManager.h"

@implementation ServerAdapter

-(id) initWithCallbackObj:(id)cobj successMeth:(SEL)successMeth_ failureMeth:(SEL)failureMeth_ {
	if (self = [super init]) {
		responseData = [[NSMutableData alloc] init];
		callbackObj = cobj;
		successMeth = successMeth_;
		failureMeth = failureMeth_;
	}
	return self;   
}

-(void) dealloc {
	[responseData release];
	[super dealloc];
}


-(void) calltest {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://imawesomer.com/"]];
	NSLog(@"%@",url);
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url
													   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
												   timeoutInterval:60];	
	NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self]; // release in callbacks
	if (!conn) {
		[self triggerCallback:failureMeth withArg:@"A connection could not be made."];
	}
}


-(void) call:(NSString*)apiFunction params:(NSDictionary*)params {
	NSString* queryStr = @"";
	int num = [params count];
	int i = 0;
	for (NSString* key in params) {
		NSString* val = (NSString*)[params objectForKey:key];
		queryStr = [NSString stringWithFormat:@"%@%@=%@", queryStr, key, [val stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		if (i < (num - 1)) {
			queryStr = [queryStr stringByAppendingString:@"&"];
		}
		i++;
	}
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@.com/%@?%@", ENVIRONMENT, apiFunction, queryStr]];
	NSLog(@"%@",url);
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url
													   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
												   timeoutInterval:60];	
	NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self]; // release in callbacks
	if (!conn) {
		[self triggerCallback:failureMeth withArg:@"A connection could not be made."];
	}
}

-(void)callWithFullURL:(NSString*)url {
	NSURL* formattedURL = [NSURL URLWithString:url];
	NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:formattedURL
													   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
												   timeoutInterval:60];
	NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if(!conn){
		[self triggerCallback:failureMeth withArg:@"A connection could not be made."];  // release in callbacks
	}
}

-(NSURL*) save:(NSString*)apiFunction params:(NSDictionary*)params {
	NSString* queryStr = @"";
	int num = [params count];
	int i = 0;
	for (NSString* key in params) {
		NSString* val = (NSString*)[params objectForKey:key];
		queryStr = [NSString stringWithFormat:@"%@%@=%@", queryStr, key, [val stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		if (i < (num - 1)) {
			queryStr = [queryStr stringByAppendingString:@"&"];
		}
		i++;
	}
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@.com/json/%@?%@", ENVIRONMENT, apiFunction, queryStr]];
	return url;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response {
    [responseData setLength:0];
	
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data {
    [responseData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection {
	[connection release];
	
	NSError* jsonError = nil;
	NSDictionary* jsonResult = [[CJSONDeserializer deserializer] deserializeAsDictionary:responseData error:&jsonError];
	
	NSLog(@"%@", jsonResult);
	if (jsonError) {
		[self triggerCallback:failureMeth withArg:@"JSON decoding error"];
		return;
	}
	[self triggerCallback:successMeth withArg:jsonResult];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[connection release];
	[self triggerCallback:failureMeth withArg:@"No internet connection available."];
}

-(void) triggerCallback:(SEL)meth withArg:(id)arg {
	NSMethodSignature* sig = [[callbackObj class] instanceMethodSignatureForSelector:meth];
	NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
	[invo setSelector:meth];
	[invo setArgument:&arg atIndex:2];
	[invo invokeWithTarget:callbackObj];
}

@end
