//
//  myMath.c
//  SocketDemo
//
//  Created by 李伟超 on 16/2/25.
//  Copyright © 2016年 LWC. All rights reserved.
//

#include "myMath.h"

void test(char a[]) {
    for (int i = 0; i < sizeof(&a); i++) {
        printf("%c\n", a[i]);
    }
}
