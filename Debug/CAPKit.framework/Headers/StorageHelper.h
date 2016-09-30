#import <FMDB/FMDatabaseQueue.h>

@interface StorageHelper : NSObject {
    NSMutableDictionary *dbDic;
    FMDatabaseQueue *queue;
}

@property (nonatomic, weak, readonly) CAPContainer *container;

- (instancetype) initWithContainer: (CAPContainer *) container;

- (NSObject *) load: (NSString *) key scope: (NSString *) scope;
- (BOOL) save: (NSString *) key value: (NSObject *) value scope: (NSString *) scope;
- (BOOL) save: (NSString *) key value: (NSObject *) value scope: (NSString *) scope timeout: (NSTimeInterval) time;


- (NSString *) loadString: (NSString *) key scope: (NSString *) scope;
@end
