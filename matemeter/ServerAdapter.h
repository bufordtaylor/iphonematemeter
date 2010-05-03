#import <Foundation/Foundation.h>

@interface ServerAdapter : NSObject {
	NSMutableData* responseData;
	id callbackObj;
	SEL successMeth;
	SEL failureMeth;
}

-(id) initWithCallbackObj:(id)cobj successMeth:(SEL)successMeth_ failureMeth:(SEL)failureMeth_;
-(void) call:(NSString*)apiFunction params:(NSDictionary*)params;
-(NSURL*) save:(NSString*)apiFunction params:(NSDictionary*)params;
-(void) callWithFullURL:(NSString*)url;

/* private */
-(void) triggerCallback:(SEL)meth withArg:(id)arg;

@end
