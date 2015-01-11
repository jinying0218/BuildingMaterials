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
//商家列表
#define CompanyLoad_URL Domain"/companyLoad"
//商家详情
#define CompanyDetail_URL Domain"/companyLoadById"
//商家商品加载
#define CompanyGoodsLoad_URL Domain"/goodsLoadByCompanyId"


//首页商品加载
#define First_GoodsLoad_URL Domain"/appGoodsLoad"
//商品列表
#define GoodsLoad_URL Domain"/goodsLoad"
//商品类别
#define GoodsClassify_URL Domain"/goodsClassifyLoad"
//商品信息
#define GoodsInfo_URL Domain"/goodsLoadById"
//商品规格参数
#define GoodsParameters_URL Domain"/goodsParametersLoadById"

//首页换物加载
#define First_Exchange_URL Domain"/appExchangeLoad"
//以物换物列表
#define Exchange_URL Domain"/exchangeLoad"
//换物详情
#define ExchangeDetail_URL Domain"/exchangeLoadById"
//换物详情图片
#define ExchangeImage_URL Domain"/exchangeImageLoadById"
//换物发布
#define ExchangeAdd_URL Domain"/exchangeAdd"
//换物上传照片
#define ImageUpload_URL Domain"/ImageUpload"

//分类
#define Category_URL Domain"/goodsClassifyLoad"


//招聘
#define Invite_URL Domain"/postLoad"
//招聘类别
#define Invite_Category_URL Domain "/postClassifyLoad"
//招聘详情
#define Invite_Detail_URL Domain"/postMainLoad"
//岗位举报
#define Invite_PostRepor_URL Domain"/reportSave"
//岗位申请
#define Invite_PostApply_URL Domain"/postAskSave"




#endif
