@interface EOSView : UIView{
#ifdef DEBUG_EOS
    UIColor *debugColor;
#endif
}

@property (nonatomic, weak) AbstractUIWidget *widget;

@end
