//
//  APIMarco.h
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#ifndef ProInspection_APIMarco_h
#define ProInspection_APIMarco_h

#define Domain @"http://120.24.230.212/appInterface"
//获取验证码
#define codePost_url Domain"/codePost"
//注册
#define Regist_URL Domain"/reg"
//找回密码
#define FindPassword_URL Domain"/findPassword"
//登陆接口
#define Login_URL Domain"/login"


//获取任务列表接口
#define GetTask_URL Domain"/inspect/app/routine/routineInspectionTask.do"
//获取任务状态的接口
#define GetTaskState_URL Domain"/inspect/app/routine/routineInspectionTaskState.do"
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
