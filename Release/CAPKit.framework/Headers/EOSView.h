@interface EOSView : UIView{
#ifdef DEBUG_EOS_DRAWRECT
    UIColor *debugColor;
#endif
}

@property (nonatomic, weak) AbstractUIWidget *widget;

@end
