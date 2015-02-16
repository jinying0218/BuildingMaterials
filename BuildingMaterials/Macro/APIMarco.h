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

//////////  商家
//首页商家加载
#define First_CompanyLoad_URL Domain"/appCompanyLoad"
//商家列表
#define CompanyLoad_URL Domain"/companyLoad"
//商家详情
#define CompanyDetail_URL Domain"/companyLoadById"
//商家商品加载
#define CompanyGoodsLoad_URL Domain"/goodsLoadByCompanyId"
//商家类别加载
#define CompanyGoodsClassifyLoad_URL Domain"/goodsClassifyLoadByCompanyId"

//////////  商品相关
//首页商品加载
#define First_GoodsLoad_URL Domain"/appGoodsLoad"
//商品列表
#define GoodsLoad_URL Domain"/goodsLoad"
//商品类别
#define GoodsClassify_URL Domain"/goodsClassifyLoad"
//商品信息
#define GoodsInfo_URL Domain"/goodsLoadById"
//商品图片加载
#define GoodsImageLoad_URL Domain"/goodsImageLoadById"
//商品规格参数
#define GoodsParameters_URL Domain"/goodsParametersLoadById"
//商品评论加载
#define GoodsComment_URL Domain"/goodsCommentLoadById"
//发表商品评论
#define PostGoodsComment_URL Domain"/goodsComment"

//////////  换物
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

//////////   分类
//分类
#define Category_URL Domain"/goodsClassifyLoad"

//////////  论坛
//论坛
#define Forum_URL Domain"/forumClassifyLoad"
//论坛类别
#define ForumClassifyLoad_URL Domain"/forumLoad"
//帖子详情
#define ForumLoadById_URL Domain"/forumLoadById"
//帖子回复
#define ForumComment_URL Domain"/forumCommentLoadById"
//发表回复
#define CommentPost_URL Domain "/forumComment"
//帖子保存    发帖
#define ForumSave_URL Domain "/forumSave"


//////////  招聘
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

//////////  我的信息
//我的地址
#define Address_URL Domain"/addressLoad"
//删除地址
#define AddressDelete_URL Domain"/addressDelete"
//保存地址
#define AddressSave_URL Domain"/addressSave"

//代付款
#define WaitForPay_URL Domain"/myOrderLoad"     //// 订单数组,只显示 ORDER_STATUS=WAIT_PAY 的对象
//取消订单
#define DeleteOrder_URL Domain"/orderDelete"
//订单详情
#define OrderDetail_URL Domain"/orderGoodsLoad"
//退款
#define OrderAskBack_URL Domain"/orderAskBack"
//确定收货
#define OrderGet_URL Domain"/orderGet"


//订单商品加载
#define OrderGoodsLoad_URL Domain"/orderGoodsLoad"
//运输方式加载
#define TransportLoad_URL Domain"/transportLoad"


//  我的收藏
#define CollectLoad_URL Domain"/collectionLoad"
//删除我的收藏
#define CollectDelete_URL Domain "/collectionDelete"
//收藏商家  . 商品   collectionType GOODS   COMPANY
#define Collection_URL Domain"/collection"

//购物车
#define GoodsCarLoad_URL Domain"/goodsCarLoad"
//加入购物车
#define ShopCarAdd_URL Domain"/carAdd"
//购物车商品删除
#define GoodsCarDeleteURL Domain"/goodsCarDelete"

//////------ 购买 -----
//秒杀
#define SeckillCheck Domain"/seckillCheck"
#define SeckillGoodsLoad_URL Domain"/seckillGoodsLoad"

//购买接口      //购物车结算接口
#define OrderSure_URL Domain"/orderSure"
//订单数据加载
#define OrderSureLoad_URL Domain"/orderSureLoad"
//订单最后确认
#define OrderPost_URL Domain"/orderPost"
#define CompanyePost_URL Domain"/companyPost"

///// 支付
#define Pay_URL @"http://www.d-anshun.com/aliPay/payApp"

#endif
