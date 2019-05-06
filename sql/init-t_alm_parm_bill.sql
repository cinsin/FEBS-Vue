

-- Create table
create table T_SYS_AREA
(
  area_id           VARCHAR2(32) not null,
  area_name         VARCHAR2(48) not null,
  area_code         VARCHAR2(32) not null,
  prnt_area_id      VARCHAR2(32) default '0' not null,
  is_valid          NUMBER(1) default 1 not null,
  sort_ord          NUMBER(16) default 0 not null,
  date_created      DATE not null,
  last_updated      DATE not null,
  area_desc         VARCHAR2(256),
  last_time         DATE,
  max_interval      NUMBER(16),
  quarter_count     NUMBER(16),
  hour_count        NUMBER(16),
  day_count         NUMBER(16),
  three_day_count   NUMBER(16),
  week_count        NUMBER(16),
  month_count       NUMBER(16),
  year_count        NUMBER(16),
  quarter_alm_rdo   NUMBER(6),
  hour_alm_rdo      NUMBER(6),
  day_alm_rdo       NUMBER(6),
  week_alm_rdo      NUMBER(6),
  month_alm_rdo     NUMBER(6),
  piece_count       NUMBER(16),
  piece_alm_rdo     NUMBER(6),
  trhee_day_alm_rdo NUMBER(6)
);
-- Add comments to the table 
comment on table T_SYS_AREA
  is 'SAREA区域';
-- Add comments to the columns 
comment on column T_SYS_AREA.area_id
  is '网管区域号';
comment on column T_SYS_AREA.area_name
  is '网管区域名';
comment on column T_SYS_AREA.area_code
  is '网管区域代码';
comment on column T_SYS_AREA.prnt_area_id
  is '父区域:''0''-无父节点';
comment on column T_SYS_AREA.is_valid
  is '有效:1-是;0-否';
comment on column T_SYS_AREA.sort_ord
  is '排序次序';
comment on column T_SYS_AREA.date_created
  is '新增时间';
comment on column T_SYS_AREA.last_updated
  is '修改时间';
comment on column T_SYS_AREA.area_desc
  is '区域说明';
comment on column T_SYS_AREA.last_time
  is '最后告警时间';
comment on column T_SYS_AREA.max_interval
  is '最长告警间隔(分)';
comment on column T_SYS_AREA.quarter_count
  is '一刻钟告警数';
comment on column T_SYS_AREA.hour_count
  is '小时告警数';
comment on column T_SYS_AREA.day_count
  is '一天告警数';
comment on column T_SYS_AREA.three_day_count
  is '三天告警数';
comment on column T_SYS_AREA.week_count
  is '周告警数';
comment on column T_SYS_AREA.month_count
  is '月告警数';
comment on column T_SYS_AREA.year_count
  is '年告警数';
comment on column T_SYS_AREA.quarter_alm_rdo
  is '一刻钟变化率红线(%)';
comment on column T_SYS_AREA.hour_alm_rdo
  is '小时变化率红线(%)';
comment on column T_SYS_AREA.day_alm_rdo
  is '日变化率红线(%)';
comment on column T_SYS_AREA.week_alm_rdo
  is '周变化率红线(%)';
comment on column T_SYS_AREA.month_alm_rdo
  is '月变化率红线(%)';
comment on column T_SYS_AREA.piece_count
  is '片段告警数';
comment on column T_SYS_AREA.piece_alm_rdo
  is '片段变化率红线(%)';
comment on column T_SYS_AREA.trhee_day_alm_rdo
  is '三天变化率红线(%)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SYS_AREA
  add constraint PK_T_SYS_AREA primary key (AREA_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_SYS_AREA
  add constraint UK_AREA_CODE_T_SYS_AR unique (AREA_CODE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


--------------------------



-- Create table
create table T_SYS_USER
(
  user_id          VARCHAR2(32) not null,
  area_id          VARCHAR2(32) not null,
  user_name        VARCHAR2(64) not null,
  user_gender_type NUMBER(6) default 0 not null,
  user_login_name  VARCHAR2(64) not null,
  user_login_pwd   VARCHAR2(64) not null,
  is_valid         NUMBER(1) default 1 not null,
  date_created     DATE not null,
  last_updated     DATE not null,
  user_mobile_num  VARCHAR2(32) not null,
  user_office_num  VARCHAR2(32),
  user_mail        VARCHAR2(64),
  user_desc        VARCHAR2(256),
  login_wrong_time NUMBER default 0 not null,
  spec_id          VARCHAR2(32)
);
-- Add comments to the table 
comment on table T_SYS_USER
  is 'SUSER系统用户';
-- Add comments to the columns 
comment on column T_SYS_USER.user_id
  is '用户号';
comment on column T_SYS_USER.area_id
  is '网管区域号';
comment on column T_SYS_USER.user_name
  is '中文全名';
comment on column T_SYS_USER.user_gender_type
  is '性别:1-男;0-女';
comment on column T_SYS_USER.user_login_name
  is '登录名';
comment on column T_SYS_USER.user_login_pwd
  is '登录密码';
comment on column T_SYS_USER.is_valid
  is '有效:1-是;0-否';
comment on column T_SYS_USER.date_created
  is '新增时间';
comment on column T_SYS_USER.last_updated
  is '修改时间';
comment on column T_SYS_USER.user_mobile_num
  is '手机号';
comment on column T_SYS_USER.user_office_num
  is '办公电话';
comment on column T_SYS_USER.user_mail
  is '邮箱';
comment on column T_SYS_USER.user_desc
  is '用户说明';
comment on column T_SYS_USER.login_wrong_time
  is '连续错误登陆次数，如果该用户被锁，只需将该值设为0即可解锁';
comment on column T_SYS_USER.spec_id
  is '专业id';
-- Create/Recreate indexes 
create index FK_SYS_AREA_USER on T_SYS_USER (AREA_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_SYS_USER
  add constraint PK_T_SYS_USER primary key (USER_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_SYS_USER
  add constraint UK_LOGIN_NAME_T_SYS_US unique (USER_LOGIN_NAME)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_SYS_USER
  add constraint FKT_SYS_USER_T_SYS_ARE foreign key (AREA_ID)
  references T_SYS_AREA (AREA_ID);







-- Create table
create table T_ALM_SPECIALTY
(
  spec_id           VARCHAR2(32) not null,
  spec_code         VARCHAR2(32) not null,
  spec_name         VARCHAR2(64) not null,
  date_created      DATE not null,
  last_updated      DATE not null,
  last_time         DATE,
  max_interval      NUMBER(16),
  quarter_count     NUMBER(16),
  hour_count        NUMBER(16),
  day_count         NUMBER(16),
  three_day_count   NUMBER(16),
  week_count        NUMBER(16),
  month_count       NUMBER(16),
  year_count        NUMBER(16),
  quarter_alm_rdo   NUMBER(6),
  hour_alm_rdo      NUMBER(6),
  day_alm_rdo       NUMBER(6),
  week_alm_rdo      NUMBER(6),
  month_alm_rdo     NUMBER(6),
  piece_count       NUMBER(16),
  piece_alm_rdo     NUMBER(6),
  trhee_day_alm_rdo NUMBER(6),
  spec_desc         VARCHAR2(256),
  sort_ord          NUMBER(16) default 0 not null
);
-- Add comments to the table 
comment on table T_ALM_SPECIALTY
  is 'ASPEC网管专业';
-- Add comments to the columns 
comment on column T_ALM_SPECIALTY.spec_id
  is '专业大类编号';
comment on column T_ALM_SPECIALTY.spec_code
  is '专业代码';
comment on column T_ALM_SPECIALTY.spec_name
  is '专业名称';
comment on column T_ALM_SPECIALTY.date_created
  is '新增时间';
comment on column T_ALM_SPECIALTY.last_updated
  is '修改时间';
comment on column T_ALM_SPECIALTY.last_time
  is '最后告警时间';
comment on column T_ALM_SPECIALTY.max_interval
  is '最长告警间隔(分)';
comment on column T_ALM_SPECIALTY.quarter_count
  is '一刻钟告警数';
comment on column T_ALM_SPECIALTY.hour_count
  is '小时告警数';
comment on column T_ALM_SPECIALTY.day_count
  is '一天告警数';
comment on column T_ALM_SPECIALTY.three_day_count
  is '三天告警数';
comment on column T_ALM_SPECIALTY.week_count
  is '周告警数';
comment on column T_ALM_SPECIALTY.month_count
  is '月告警数';
comment on column T_ALM_SPECIALTY.year_count
  is '年告警数';
comment on column T_ALM_SPECIALTY.quarter_alm_rdo
  is '一刻钟变化率红线(%)';
comment on column T_ALM_SPECIALTY.hour_alm_rdo
  is '小时变化率红线(%)';
comment on column T_ALM_SPECIALTY.day_alm_rdo
  is '日变化率红线(%)';
comment on column T_ALM_SPECIALTY.week_alm_rdo
  is '周变化率红线(%)';
comment on column T_ALM_SPECIALTY.month_alm_rdo
  is '月变化率红线(%)';
comment on column T_ALM_SPECIALTY.piece_count
  is '片段告警数';
comment on column T_ALM_SPECIALTY.piece_alm_rdo
  is '片段变化率红线(%)';
comment on column T_ALM_SPECIALTY.trhee_day_alm_rdo
  is '三天变化率红线(%)';
comment on column T_ALM_SPECIALTY.spec_desc
  is '专业描述';
comment on column T_ALM_SPECIALTY.sort_ord
  is '排序次序';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ALM_SPECIALTY
  add constraint PK_T_ALM_SPECIALTY primary key (SPEC_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_SPECIALTY
  add constraint UK_SPEC_CODE_T_ALM_SP unique (SPEC_CODE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );










-- Create table
create table T_ALM_NM_TYPE
(
  nmty_id      VARCHAR2(32) not null,
  nmty_code    VARCHAR2(32) not null,
  nmty_name    VARCHAR2(48) not null,
  date_created DATE not null,
  last_updated DATE not null
);
-- Add comments to the table 
comment on table T_ALM_NM_TYPE
  is 'ANMTY网管类型';
-- Add comments to the columns 
comment on column T_ALM_NM_TYPE.nmty_id
  is '网管类型编号';
comment on column T_ALM_NM_TYPE.nmty_code
  is '网管类型代码';
comment on column T_ALM_NM_TYPE.nmty_name
  is '网管类型名称';
comment on column T_ALM_NM_TYPE.date_created
  is '新增时间';
comment on column T_ALM_NM_TYPE.last_updated
  is '修改时间';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ALM_NM_TYPE
  add constraint PK_T_ALM_NM_TYPE primary key (NMTY_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_NM_TYPE
  add constraint UK_NMTY_CODE_T_ALM_NM unique (NMTY_CODE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );









-- Create table
create table T_ALM_NM
(
  nm_id                VARCHAR2(32) not null,
  spec_id              VARCHAR2(32) not null,
  area_id              VARCHAR2(32) not null,
  user_id              VARCHAR2(32) not null,
  nmty_id              VARCHAR2(32) not null,
  nm_code              VARCHAR2(32) not null,
  nm_name              VARCHAR2(48) not null,
  subspec_code         VARCHAR2(32),
  nm_is_alarm_id_clear NUMBER(1) default 1 not null,
  nm_effective_len     NUMBER(6) not null,
  is_valid             NUMBER(1) default 1 not null,
  sort_ord             NUMBER(16) default 0 not null,
  date_created         DATE not null,
  last_updated         DATE not null,
  is_chk               NUMBER(1) default 0 not null,
  is_timeout           NUMBER(1) default 0 not null,
  timeout_len          NUMBER(6),
  nm_mgr               VARCHAR2(64),
  nm_mgr_mobile        VARCHAR2(32),
  nm_mgr_num           VARCHAR2(32),
  nm_fcty              VARCHAR2(64),
  nm_fcty_mgr          VARCHAR2(64),
  nm_fcty_mobile       VARCHAR2(32),
  nm_fcty_num          VARCHAR2(32),
  nm_rspr              VARCHAR2(64),
  nm_rspr_mobile       VARCHAR2(32),
  nm_rspr_num          VARCHAR2(32),
  nm_desc              VARCHAR2(256),
  max_interval         NUMBER(16),
  quarter_count        NUMBER(16),
  hour_count           NUMBER(16),
  day_count            NUMBER(16),
  three_day_count      NUMBER(16),
  week_count           NUMBER(16),
  month_count          NUMBER(16),
  year_count           NUMBER(16),
  quarter_alm_rdo      NUMBER(6),
  hour_alm_rdo         NUMBER(6),
  day_alm_rdo          NUMBER(6),
  week_alm_rdo         NUMBER(6),
  month_alm_rdo        NUMBER(6),
  last_time            DATE,
  piece_count          NUMBER(16),
  piece_alm_rdo        NUMBER(6),
  trhee_day_alm_rdo    NUMBER(6)
);
-- Add comments to the table 
comment on table T_ALM_NM
  is 'ANM网管';
-- Add comments to the columns 
comment on column T_ALM_NM.nm_id
  is '网管编号';
comment on column T_ALM_NM.spec_id
  is '专业大类编号';
comment on column T_ALM_NM.area_id
  is '网管区域号';
comment on column T_ALM_NM.user_id
  is '用户号';
comment on column T_ALM_NM.nmty_id
  is '网管类型编号';
comment on column T_ALM_NM.nm_code
  is '网管代码';
comment on column T_ALM_NM.nm_name
  is '网管名称';
comment on column T_ALM_NM.subspec_code
  is '子专业代码';
comment on column T_ALM_NM.nm_is_alarm_id_clear
  is '网管告警编号恢复:0-否;1-是';
comment on column T_ALM_NM.nm_effective_len
  is '告警有效天数';
comment on column T_ALM_NM.is_valid
  is '有效:1-是;0-否';
comment on column T_ALM_NM.sort_ord
  is '排序次序';
comment on column T_ALM_NM.date_created
  is '新增时间';
comment on column T_ALM_NM.last_updated
  is '修改时间';
comment on column T_ALM_NM.is_chk
  is '开启自检告警超时:0-否;1-是';
comment on column T_ALM_NM.is_timeout
  is '超时状态:0-否;1-是';
comment on column T_ALM_NM.timeout_len
  is '超时时长(分)';
comment on column T_ALM_NM.nm_mgr
  is '局方负责人';
comment on column T_ALM_NM.nm_mgr_mobile
  is '局方负责人手机';
comment on column T_ALM_NM.nm_mgr_num
  is '局方负责人电话';
comment on column T_ALM_NM.nm_fcty
  is '网管厂家';
comment on column T_ALM_NM.nm_fcty_mgr
  is '网管厂家联系人';
comment on column T_ALM_NM.nm_fcty_mobile
  is '网管厂家联系人手机';
comment on column T_ALM_NM.nm_fcty_num
  is '网管厂家联系电话';
comment on column T_ALM_NM.nm_rspr
  is '公司接口人';
comment on column T_ALM_NM.nm_rspr_mobile
  is '公司接口人手机';
comment on column T_ALM_NM.nm_rspr_num
  is '公司接口人电话';
comment on column T_ALM_NM.nm_desc
  is '网管描述';
comment on column T_ALM_NM.max_interval
  is '最长告警间隔(分)';
comment on column T_ALM_NM.quarter_count
  is '一刻钟告警数';
comment on column T_ALM_NM.hour_count
  is '小时告警数';
comment on column T_ALM_NM.day_count
  is '一天告警数';
comment on column T_ALM_NM.three_day_count
  is '三天告警数';
comment on column T_ALM_NM.week_count
  is '周告警数';
comment on column T_ALM_NM.month_count
  is '月告警数';
comment on column T_ALM_NM.year_count
  is '年告警数';
comment on column T_ALM_NM.quarter_alm_rdo
  is '一刻钟变化率红线(%)';
comment on column T_ALM_NM.hour_alm_rdo
  is '小时变化率红线(%)';
comment on column T_ALM_NM.day_alm_rdo
  is '日变化率红线(%)';
comment on column T_ALM_NM.week_alm_rdo
  is '周变化率红线(%)';
comment on column T_ALM_NM.month_alm_rdo
  is '月变化率红线(%)';
comment on column T_ALM_NM.last_time
  is '最后告警时间';
comment on column T_ALM_NM.piece_count
  is '片段告警数';
comment on column T_ALM_NM.piece_alm_rdo
  is '片段变化率红线(%)';
comment on column T_ALM_NM.trhee_day_alm_rdo
  is '三天变化率红线(%)';
-- Create/Recreate indexes 
create index FK_ALM_AREA_NM on T_ALM_NM (AREA_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index FK_ALM_NMTY_NM on T_ALM_NM (NMTY_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index FK_ALM_NM_USER on T_ALM_NM (USER_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index FK_ALM_SPECI_NM on T_ALM_NM (SPEC_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ALM_NM
  add constraint PK_T_ALM_NM primary key (NM_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_NM
  add constraint UK_NM_CODE_T_ALM_NM unique (NM_CODE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_NM
  add constraint FKT_ALM_NM_T_ALM_NM_ foreign key (NMTY_ID)
  references T_ALM_NM_TYPE (NMTY_ID);
alter table T_ALM_NM
  add constraint FKT_ALM_NM_T_ALM_SPE foreign key (SPEC_ID)
  references T_ALM_SPECIALTY (SPEC_ID);
alter table T_ALM_NM
  add constraint FKT_ALM_NM_T_SYS_ARE foreign key (AREA_ID)
  references T_SYS_AREA (AREA_ID);
alter table T_ALM_NM
  add constraint FKT_ALM_NM_T_SYS_USE foreign key (USER_ID)
  references T_SYS_USER (USER_ID);















----------------------------




-- Create table
create table T_ALM_FIGR_BILL
(
  fgbi_id      VARCHAR2(32) not null,
  user_id      VARCHAR2(32) not null,
  fgbi_name    VARCHAR2(64) not null,
  fgbi_desc    VARCHAR2(256),
  is_valid     NUMBER(1) default 1 not null,
  user_updated VARCHAR2(32),
  sort_ord     NUMBER(16) default 0 not null,
  date_created DATE not null,
  last_updated DATE not null
);
-- Add comments to the table 
comment on table T_ALM_FIGR_BILL
  is 'AFGBI派单分组';
-- Add comments to the columns 
comment on column T_ALM_FIGR_BILL.fgbi_id
  is '派单分组编号';
comment on column T_ALM_FIGR_BILL.user_id
  is '用户号';
comment on column T_ALM_FIGR_BILL.fgbi_name
  is '派单分组名';
comment on column T_ALM_FIGR_BILL.fgbi_desc
  is '派单分组描述';
comment on column T_ALM_FIGR_BILL.is_valid
  is '有效:1-是;0-否';
comment on column T_ALM_FIGR_BILL.user_updated
  is '修改人';
comment on column T_ALM_FIGR_BILL.sort_ord
  is '排序次序';
comment on column T_ALM_FIGR_BILL.date_created
  is '新增时间';
comment on column T_ALM_FIGR_BILL.last_updated
  is '修改时间';
-- Create/Recreate indexes 
create index FK_ALM_USER_FIBI on T_ALM_FIGR_BILL (USER_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ALM_FIGR_BILL
  add constraint PK_T_ALM_FIGR_BILL primary key (FGBI_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_FIGR_BILL
  add constraint UK_FGBI_NAME_T_ALM_FI unique (FGBI_NAME)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_FIGR_BILL
  add constraint FKT_ALM_FIGR_BILL_T_SYS_USE foreign key (USER_ID)
  references T_SYS_USER (USER_ID);





----------------------------------


-- Create table
create table T_ALM_PARM_BILL
(
  pbil_id                  VARCHAR2(32) not null,
  user_id                  VARCHAR2(32) not null,
  nm_id                    VARCHAR2(32) not null,
  fgbi_id                  VARCHAR2(32) not null,
  related_area_code_inc    VARCHAR2(256),
  related_area_code_exc    VARCHAR2(256),
  fault_area_name_inc      VARCHAR2(256),
  fault_area_name_exc      VARCHAR2(256),
  related_subarea_code_inc VARCHAR2(256),
  related_subarea_code_exc VARCHAR2(256),
  fault_subarea_name_inc   VARCHAR2(256),
  fault_subarea_name_exc   VARCHAR2(256),
  priority_inc             VARCHAR2(64),
  priority_exc             VARCHAR2(64),
  cleared_inc              VARCHAR2(64),
  cleared_exc              VARCHAR2(64),
  cut_stat_inc             VARCHAR2(64),
  cut_stat_exc             VARCHAR2(64),
  user_label_inc           VARCHAR2(512),
  user_label_exc           VARCHAR2(512),
  user_label_ucase_inc     VARCHAR2(512),
  user_label_ucase_exc     VARCHAR2(512),
  summary_inc              VARCHAR2(512),
  summary_exc              VARCHAR2(512),
  summary_ucase_inc        VARCHAR2(512),
  summary_ucase_exc        VARCHAR2(512),
  msty_id_inc              VARCHAR2(256),
  msty_id_exc              VARCHAR2(256),
  msty_name_inc            VARCHAR2(512),
  msty_name_exc            VARCHAR2(512),
  fault_info_inc           VARCHAR2(256),
  fault_info_exc           VARCHAR2(256),
  eqty_id_inc              VARCHAR2(256),
  eqty_id_exc              VARCHAR2(256),
  eqty_name_inc            VARCHAR2(512),
  eqty_name_exc            VARCHAR2(512),
  eqp_id_inc               VARCHAR2(256),
  eqp_id_exc               VARCHAR2(256),
  eqp_name_inc             VARCHAR2(512),
  eqp_name_exc             VARCHAR2(512),
  eqp_spoffice_inc         VARCHAR2(256),
  eqp_spoffice_exc         VARCHAR2(256),
  eqp_place_inc            VARCHAR2(256),
  eqp_place_exc            VARCHAR2(256),
  eqp_post_inc             VARCHAR2(256),
  eqp_post_exc             VARCHAR2(256),
  port_id_inc              VARCHAR2(256),
  port_id_exc              VARCHAR2(256),
  port_name_inc            VARCHAR2(256),
  port_name_exc            VARCHAR2(256),
  alm_rspr_inc             VARCHAR2(256),
  alm_rspr_exc             VARCHAR2(256),
  contexta_inc             VARCHAR2(256),
  contexta_exc             VARCHAR2(256),
  contextb_inc             VARCHAR2(256),
  contextb_exc             VARCHAR2(256),
  contextc_inc             VARCHAR2(256),
  contextc_exc             VARCHAR2(256),
  contextd_inc             VARCHAR2(256),
  contextd_exc             VARCHAR2(256),
  contexte_inc             VARCHAR2(256),
  contexte_exc             VARCHAR2(256),
  contextf_inc             VARCHAR2(256),
  contextf_exc             VARCHAR2(256),
  details_inc              VARCHAR2(512),
  details_exc              VARCHAR2(512),
  details_ucase_inc        VARCHAR2(512),
  details_ucase_exc        VARCHAR2(512),
  mediation_time_week_inc  VARCHAR2(256),
  mediation_time_week_exc  VARCHAR2(256),
  mediation_time_hour_inc  VARCHAR2(256),
  mediation_time_hour_exc  VARCHAR2(256),
  user_updated             VARCHAR2(32),
  audit_stat               NUMBER(6) default 0 not null,
  date_created             DATE not null,
  last_updated             DATE not null,
  pbil_code                VARCHAR2(64) not null,
  pbil_name                VARCHAR2(128) not null,
  pbil_sw_stat             NUMBER(6) default 0 not null,
  pbil_level               NUMBER(6) default 0 not null,
  pbil_is_revokable        NUMBER(1) default 1 not null,
  pbil_is_ignore_cleared   NUMBER(1) default 0 not null,
  pbil_is_merge            NUMBER(1) default 1 not null,
  pbil_is_rebill           NUMBER(1) default 0 not null,
  pbil_rebil_len           NUMBER(6),
  pbil_delay_len           NUMBER(6) not null,
  pbil_eqp_rep_len         NUMBER(6) not null,
  pbil_limit_type          NUMBER(6) default 0 not null,
  pbil_limit_count         NUMBER(6) default 1 not null,
  main_specialid           VARCHAR2(48),
  specialid                VARCHAR2(48),
  faulttypeid              VARCHAR2(48),
  bill_priority            VARCHAR2(48),
  alarm_content            VARCHAR2(48),
  alarm_obj_name           VARCHAR2(256),
  alarm_index_name         VARCHAR2(48),
  alarm_city               VARCHAR2(48),
  bill_area_id             VARCHAR2(48),
  is_auto                  NUMBER(1) default 1 not null,
  net_name                 VARCHAR2(256),
  trader_info              VARCHAR2(256),
  fault_actual             VARCHAR2(256),
  fault_info               VARCHAR2(256),
  title                    VARCHAR2(256),
  fault_src_id             VARCHAR2(48),
  alarm_type               VARCHAR2(48),
  spoffice                 VARCHAR2(256),
  pbil_desc                VARCHAR2(256),
  pbil_merge_label         VARCHAR2(256),
  pbil_rebill_hour_inc     VARCHAR2(256),
  mediation_time_start     NUMBER(16,7),
  mediation_time_end       NUMBER(16,7),
  control_permissions      NUMBER(6),
  pbex_id                  VARCHAR2(32),
  complaint_info           VARCHAR2(255),
  bill_type                NUMBER(1) default 1,
  bill_area_code           VARCHAR2(256),
  is_related_grid          NUMBER(1) default 0 not null,
  pbil_first_merge_label   VARCHAR2(256),
  merger_cause             VARCHAR2(512),
  merger_info              VARCHAR2(512),
  begin_time               DATE,
  end_time                 DATE,
  nm_name_inc              VARCHAR2(256),
  is_cross_nm              NUMBER(1) default 0,
  net_code                 VARCHAR2(1024),
  master_summary_inc       VARCHAR2(256),
  req_user                 VARCHAR2(64),
  req_detail               VARCHAR2(1024),
  req_auditer              VARCHAR2(32),
  req_developer            VARCHAR2(64),
  req_publisher            VARCHAR2(64),
  pub_time                 DATE,
  release_note             VARCHAR2(512),
  scope_app                VARCHAR2(512)
);

-- Add comments to the table 
comment on table T_ALM_PARM_BILL
  is 'APBIL派单模式';
-- Add comments to the columns 
comment on column T_ALM_PARM_BILL.pbil_id
  is '派单编号';
comment on column T_ALM_PARM_BILL.user_id
  is '用户号';
comment on column T_ALM_PARM_BILL.nm_id
  is '网管编号';
comment on column T_ALM_PARM_BILL.fgbi_id
  is '派单分组编号';
comment on column T_ALM_PARM_BILL.related_area_code_inc
  is '故障区域代码包含';
comment on column T_ALM_PARM_BILL.related_area_code_exc
  is '故障区域代码不包含';
comment on column T_ALM_PARM_BILL.fault_area_name_inc
  is '故障区域名包含';
comment on column T_ALM_PARM_BILL.fault_area_name_exc
  is '故障区域名不包含';
comment on column T_ALM_PARM_BILL.related_subarea_code_inc
  is '故障子区域代码包含';
comment on column T_ALM_PARM_BILL.related_subarea_code_exc
  is '故障子区域代码不包含';
comment on column T_ALM_PARM_BILL.fault_subarea_name_inc
  is '故障子区域名包含';
comment on column T_ALM_PARM_BILL.fault_subarea_name_exc
  is '故障子区域名不包含';
comment on column T_ALM_PARM_BILL.priority_inc
  is '优先级包含:1-紧急;2-主要;3-次要;4-警告;9-未定';
comment on column T_ALM_PARM_BILL.priority_exc
  is '优先级不包含:1-紧急;2-主要;3-次要;4-警告;9-未定';
comment on column T_ALM_PARM_BILL.cleared_inc
  is '恢复标识包含:0-未恢复;1-网管恢复';
comment on column T_ALM_PARM_BILL.cleared_exc
  is '恢复标识不包含:0-未恢复;1-网管恢复';
comment on column T_ALM_PARM_BILL.cut_stat_inc
  is '割接状态包含:0-无割接;1-正在割接';
comment on column T_ALM_PARM_BILL.cut_stat_exc
  is '割接状态不包含:0-无割接;1-正在割接';
comment on column T_ALM_PARM_BILL.user_label_inc
  is '设备名称包含';
comment on column T_ALM_PARM_BILL.user_label_exc
  is '设备名称不包含';
comment on column T_ALM_PARM_BILL.user_label_ucase_inc
  is '设备名称大写包含';
comment on column T_ALM_PARM_BILL.user_label_ucase_exc
  is '设备名称大写不包含';
comment on column T_ALM_PARM_BILL.summary_inc
  is '概要包含';
comment on column T_ALM_PARM_BILL.summary_exc
  is '概要不包含';
comment on column T_ALM_PARM_BILL.summary_ucase_inc
  is '概要大写包含';
comment on column T_ALM_PARM_BILL.summary_ucase_exc
  is '概要大写不包含';
comment on column T_ALM_PARM_BILL.msty_id_inc
  is '消息类型编号包含';
comment on column T_ALM_PARM_BILL.msty_id_exc
  is '消息类型编号不包含';
comment on column T_ALM_PARM_BILL.msty_name_inc
  is '消息类型名包含';
comment on column T_ALM_PARM_BILL.msty_name_exc
  is '消息类型名不包含';
comment on column T_ALM_PARM_BILL.fault_info_inc
  is '故障信息包含';
comment on column T_ALM_PARM_BILL.fault_info_exc
  is '故障信息不包含';
comment on column T_ALM_PARM_BILL.eqty_id_inc
  is '网元类型编号包含';
comment on column T_ALM_PARM_BILL.eqty_id_exc
  is '网元类型编号不包含';
comment on column T_ALM_PARM_BILL.eqty_name_inc
  is '网元类型名包含';
comment on column T_ALM_PARM_BILL.eqty_name_exc
  is '网元类型名不包含';
comment on column T_ALM_PARM_BILL.eqp_id_inc
  is '网元号包含';
comment on column T_ALM_PARM_BILL.eqp_id_exc
  is '网元号不包含';
comment on column T_ALM_PARM_BILL.eqp_name_inc
  is '网元名称包含';
comment on column T_ALM_PARM_BILL.eqp_name_exc
  is '网元名称不包含';
comment on column T_ALM_PARM_BILL.eqp_spoffice_inc
  is '局点名包含';
comment on column T_ALM_PARM_BILL.eqp_spoffice_exc
  is '局点名不包含';
comment on column T_ALM_PARM_BILL.eqp_place_inc
  is '地点信息包含';
comment on column T_ALM_PARM_BILL.eqp_place_exc
  is '地点信息不包含';
comment on column T_ALM_PARM_BILL.eqp_post_inc
  is '位置信息包含';
comment on column T_ALM_PARM_BILL.eqp_post_exc
  is '位置信息不包含';
comment on column T_ALM_PARM_BILL.port_id_inc
  is '端口编号包含';
comment on column T_ALM_PARM_BILL.port_id_exc
  is '端口编号不包含';
comment on column T_ALM_PARM_BILL.port_name_inc
  is '端口名包含';
comment on column T_ALM_PARM_BILL.port_name_exc
  is '端口名不包含';
comment on column T_ALM_PARM_BILL.alm_rspr_inc
  is '负责人包含';
comment on column T_ALM_PARM_BILL.alm_rspr_exc
  is '负责人不包含';
comment on column T_ALM_PARM_BILL.contexta_inc
  is '扩充A包含';
comment on column T_ALM_PARM_BILL.contexta_exc
  is '扩充A不包含';
comment on column T_ALM_PARM_BILL.contextb_inc
  is '扩充B包含';
comment on column T_ALM_PARM_BILL.contextb_exc
  is '扩充B不包含';
comment on column T_ALM_PARM_BILL.contextc_inc
  is '扩充C包含';
comment on column T_ALM_PARM_BILL.contextc_exc
  is '扩充C不包含';
comment on column T_ALM_PARM_BILL.contextd_inc
  is '扩充D包含';
comment on column T_ALM_PARM_BILL.contextd_exc
  is '扩充D不包含';
comment on column T_ALM_PARM_BILL.contexte_inc
  is '扩充E包含';
comment on column T_ALM_PARM_BILL.contexte_exc
  is '扩充E不包含';
comment on column T_ALM_PARM_BILL.contextf_inc
  is '扩充F包含';
comment on column T_ALM_PARM_BILL.contextf_exc
  is '扩充F不包含';
comment on column T_ALM_PARM_BILL.details_inc
  is '详细内容包含';
comment on column T_ALM_PARM_BILL.details_exc
  is '详细内容不包含';
comment on column T_ALM_PARM_BILL.details_ucase_inc
  is '详细内容大写包含';
comment on column T_ALM_PARM_BILL.details_ucase_exc
  is '详细内容大写不包含';
comment on column T_ALM_PARM_BILL.mediation_time_week_inc
  is '告警星期值包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6';
comment on column T_ALM_PARM_BILL.mediation_time_week_exc
  is '告警星期值不包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6';
comment on column T_ALM_PARM_BILL.mediation_time_hour_inc
  is '告警小时值包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6;7-7;8-8;9-9;10-10;11-11;12-12;13-13;14-14;15-15;16-16;17-17;18-18;19-19;20-20;21-21;22-22;23-23';
comment on column T_ALM_PARM_BILL.mediation_time_hour_exc
  is '告警小时值不包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6;7-7;8-8;9-9;10-10;11-11;12-12;13-13;14-14;15-15;16-16;17-17;18-18;19-19;20-20;21-21;22-22;23-23';
comment on column T_ALM_PARM_BILL.user_updated
  is '修改人';
comment on column T_ALM_PARM_BILL.audit_stat
  is '审核状态:0-初始;1-二级审核;2-三级审核;3-生效';
comment on column T_ALM_PARM_BILL.date_created
  is '新增时间';
comment on column T_ALM_PARM_BILL.last_updated
  is '修改时间';
comment on column T_ALM_PARM_BILL.pbil_code
  is '派单代码';
comment on column T_ALM_PARM_BILL.pbil_name
  is '派单名';
comment on column T_ALM_PARM_BILL.pbil_sw_stat
  is '开关状态:1-开;0-关';
comment on column T_ALM_PARM_BILL.pbil_level
  is '匹配层次:0-首次匹配;1-二次匹配;2-三次匹配;3-四次匹配';
comment on column T_ALM_PARM_BILL.pbil_is_revokable
  is '预处理取消:0-否;1-是';
comment on column T_ALM_PARM_BILL.pbil_is_ignore_cleared
  is '忽略恢复:0-否;1-是';
comment on column T_ALM_PARM_BILL.pbil_is_merge
  is '是否归并:1-是;0-否';
comment on column T_ALM_PARM_BILL.pbil_is_rebill
  is '次日补派:0-否;1-是';
comment on column T_ALM_PARM_BILL.pbil_rebil_len
  is '补派范围(小时)';
comment on column T_ALM_PARM_BILL.pbil_delay_len
  is '延时时长(秒)';
comment on column T_ALM_PARM_BILL.pbil_eqp_rep_len
  is '设备重复派单时长(秒)';
comment on column T_ALM_PARM_BILL.pbil_limit_type
  is '数量门限类型:0-归并数;1-累计数';
comment on column T_ALM_PARM_BILL.pbil_limit_count
  is '告警数门限';
comment on column T_ALM_PARM_BILL.main_specialid
  is '主专业类型';
comment on column T_ALM_PARM_BILL.specialid
  is '专业类型';
comment on column T_ALM_PARM_BILL.faulttypeid
  is '故障类型';
comment on column T_ALM_PARM_BILL.bill_priority
  is '故障单等级';
comment on column T_ALM_PARM_BILL.alarm_content
  is '预警对象名称';
comment on column T_ALM_PARM_BILL.alarm_obj_name
  is '预警详细内容';
comment on column T_ALM_PARM_BILL.alarm_index_name
  is '预警指标名称';
comment on column T_ALM_PARM_BILL.alarm_city
  is '预警生成城市';
comment on column T_ALM_PARM_BILL.bill_area_id
  is '区域ID';
comment on column T_ALM_PARM_BILL.is_auto
  is '自动派单到人:0-否;1-是';
comment on column T_ALM_PARM_BILL.net_name
  is '网元名称';
comment on column T_ALM_PARM_BILL.trader_info
  is '运营商信息';
comment on column T_ALM_PARM_BILL.fault_actual
  is '障碍现象';
comment on column T_ALM_PARM_BILL.fault_info
  is '障碍信息';
comment on column T_ALM_PARM_BILL.title
  is '障碍标题';
comment on column T_ALM_PARM_BILL.fault_src_id
  is '障碍来源';
comment on column T_ALM_PARM_BILL.alarm_type
  is '告警类型';
comment on column T_ALM_PARM_BILL.spoffice
  is '专业局向';
comment on column T_ALM_PARM_BILL.pbil_desc
  is '派单描述';
comment on column T_ALM_PARM_BILL.pbil_merge_label
  is '归并标签表达式';
comment on column T_ALM_PARM_BILL.pbil_rebill_hour_inc
  is '补派时间';
comment on column T_ALM_PARM_BILL.mediation_time_start
  is '派单开始时间';
comment on column T_ALM_PARM_BILL.mediation_time_end
  is '派单结束时间';
comment on column T_ALM_PARM_BILL.control_permissions
  is '管控权限:0-本地网，2-省公司';
comment on column T_ALM_PARM_BILL.pbex_id
  is '派单扩展配置编号';
comment on column T_ALM_PARM_BILL.complaint_info
  is '障碍描述';
comment on column T_ALM_PARM_BILL.bill_type
  is '工单类型：1-网络单；2-用户单';
comment on column T_ALM_PARM_BILL.bill_area_code
  is '派单本地网';
comment on column T_ALM_PARM_BILL.is_related_grid
  is '是否关联网格信息:0-否;1-是';
comment on column T_ALM_PARM_BILL.pbil_first_merge_label
  is '一级派单规则';
comment on column T_ALM_PARM_BILL.merger_cause
  is '归并描述';
comment on column T_ALM_PARM_BILL.merger_info
  is '归并信息';
comment on column T_ALM_PARM_BILL.begin_time
  is '起始时间';
comment on column T_ALM_PARM_BILL.end_time
  is '结束时间';
comment on column T_ALM_PARM_BILL.nm_name_inc
  is '网管名称包含，用与跨网管的派单策略';
comment on column T_ALM_PARM_BILL.is_cross_nm
  is '是否跨网管：0-否；1-是 ';
comment on column T_ALM_PARM_BILL.net_code
  is '网元编码，对应综调接口 netcode';
comment on column T_ALM_PARM_BILL.master_summary_inc
  is '主告警告警概要包含';
comment on column T_ALM_PARM_BILL.req_user
  is '需求提出人 request user';
comment on column T_ALM_PARM_BILL.req_detail
  is '需求详细内容 request detail';
comment on column T_ALM_PARM_BILL.req_auditer
  is '需求审核人 request auditer';
comment on column T_ALM_PARM_BILL.req_developer
  is '需求研发人 request developer';
comment on column T_ALM_PARM_BILL.req_publisher
  is '需求发布人 request publisher';
comment on column T_ALM_PARM_BILL.pub_time
  is '发布时间 publish time';
comment on column T_ALM_PARM_BILL.release_note
  is '更新内容 release note';
comment on column T_ALM_PARM_BILL.scope_app
  is '告警规则适用范围 scope application';
-- Create/Recreate indexes 
create index FK_ALM_FGBI_PBIL on T_ALM_PARM_BILL (FGBI_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index FK_ALM_NM_FNMB7 on T_ALM_PARM_BILL (NM_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index FK_ALM_USER_FICO8 on T_ALM_PARM_BILL (USER_ID)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_NM_ID_FGBI_ID_BILL on T_ALM_PARM_BILL (NM_ID, FGBI_ID, AUDIT_STAT, PBIL_SW_STAT)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_SWST_AS_PI_PB_ALM_PBILL on T_ALM_PARM_BILL (PBIL_SW_STAT, AUDIT_STAT, PBIL_IS_IGNORE_CLEARED, PBIL_EQP_REP_LEN)
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_ALM_PARM_BILL
  add constraint PK_T_ALM_PARM_BILL primary key (PBIL_ID)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_PARM_BILL
  add constraint UK_PBIL_CODE_T_ALM_PA unique (PBIL_CODE)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table T_ALM_PARM_BILL
  add constraint FKT_ALM_PARM_BILL_T_ALM_FIG foreign key (FGBI_ID)
  references T_ALM_FIGR_BILL (FGBI_ID);
alter table T_ALM_PARM_BILL
  add constraint FKT_ALM_PARM_BILL_T_ALM_NM foreign key (NM_ID)
  references T_ALM_NM (NM_ID);
alter table T_ALM_PARM_BILL
  add constraint FKT_ALM_PARM_BILL_T_SYS_USE foreign key (USER_ID)
  references T_SYS_USER (USER_ID);
