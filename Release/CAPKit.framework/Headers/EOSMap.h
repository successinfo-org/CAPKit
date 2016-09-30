@interface EOSMap : NSObject <EOSMapInterface>{
    NSMutableDictionary *dataMap;
    
#ifdef DEBUG_EOS
    @public
    NSObject *parent;
#endif
}

@end
