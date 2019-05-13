##http://www.sqlines.com/online
sqllines:
mysql -> oracle



####mybatis-plus
> oracle生成代码时，表明大小写敏感，用全大写字母




###测试数据
1、创建用户
create user vue identified by "md5hkzhzh";
grant connect to vue;
grant dba to vue;
grant exp_full_database to vue;
grant imp_full_database to vue;
grant resource to vue;
grant unlimited tablespace to vue;

2、导入febs表
需要通过http://www.sqlines.com/online把mysql转为oracle，然后替换时间：
'2017...............' -> to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss')
'2018...............' -> to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss')
'2019...............' -> to_date('2019-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss')

3、导入告警相关表

从ogg17上获取配置数据的dmp，见crontab，然后倒入到vue库：
```
impdp vue/md5hkzhzh directory=dmpdir dumpfile=20190507_jsiam_ogg17.dmp logfile=20190507_jsiam_ogg17.log remap_schema=tacfm:vue TABLE_EXISTS_ACTION=TRUNCATE REMAP_TABLE=tacfm.T_SYS_USER:T_SYS_USER,tacfm.T_ALM_NM:T_ALM_NM,tacfm.T_ALM_NM_TYPE:T_ALM_NM_TYPE,tacfm.T_ALM_SPECIALTY:T_ALM_SPECIALTY,tacfm.T_SYS_AREA:T_SYS_AREA,tacfm.T_ALM_FIGR_SPLIT:T_ALM_FIGR_SPLIT,tacfm.T_ALM_PARM_SPLIT:T_ALM_PARM_SPLIT,tacfm.T_ALM_PARM_SPLIT_PLAN:T_ALM_PARM_SPLIT_PLAN,tacfm.T_ALM_PARM_PRIORITY:T_ALM_PARM_PRIORITY,tacfm.T_ALM_CUT_EVENT:T_ALM_CUT_EVENT,tacfm.T_ALM_CUT_EQP:T_ALM_CUT_EQP,tacfm.T_ALM_PARM_PRNT:T_ALM_PARM_PRNT,tacfm.T_ALM_PARM_DERIVE:T_ALM_PARM_DERIVE,tacfm.T_ALM_PARM_WSHIELD:T_ALM_PARM_WSHIELD,tacfm.T_ALM_FIGR_SHIELD:T_ALM_FIGR_SHIELD,tacfm.T_ALM_PARM_SHIELD:T_ALM_PARM_SHIELD,tacfm.T_ALM_PARM_SHIELD_PLAN:T_ALM_PARM_SHIELD_PLAN,tacfm.T_ALM_PARM_WBILL_EXC:T_ALM_PARM_WBILL_EXC,tacfm.T_ALM_FIGR_BILL_EXC:T_ALM_FIGR_BILL_EXC,tacfm.T_ALM_PARM_BILL_EXC:T_ALM_PARM_BILL_EXC,tacfm.T_ALM_FIGR_BILL:T_ALM_FIGR_BILL,tacfm.T_ALM_PARM_BILL:T_ALM_PARM_BILL,tacfm.T_ALM_PARM_BILL_EXPEND:T_ALM_PARM_BILL_EXPEND,tacfm.T_ALM_PARM_LOCATION:T_ALM_PARM_LOCATION,tacfm.T_ALM_CMOAS_RELATION:T_ALM_CMOAS_RELATION


-- 保留以下用户，将其他用户的is_valid状态设置为0
select * from t_sys_user t
--            update t_sys_user t set t.is_valid = 0
where t.user_login_name in ('zhangzao','zhangqi3','wangyunfei1','tangll','suijiankai','noc_dukai','liuchangfu','jsnoc_zys','jsnoc_zhuangjing','jsnoc_zhoujiujiu','jsnoc_zhoujia','jsnoc_zhengjiaqiang','jsnoc_zhaoxiaoyong','jsnoc_zhaoshiyang','jsnoc_zhangzhengkai','jsnoc_zhaichangting','jsnoc_yukehao','jsnoc_xuzhiguo','jsnoc_xuyang','jsnoc_xuhongwei','jsnoc_xiechenjun','jsnoc_wanlong','jsnoc_wangzi','jsnoc_wangshihui','jsnoc_wangpengpeng','jsnoc_wangpengfei','jsnoc_wanghanbin','jsnoc_tiancheng','jsnoc_sunyu','jsnoc_sunmin','jsnoc_shengxiang','jsnoc_qianzhiwei','jsnoc_qianfeng','jsnoc_panliangliang','jsnoc_liuyuanhua','jsnoc_liuhan','jsnoc_linmingqiang','jsnoc_lianchunhua','jsnoc_kongheng','jsnoc_jiangyongxi','jsnoc_jiadongliang','jsnoc_huzhuangcheng','jsnoc_huangqiang','jsnoc_htj','cailiang','chenling','guolei3','youjingyan','xuweifang','yueyuedong','hechao','shenyue','szchuanshu','baiaili','lisuyun','zhangyichen','xiaoding','zhuyi3','zjanxiaofang','panzixi','wujiacheng','guiwenlin','maolei','luhengyun','zhouyu6','fanningning','sz','guqiwen','wangzhh','yuemingyang','qiulinjie','xuminhua','yaoyayi','huahui','bulizhong','axfjk','chenjun7','youfei','sz135027','sz135073','sz135165','sz135183','sz135184','zhuxiaohu','wangguan','zhangli13','hechao','zhujunfei','peixiaoqin','chenguoxian','gongwendong','xuhaimin','liyanfei','xiaoejing','moxuming','jsnoc_weijie','jsnoc_yangli','jsnoc_xiecuilan','liuxiaochuan','huayu','jsnoc_bukunlin'
,'AUTO','admin','keeper','jss18913974568','telecomgroup', --iam,kps
'taisitong','hongxindaping','OTT','chuangxiang','szAlarmRelay','analyse','wulianwang',
'OSSAlarmRelay','socnew','soc','qingaosys','jyhpt','IPOSS','socqqsq','wuxianwangyou',
'riskops','riskops02','czwx','zhizhen','itvpt' --t_alm_relay
);

-- 修改以下用户为虚拟用户，虚拟用户不能登录系统，作为第三方接口如告警转发接口的鉴权
update t_sys_user set user_type = 2 where user_login_name in (
'AUTO','itvpt','OSSAlarmRelay','OTT','riskops','jyhpt','szAlarmRelay','wuxianwangyou','wulianwang','riskops02'
);



```