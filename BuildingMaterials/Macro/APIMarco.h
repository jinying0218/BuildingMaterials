//
//  APIMarco.h
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#ifndef ProInspection_APIMarco_h
#define ProInspection_APIMarco_h

#define Domain @"http://www.d-anshun.com/appInterface"
//获取验证码
#define codePost_url Domain"/postCode"
//注册
#define Regist_URL Domain"/reg"
//找回密码
#define FindPassword_URL Domain"/findPassword"
//登陆接口
#define Login_URL Domain"/login"
//首页广告加载
#define Frist_ADLoad_URL Domain"/appAdLoad"
//首页秒杀加载
#define Frist_SecKillLoad_URL Domain"/appSeckillLoad"
//首页商家加载
#define First_CompanyLoad_URL Domain"/appCompanyLoad"
//首页换物加载
#define First_Exchange_URL Domain"/appExchangeLoad"

//获得维修人员列表和报事类型列表
#define GetRepairUserList_URL Domain"/inspect/app/routine/routineInspectionUserList.do"
//获得巡逻点的加密信息，用于二维码
#define GetQRCode_URL Domain"/inspect/app/routine/routineQRCode.do"

//巡检检查记录上传
#define UploadRecord_URL Domain"/inspect/app/routine/routineInspectionRecord.do"
//提交维修结果接口
#define UploadMaintain_URL Domain"/inspect/app/routine/routineInspectionMaintain.do"
//上传报事接口
#define UploadNotice_URL Domain"/inspect/app/routine/routineInspectionDefect.do"
//上传派工单
#define UploadDispatch_URL Domain"/inspect/app/routine/routineInspectionTaskAdd.do"
//签到接口
#define UploadPointSignIn_URL Domain"/inspect/app/routine/routinePointSignIn.do"


//获取照片，录音地址
#define ImageAndRecord_URL Domain"/inspect"





#endif
