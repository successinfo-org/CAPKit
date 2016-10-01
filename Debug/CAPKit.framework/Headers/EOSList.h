@interface EOSList : NSObject <EOSListInterface>{
    NSMutableArray *list;
    
    @public
    NSObject *parent;
}

- (id) initWithArray: (NSArray *) array;

@end
