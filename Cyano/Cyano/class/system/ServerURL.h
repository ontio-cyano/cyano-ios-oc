//
//  ServerURL.h
//  iQBTeacher
//
//  Created by Yuanhai on 13/7/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#ifndef ServerURL_h
#define ServerURL_h

/*(Server)*/


/*(Request Method)*/

#define REQUEST_PATCH @"PATCH"
#define REQUEST_POST @"POST"
#define REQUEST_GET @"GET"
#define REQUEST_DELETE @"DELETE"


/*(IP)*/

#define IP_ALL @"101.132.193.149:4027"


/*(Max Photos Count)*/

#define MaxImageCount 6


/*(Test Dapp Url)*/

#define URL_Test_Dapp @"http://101.132.193.149:5001/"


/*(Total Adress)*/

#define URL_ALL [NSString stringWithFormat:@"http://%@", IP_ALL]

// Dapps
#define URL_Dapps [NSString stringWithFormat:@"%@/dapps", URL_ALL]


#endif /* ServerURL_h */
