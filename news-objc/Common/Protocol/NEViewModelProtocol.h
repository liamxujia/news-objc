//
//  NEViewModelProtocol.h
//  CatHub
//
//  Created by stlndm on 2018/9/18.
//  Copyright © 2018年 stlndm. All rights reserved.
//

#ifndef NEViewModelProtocol_h
#define NEViewModelProtocol_h

@protocol NEViewModelProtocol <NSObject>
@optional
- (void)bindIndexPath:(NSIndexPath *)indexPath;
- (void)bindSection:(NSUInteger)section;
- (void)subviewsLayout;
- (void)bindViewModel:(id)viewModel;
@end
#endif /* NEViewModelProtocol_h */
