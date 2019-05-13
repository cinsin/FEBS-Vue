alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';


BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_FIRED_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_PAUSED_TRIGGER_GRPS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SCHEDULER_STATE';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_LOCKS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SIMPLE_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_SIMPROP_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CRON_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_BLOB_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_TRIGGERS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_JOB_DETAILS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE QRTZ_CALENDARS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/


CREATE TABLE QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    JOB_NAME  VARCHAR2(200) NOT NULL,
    JOB_GROUP VARCHAR2(200) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    JOB_CLASS_NAME   VARCHAR2(250) NOT NULL,
    IS_DURABLE VARCHAR2(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR2(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR2(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    JOB_NAME  VARCHAR2(200) NOT NULL,
    JOB_GROUP VARCHAR2(200) NOT NULL,
    DESCRIPTION VARCHAR2(250) NULL,
    NEXT_FIRE_TIME NUMBER(19) NULL,
    PREV_FIRE_TIME NUMBER(19) NULL,
    PRIORITY NUMBER(10) NULL,
    TRIGGER_STATE VARCHAR2(16) NOT NULL,
    TRIGGER_TYPE VARCHAR2(8) NOT NULL,
    START_TIME NUMBER(19) NOT NULL,
    END_TIME NUMBER(19) NULL,
    CALENDAR_NAME VARCHAR2(200) NULL,
    MISFIRE_INSTR NUMBER(5) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    REPEAT_COUNT NUMBER(19) NOT NULL,
    REPEAT_INTERVAL NUMBER(19) NOT NULL,
    TIMES_TRIGGERED NUMBER(19) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    CRON_EXPRESSION VARCHAR2(200) NOT NULL,
    TIME_ZONE_ID VARCHAR2(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    STR_PROP_1 VARCHAR2(512) NULL,
    STR_PROP_2 VARCHAR2(512) NULL,
    STR_PROP_3 VARCHAR2(512) NULL,
    INT_PROP_1 NUMBER(10) NULL,
    INT_PROP_2 NUMBER(10) NULL,
    LONG_PROP_1 NUMBER(19) NULL,
    LONG_PROP_2 NUMBER(19) NULL,
    DEC_PROP_1 NUMBER(13,4) NULL,
    DEC_PROP_2 NUMBER(13,4) NULL,
    BOOL_PROP_1 VARCHAR2(1) NULL,
    BOOL_PROP_2 VARCHAR2(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CALENDARS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    CALENDAR_NAME  VARCHAR2(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR2(200) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    ENTRY_ID VARCHAR2(95) NOT NULL,
    TRIGGER_NAME VARCHAR2(200) NOT NULL,
    TRIGGER_GROUP VARCHAR2(200) NOT NULL,
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    FIRED_TIME NUMBER(19) NOT NULL,
    SCHED_TIME NUMBER(19) NOT NULL,
    PRIORITY NUMBER(10) NOT NULL,
    STATE VARCHAR2(16) NOT NULL,
    JOB_NAME VARCHAR2(200) NULL,
    JOB_GROUP VARCHAR2(200) NULL,
    IS_NONCONCURRENT VARCHAR2(1) NULL,
    REQUESTS_RECOVERY VARCHAR2(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    INSTANCE_NAME VARCHAR2(200) NOT NULL,
    LAST_CHECKIN_TIME NUMBER(19) NOT NULL,
    CHECKIN_INTERVAL NUMBER(19) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS
  (
    SCHED_NAME VARCHAR2(120) NOT NULL,
    LOCK_NAME  VARCHAR2(40) NOT NULL,
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);

/* SET FOREIGN_KEY_CHECKS=0; */
-- ----------------------------
-- Table structure for t_dept
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_dept';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_dept (
  DEPT_ID number(19) NOT NULL ,
  PARENT_ID number(19) NOT NULL ,
  DEPT_NAME varchar2(100) NOT NULL ,
  ORDER_NUM binary_double DEFAULT NULL ,
  CREATE_TIME date DEFAULT NULL ,
  MODIFY_TIME date DEFAULT NULL ,
  PRIMARY KEY (DEPT_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_dept_seq START WITH 7 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_dept_seq_tr
 BEFORE INSERT ON t_dept FOR EACH ROW
 WHEN (NEW.DEPT_ID IS NULL)
BEGIN
 SELECT t_dept_seq.NEXTVAL INTO :NEW.DEPT_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_dept
-- ----------------------------
INSERT INTO t_dept VALUES ('1', '0', '开发部', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_dept VALUES ('2', '1', '开发一部', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_dept VALUES ('3', '1', '开发二部', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_dept VALUES ('4', '0', '市场部', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_dept VALUES ('5', '0', '人事部', '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_dept VALUES ('6', '0', '测试部', '4', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_dict';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_dict (
  DICT_ID number(19) NOT NULL ,
  KEYY number(19) NOT NULL ,
  VALUEE varchar2(100) NOT NULL ,
  FIELD_NAME varchar2(100) NOT NULL ,
  TABLE_NAME varchar2(100) NOT NULL ,
  PRIMARY KEY (DICT_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_dict_seq START WITH 34 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_dict_seq_tr
 BEFORE INSERT ON t_dict FOR EACH ROW
 WHEN (NEW.DICT_ID IS NULL)
BEGIN
 SELECT t_dict_seq.NEXTVAL INTO :NEW.DICT_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_dict
-- ----------------------------
INSERT INTO t_dict VALUES ('1', '0', '男', 'ssex', 't_user');
INSERT INTO t_dict VALUES ('2', '1', '女', 'ssex', 't_user');
INSERT INTO t_dict VALUES ('3', '2', '保密', 'ssex', 't_user');
INSERT INTO t_dict VALUES ('4', '1', '有效', 'status', 't_user');
INSERT INTO t_dict VALUES ('5', '0', '锁定', 'status', 't_user');
INSERT INTO t_dict VALUES ('6', '0', '菜单', 'type', 't_menu');
INSERT INTO t_dict VALUES ('7', '1', '按钮', 'type', 't_menu');
INSERT INTO t_dict VALUES ('30', '0', '正常', 'status', 't_job');
INSERT INTO t_dict VALUES ('31', '1', '暂停', 'status', 't_job');
INSERT INTO t_dict VALUES ('32', '0', '成功', 'status', 't_job_log');
INSERT INTO t_dict VALUES ('33', '1', '失败', 'status', 't_job_log');

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_job';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_job (
  JOB_ID number(19) NOT NULL ,
  BEAN_NAME varchar2(100) NOT NULL ,
  METHOD_NAME varchar2(100) NOT NULL ,
  PARAMS varchar2(200) DEFAULT NULL ,
  CRON_EXPRESSION varchar2(100) NOT NULL ,
  STATUS char(2) NOT NULL ,
  REMARK varchar2(200) DEFAULT NULL ,
  CREATE_TIME date DEFAULT NULL ,
  PRIMARY KEY (JOB_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_job_seq START WITH 12 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_job_seq_tr
 BEFORE INSERT ON t_job FOR EACH ROW
 WHEN (NEW.JOB_ID IS NULL)
BEGIN
 SELECT t_job_seq.NEXTVAL INTO :NEW.JOB_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO t_job VALUES ('1', 'testTask', 'test', 'mrbird', '0 15 9 10 * ?', '1', '有参任务调度测试', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job VALUES ('2', 'testTask', 'test1', null, '0 15 9 10 * ?', '1', '无参任务调度测试', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job VALUES ('3', 'testTask', 'test', 'hello world', '0 15 9 10 * ?', '1', '有参任务调度测试,每隔一秒触发', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job VALUES ('11', 'testTask', 'test2', null, '0 15 9 10 * ?', '1', '测试异常', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_job_log';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_job_log (
  LOG_ID number(19) NOT NULL ,
  JOB_ID number(19) NOT NULL ,
  BEAN_NAME varchar2(100) NOT NULL ,
  METHOD_NAME varchar2(100) NOT NULL ,
  PARAMS varchar2(200) DEFAULT NULL ,
  STATUS char(2) NOT NULL ,
  ERROR clob ,
  TIMES number(11,0) DEFAULT NULL ,
  CREATE_TIME date DEFAULT NULL ,
  PRIMARY KEY (LOG_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_job_log_seq START WITH 2502 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_job_log_seq_tr
 BEFORE INSERT ON t_job_log FOR EACH ROW
 WHEN (NEW.LOG_ID IS NULL)
BEGIN
 SELECT t_job_log_seq.NEXTVAL INTO :NEW.LOG_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_job_log
-- ----------------------------
INSERT INTO t_job_log VALUES ('2450', '3', 'testTask', 'test', 'hello world', '0', null, '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2451', '3', 'testTask', 'test', 'hello world', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2452', '3', 'testTask', 'test', 'hello world', '0', null, '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2453', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2454', '3', 'testTask', 'test', 'hello world', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2455', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2456', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2457', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2458', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2459', '3', 'testTask', 'test', 'hello world', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2460', '3', 'testTask', 'test', 'hello world', '0', null, '5', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2461', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2462', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2463', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2464', '3', 'testTask', 'test', 'hello world', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2465', '11', 'testTask', 'test2', null, '1', 'java.lang.NoSuchMethodException: cc.mrbird.job.task.TestTask.test2()', '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2466', '2', 'testTask', 'test1', null, '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2467', '2', 'testTask', 'test1', null, '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2468', '2', 'testTask', 'test1', null, '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2469', '2', 'testTask', 'test1', null, '0', null, '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2476', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2477', '11', 'testTask', 'test2', null, '1', 'java.lang.NoSuchMethodException: cc.mrbird.febs.job.task.TestTask.test2()', '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2478', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2479', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2480', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2481', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2482', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2483', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2484', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2485', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2486', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2487', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2488', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2489', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2490', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2491', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2492', '1', 'testTask', 'test', 'mrbird', '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2493', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2494', '1', 'testTask', 'test', 'mrbird', '0', null, '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2495', '11', 'testTask', 'test2', null, '1', 'java.lang.NoSuchMethodException: cc.mrbird.febs.job.task.TestTask.test2()', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2496', '11', 'testTask', 'test2', null, '1', 'java.lang.NoSuchMethodException: cc.mrbird.febs.job.task.TestTask.test2()', '0', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2497', '11', 'testTask', 'test2', null, '1', 'java.lang.NoSuchMethodException: cc.mrbird.febs.job.task.TestTask.test2()', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2498', '2', 'testTask', 'test1', null, '0', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2499', '1', 'testTask', 'test', 'mrbird', '0', null, '30', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2500', '1', 'testTask', 'test', 'mrbird', '0', null, '9', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_job_log VALUES ('2501', '1', 'testTask', 'test', 'mrbird', '0', null, '12', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_log';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_log (
  ID number(19) NOT NULL ,
  USERNAME varchar2(50) DEFAULT NULL ,
  OPERATION clob ,
  TIME number(11,0) DEFAULT NULL ,
  METHOD clob ,
  PARAMS clob ,
  IP varchar2(64) DEFAULT NULL ,
  CREATE_TIME date DEFAULT NULL ,
  location varchar2(50) DEFAULT NULL ,
  PRIMARY KEY (ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_log_seq START WITH 1839 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_log_seq_tr
 BEFORE INSERT ON t_log FOR EACH ROW
 WHEN (NEW.ID IS NULL)
BEGIN
 SELECT t_log_seq.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_log
-- ----------------------------
INSERT INTO t_log VALUES ('1815', 'mrbird', '删除用户', '301', 'cc.mrbird.febs.system.controller.UserController.deleteUsers()', ' userIds: "11"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1816', 'mrbird', '修改菜单/按钮', '170', 'cc.mrbird.febs.system.controller.MenuController.updateMenu()', ' menu: "Menu(menuId=2, parentId=0, menuName=系统监控, path=/monitor, component=PageView, perms=null, icon=dashboard, type=0, orderNum=2.0, createTime=null, modifyTime=Wed Jan 23 14:27:12 CST 2019, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1817', 'mrbird', '修改部门', '90', 'cc.mrbird.febs.system.controller.DeptController.updateDept()', ' dept: "Dept(deptId=4, parentId=0, deptName=市场部, orderNum=2.0, createTime=null, modifyTime=Wed Jan 23 14:27:55 CST 2019, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1818', 'mrbird', '修改部门', '596', 'cc.mrbird.febs.system.controller.DeptController.updateDept()', ' dept: "Dept(deptId=5, parentId=0, deptName=人事部, orderNum=3.0, createTime=null, modifyTime=Wed Jan 23 14:27:59 CST 2019, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1819', 'mrbird', '执行定时任务', '146', 'cc.mrbird.febs.job.controller.JobController.runJob()', ' jobId: "1"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1820', 'mrbird', '新增菜单/按钮', '160', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=130, parentId=3, menuName=导出Excel, path=null, component=null, perms=user:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:35:15 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1821', 'mrbird', '新增菜单/按钮', '255', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=131, parentId=4, menuName=导出Excel, path=null, component=null, perms=role:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:35:36 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1822', 'mrbird', '新增菜单/按钮', '172', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=132, parentId=5, menuName=导出Excel, path=null, component=null, perms=menu:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:04 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1823', 'mrbird', '新增菜单/按钮', '188', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=133, parentId=6, menuName=导出Excel, path=null, component=null, perms=dept:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:24 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1824', 'mrbird', '新增菜单/按钮', '186', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=134, parentId=64, menuName=导出Excel, path=null, component=null, perms=dict:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:43 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1825', 'mrbird', '新增菜单/按钮', '160', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=135, parentId=3, menuName=密码重置, path=null, component=null, perms=user:reset, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:36:59 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1826', 'mrbird', '新增菜单/按钮', '181', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=136, parentId=10, menuName=导出Excel, path=null, component=null, perms=log:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:37:26 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1827', 'mrbird', '新增菜单/按钮', '146', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=137, parentId=102, menuName=导出Excel, path=null, component=null, perms=job:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:37:59 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1828', 'mrbird', '新增菜单/按钮', '164', 'cc.mrbird.febs.system.controller.MenuController.addMenu()', ' menu: "Menu(menuId=138, parentId=109, menuName=导出Excel, path=null, component=null, perms=jobLog:export, icon=null, type=1, orderNum=null, createTime=Wed Jan 23 14:38:32 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1829', 'mrbird', '修改角色', '3132', 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: "Role(roleId=1, roleName=管理员, remark=管理员, createTime=null, modifyTime=Wed Jan 23 14:45:28 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=1,3,11,12,13,4,14,15,16,5,17,18,19,6,20,21,22,64,65,66,67,2,8,23,10,24,113,121,122,124,123,125,101,102,103,104,105,106,107,108,109,110,58,59,61,81,82,83,127,128,129,130,135,131,132,133,134,136,137,138)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1830', 'mrbird', '修改角色', '1730', 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: "Role(roleId=2, roleName=注册用户, remark=只可查看不可操作, createTime=null, modifyTime=Wed Jan 23 15:31:07 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1831', 'mrbird', '修改角色', '1997', 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: "Role(roleId=2, roleName=注册用户, remark=可查看，新增，导出, createTime=null, modifyTime=Wed Jan 23 15:32:20 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129,130,14,17,132,20,133,65,134,136,103,137,138)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1832', 'mrbird', '新增角色', '1428', 'cc.mrbird.febs.system.controller.RoleController.addRole()', ' role: "Role(roleId=72, roleName=普通用户, remark=只可查看，好可怜哦, createTime=Wed Jan 23 15:33:20 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null, menuId=1,3,4,5,6,64,2,8,10,113,121,122,124,123,127,101,102,109,58,59,61,81,82,83,128,129)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1833', 'mrbird', '新增用户', '338', 'cc.mrbird.febs.system.controller.UserController.addUser()', ' user: "User(userId=12, username=jack, password=552649f10640385d0728a80a4242893e, deptId=6, deptName=null, email=jack@hotmail.com, mobile=null, status=1, createTime=Wed Jan 23 15:34:05 CST 2019, modifyTime=null, lastLoginTime=null, ssex=0, description=null, avatar=default.jpg, roleId=72, roleName=null, sortField=null, sortOrder=null, createTimeFrom=null, createTimeTo=null, id=null)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1834', 'mrbird', '修改角色', '2160', 'cc.mrbird.febs.system.controller.RoleController.updateRole()', ' role: "Role(roleId=2, roleName=注册用户, remark=可查看，新增，导出, createTime=null, modifyTime=Wed Jan 23 15:37:08 CST 2019, createTimeFrom=null, createTimeTo=null, menuId=3,1,4,5,6,64,2,8,10,113,121,122,124,123,125,101,102,109,58,59,61,81,82,83,127,128,129,130,14,17,132,20,133,65,134,136,103,137,138,131)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1835', 'mrbird', '新增角色', '169', 'cc.mrbird.febs.system.controller.RoleController.addRole()', ' role: "Role(roleId=73, roleName=测试xss, remark=<style>body{background:red !important}</style>, createTime=Wed Jan 23 15:47:04 CST 2019, modifyTime=null, createTimeFrom=null, createTimeTo=null, menuId=1,3)"', '127.0.0.1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP');
INSERT INTO t_log VALUES ('1836', 'mrbird', '删除角色', '54', 'cc.mrbird.febs.system.controller.RoleController.deleteRoles()', ' roleIds: "73"', '218.104.237.213', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通');
INSERT INTO t_log VALUES ('1837', 'mrbird', '修改用户', '39', 'cc.mrbird.febs.system.controller.UserController.updateUser()', ' user: "User(userId=12, username=jack, password=null, deptId=6, deptName=null, email=jack@hotmail.com, mobile=null, status=1, createTime=null, modifyTime=Thu Jan 24 11:08:00 CST 2019, lastLoginTime=null, ssex=0, description=null, avatar=null, roleId=72, roleName=null, sortField=null, sortOrder=null, createTimeFrom=null, createTimeTo=null, id=null)"', '218.104.237.213', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通');
INSERT INTO t_log VALUES ('1838', 'mrbird', '执行定时任务', '41', 'cc.mrbird.febs.job.controller.JobController.runJob()', ' jobId: "1"', '218.104.237.213', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通');

-- ----------------------------
-- Table structure for t_login_log
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_login_log';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_login_log (
  USERNAME varchar2(100) NOT NULL ,
  LOGIN_TIME date NOT NULL ,
  LOCATION varchar2(255) DEFAULT NULL ,
  IP varchar2(100) DEFAULT NULL 
)  ;

-- ----------------------------
-- Records of t_login_log
-- ----------------------------
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbirdd', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('jack', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('abcd', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('abcd', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('abcd', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('abcd', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('wuyouzhugu', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('hello', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('hello', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('hello', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('jack', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '内网IP|0|0|内网IP|内网IP', '127.0.0.1');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|厦门市|电信', '120.36.172.239');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('jack', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|电信', '27.155.195.27');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|电信', '27.155.195.27');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('mrbird', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');
INSERT INTO t_login_log VALUES ('scott', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '中国|华东|福建省|福州市|联通', '218.104.237.213');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_menu';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_menu (
  MENU_ID number(19) NOT NULL ,
  PARENT_ID number(19) NOT NULL ,
  MENU_NAME varchar2(50) NOT NULL ,
  PATH varchar2(255) DEFAULT NULL ,
  COMPONENT varchar2(255) DEFAULT NULL ,
  PERMS varchar2(50) DEFAULT NULL ,
  ICON varchar2(50) DEFAULT NULL ,
  TYPE char(1) NOT NULL ,
  ORDER_NUM binary_double DEFAULT NULL ,
  CREATE_TIME date NOT NULL ,
  MODIFY_TIME date DEFAULT NULL ,
  PRIMARY KEY (MENU_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_menu_seq START WITH 139 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_menu_seq_tr
 BEFORE INSERT ON t_menu FOR EACH ROW
 WHEN (NEW.MENU_ID IS NULL)
BEGIN
 SELECT t_menu_seq.NEXTVAL INTO :NEW.MENU_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO t_menu VALUES ('1', '0', '系统管理', '/system', 'PageView', null, 'appstore-o', '0', '1', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('2', '0', '系统监控', '/monitor', 'PageView', null, 'dashboard', '0', '2', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('3', '1', '用户管理', '/system/user', 'system/user/User', 'user:view', '', '0', '1', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('4', '1', '角色管理', '/system/role', 'system/role/Role', 'role:view', '', '0', '2', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('5', '1', '菜单管理', '/system/menu', 'system/menu/Menu', 'menu:view', '', '0', '3', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('6', '1', '部门管理', '/system/dept', 'system/dept/Dept', 'dept:view', '', '0', '4', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('8', '2', '在线用户', '/monitor/online', 'monitor/Online', 'user:online', '', '0', '1', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('10', '2', '系统日志', '/monitor/systemlog', 'monitor/SystemLog', 'log:view', '', '0', '2', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('11', '3', '新增用户', '', '', 'user:add', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('12', '3', '修改用户', '', '', 'user:update', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('13', '3', '删除用户', '', '', 'user:delete', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('14', '4', '新增角色', '', '', 'role:add', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('15', '4', '修改角色', '', '', 'role:update', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('16', '4', '删除角色', '', '', 'role:delete', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('17', '5', '新增菜单', '', '', 'menu:add', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('18', '5', '修改菜单', '', '', 'menu:update', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('19', '5', '删除菜单', '', '', 'menu:delete', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('20', '6', '新增部门', '', '', 'dept:add', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('21', '6', '修改部门', '', '', 'dept:update', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('22', '6', '删除部门', '', '', 'dept:delete', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('23', '8', '踢出用户', '', '', 'user:kickout', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('24', '10', '删除日志', '', '', 'log:delete', null, '1', null, to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('58', '0', '网络资源', '/web', 'PageView', null, 'compass', '0', '4', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('59', '58', '天气查询', '/web/weather', 'web/Weather', 'weather:view', '', '0', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('61', '58', '每日一文', '/web/dailyArticle', 'web/DailyArticle', 'article:view', '', '0', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('64', '1', '字典管理', '/system/dict', 'system/dict/Dict', 'dict:view', '', '0', '5', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('65', '64', '新增字典', '', '', 'dict:add', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('66', '64', '修改字典', '', '', 'dict:update', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('67', '64', '删除字典', '', '', 'dict:delete', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('81', '58', '影视资讯', '/web/movie', 'EmptyPageView', null, null, '0', '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('82', '81', '正在热映', '/web/movie/hot', 'web/MovieHot', 'movie:hot', '', '0', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('83', '81', '即将上映', '/web/movie/coming', 'web/MovieComing', 'movie:coming', '', '0', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('101', '0', '任务调度', '/job', 'PageView', null, 'clock-circle-o', '0', '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('102', '101', '定时任务', '/job/job', 'quartz/job/Job', 'job:view', '', '0', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('103', '102', '新增任务', '', '', 'job:add', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('104', '102', '修改任务', '', '', 'job:update', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('105', '102', '删除任务', '', '', 'job:delete', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('106', '102', '暂停任务', '', '', 'job:pause', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('107', '102', '恢复任务', '', '', 'job:resume', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('108', '102', '立即执行任务', '', '', 'job:run', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('109', '101', '调度日志', '/job/log', 'quartz/log/JobLog', 'jobLog:view', '', '0', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('110', '109', '删除日志', '', '', 'jobLog:delete', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('113', '2', 'Redis监控', '/monitor/redis/info', 'monitor/RedisInfo', 'redis:view', '', '0', '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('121', '2', '请求追踪', '/monitor/httptrace', 'monitor/Httptrace', null, null, '0', '4', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('122', '2', '系统信息', '/monitor/system', 'EmptyPageView', null, null, '0', '5', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('123', '122', 'Tomcat信息', '/monitor/system/tomcatinfo', 'monitor/TomcatInfo', null, null, '0', '2', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('124', '122', 'JVM信息', '/monitor/system/jvminfo', 'monitor/JvmInfo', null, null, '0', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('127', '122', '服务器信息', '/monitor/system/info', 'monitor/SystemInfo', null, null, '0', '3', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('128', '0', '其他模块', '/others', 'PageView', null, 'coffee', '0', '5', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('129', '128', '导入导出', '/others/excel', 'others/Excel', null, null, '0', '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_menu VALUES ('130', '3', '导出Excel', null, null, 'user:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('131', '4', '导出Excel', null, null, 'role:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('132', '5', '导出Excel', null, null, 'menu:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('133', '6', '导出Excel', null, null, 'dept:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('134', '64', '导出Excel', null, null, 'dict:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('135', '3', '密码重置', null, null, 'user:reset', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('136', '10', '导出Excel', null, null, 'log:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('137', '102', '导出Excel', null, null, 'job:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);
INSERT INTO t_menu VALUES ('138', '109', '导出Excel', null, null, 'jobLog:export', null, '1', null, to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_role';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_role (
  ROLE_ID number(19) NOT NULL ,
  ROLE_NAME varchar2(10) NOT NULL ,
  REMARK varchar2(100) DEFAULT NULL ,
  CREATE_TIME date NOT NULL ,
  MODIFY_TIME date DEFAULT NULL ,
  PRIMARY KEY (ROLE_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_role_seq START WITH 74 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_role_seq_tr
 BEFORE INSERT ON t_role FOR EACH ROW
 WHEN (NEW.ROLE_ID IS NULL)
BEGIN
 SELECT t_role_seq.NEXTVAL INTO :NEW.ROLE_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO t_role VALUES ('1', '管理员', '管理员', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_role VALUES ('2', '注册用户', '可查看，新增，导出', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_role VALUES ('72', '普通用户', '只可查看，好可怜哦', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), null);

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_role_menu';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_role_menu (
  ROLE_ID number(19) NOT NULL,
  MENU_ID number(19) NOT NULL
)  ;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO t_role_menu VALUES ('1', '1');
INSERT INTO t_role_menu VALUES ('1', '3');
INSERT INTO t_role_menu VALUES ('1', '11');
INSERT INTO t_role_menu VALUES ('1', '12');
INSERT INTO t_role_menu VALUES ('1', '13');
INSERT INTO t_role_menu VALUES ('1', '4');
INSERT INTO t_role_menu VALUES ('1', '14');
INSERT INTO t_role_menu VALUES ('1', '15');
INSERT INTO t_role_menu VALUES ('1', '16');
INSERT INTO t_role_menu VALUES ('1', '5');
INSERT INTO t_role_menu VALUES ('1', '17');
INSERT INTO t_role_menu VALUES ('1', '18');
INSERT INTO t_role_menu VALUES ('1', '19');
INSERT INTO t_role_menu VALUES ('1', '6');
INSERT INTO t_role_menu VALUES ('1', '20');
INSERT INTO t_role_menu VALUES ('1', '21');
INSERT INTO t_role_menu VALUES ('1', '22');
INSERT INTO t_role_menu VALUES ('1', '64');
INSERT INTO t_role_menu VALUES ('1', '65');
INSERT INTO t_role_menu VALUES ('1', '66');
INSERT INTO t_role_menu VALUES ('1', '67');
INSERT INTO t_role_menu VALUES ('1', '2');
INSERT INTO t_role_menu VALUES ('1', '8');
INSERT INTO t_role_menu VALUES ('1', '23');
INSERT INTO t_role_menu VALUES ('1', '10');
INSERT INTO t_role_menu VALUES ('1', '24');
INSERT INTO t_role_menu VALUES ('1', '113');
INSERT INTO t_role_menu VALUES ('1', '121');
INSERT INTO t_role_menu VALUES ('1', '122');
INSERT INTO t_role_menu VALUES ('1', '124');
INSERT INTO t_role_menu VALUES ('1', '123');
INSERT INTO t_role_menu VALUES ('1', '125');
INSERT INTO t_role_menu VALUES ('1', '101');
INSERT INTO t_role_menu VALUES ('1', '102');
INSERT INTO t_role_menu VALUES ('1', '103');
INSERT INTO t_role_menu VALUES ('1', '104');
INSERT INTO t_role_menu VALUES ('1', '105');
INSERT INTO t_role_menu VALUES ('1', '106');
INSERT INTO t_role_menu VALUES ('1', '107');
INSERT INTO t_role_menu VALUES ('1', '108');
INSERT INTO t_role_menu VALUES ('1', '109');
INSERT INTO t_role_menu VALUES ('1', '110');
INSERT INTO t_role_menu VALUES ('1', '58');
INSERT INTO t_role_menu VALUES ('1', '59');
INSERT INTO t_role_menu VALUES ('1', '61');
INSERT INTO t_role_menu VALUES ('1', '81');
INSERT INTO t_role_menu VALUES ('1', '82');
INSERT INTO t_role_menu VALUES ('1', '83');
INSERT INTO t_role_menu VALUES ('1', '127');
INSERT INTO t_role_menu VALUES ('1', '128');
INSERT INTO t_role_menu VALUES ('1', '129');
INSERT INTO t_role_menu VALUES ('1', '130');
INSERT INTO t_role_menu VALUES ('1', '135');
INSERT INTO t_role_menu VALUES ('1', '131');
INSERT INTO t_role_menu VALUES ('1', '132');
INSERT INTO t_role_menu VALUES ('1', '133');
INSERT INTO t_role_menu VALUES ('1', '134');
INSERT INTO t_role_menu VALUES ('1', '136');
INSERT INTO t_role_menu VALUES ('1', '137');
INSERT INTO t_role_menu VALUES ('1', '138');
INSERT INTO t_role_menu VALUES ('72', '1');
INSERT INTO t_role_menu VALUES ('72', '3');
INSERT INTO t_role_menu VALUES ('72', '4');
INSERT INTO t_role_menu VALUES ('72', '5');
INSERT INTO t_role_menu VALUES ('72', '6');
INSERT INTO t_role_menu VALUES ('72', '64');
INSERT INTO t_role_menu VALUES ('72', '2');
INSERT INTO t_role_menu VALUES ('72', '8');
INSERT INTO t_role_menu VALUES ('72', '10');
INSERT INTO t_role_menu VALUES ('72', '113');
INSERT INTO t_role_menu VALUES ('72', '121');
INSERT INTO t_role_menu VALUES ('72', '122');
INSERT INTO t_role_menu VALUES ('72', '124');
INSERT INTO t_role_menu VALUES ('72', '123');
INSERT INTO t_role_menu VALUES ('72', '127');
INSERT INTO t_role_menu VALUES ('72', '101');
INSERT INTO t_role_menu VALUES ('72', '102');
INSERT INTO t_role_menu VALUES ('72', '109');
INSERT INTO t_role_menu VALUES ('72', '58');
INSERT INTO t_role_menu VALUES ('72', '59');
INSERT INTO t_role_menu VALUES ('72', '61');
INSERT INTO t_role_menu VALUES ('72', '81');
INSERT INTO t_role_menu VALUES ('72', '82');
INSERT INTO t_role_menu VALUES ('72', '83');
INSERT INTO t_role_menu VALUES ('72', '128');
INSERT INTO t_role_menu VALUES ('72', '129');
INSERT INTO t_role_menu VALUES ('2', '3');
INSERT INTO t_role_menu VALUES ('2', '1');
INSERT INTO t_role_menu VALUES ('2', '4');
INSERT INTO t_role_menu VALUES ('2', '5');
INSERT INTO t_role_menu VALUES ('2', '6');
INSERT INTO t_role_menu VALUES ('2', '64');
INSERT INTO t_role_menu VALUES ('2', '2');
INSERT INTO t_role_menu VALUES ('2', '8');
INSERT INTO t_role_menu VALUES ('2', '10');
INSERT INTO t_role_menu VALUES ('2', '113');
INSERT INTO t_role_menu VALUES ('2', '121');
INSERT INTO t_role_menu VALUES ('2', '122');
INSERT INTO t_role_menu VALUES ('2', '124');
INSERT INTO t_role_menu VALUES ('2', '123');
INSERT INTO t_role_menu VALUES ('2', '125');
INSERT INTO t_role_menu VALUES ('2', '101');
INSERT INTO t_role_menu VALUES ('2', '102');
INSERT INTO t_role_menu VALUES ('2', '109');
INSERT INTO t_role_menu VALUES ('2', '58');
INSERT INTO t_role_menu VALUES ('2', '59');
INSERT INTO t_role_menu VALUES ('2', '61');
INSERT INTO t_role_menu VALUES ('2', '81');
INSERT INTO t_role_menu VALUES ('2', '82');
INSERT INTO t_role_menu VALUES ('2', '83');
INSERT INTO t_role_menu VALUES ('2', '127');
INSERT INTO t_role_menu VALUES ('2', '128');
INSERT INTO t_role_menu VALUES ('2', '129');
INSERT INTO t_role_menu VALUES ('2', '130');
INSERT INTO t_role_menu VALUES ('2', '14');
INSERT INTO t_role_menu VALUES ('2', '17');
INSERT INTO t_role_menu VALUES ('2', '132');
INSERT INTO t_role_menu VALUES ('2', '20');
INSERT INTO t_role_menu VALUES ('2', '133');
INSERT INTO t_role_menu VALUES ('2', '65');
INSERT INTO t_role_menu VALUES ('2', '134');
INSERT INTO t_role_menu VALUES ('2', '136');
INSERT INTO t_role_menu VALUES ('2', '103');
INSERT INTO t_role_menu VALUES ('2', '137');
INSERT INTO t_role_menu VALUES ('2', '138');
INSERT INTO t_role_menu VALUES ('2', '131');

-- ----------------------------
-- Table structure for t_test
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_test';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_test (
  FIELD1 varchar2(20) NOT NULL,
  FIELD2 number(10) NOT NULL,
  FIELD3 varchar2(100) NOT NULL,
  CREATE_TIME date NOT NULL
) ;

-- ----------------------------
-- Records of t_test
-- ----------------------------
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '10', 'mrbird9@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '10', 'mrbird9@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '6', 'mrbird5@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '10', 'mrbird9@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '6', 'mrbird5@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '6', 'mrbird5@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '1', 'mrbird0@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '2', 'mrbird1@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '3', 'mrbird2@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '4', 'mrbird3@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '5', 'mrbird4@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '6', 'mrbird5@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '7', 'mrbird6@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '8', 'mrbird7@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '9', 'mrbird8@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '11', 'mrbird10@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '12', 'mrbird11@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '14', 'mrbird13@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '15', 'mrbird14@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '16', 'mrbird15@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '18', 'mrbird17@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '19', 'mrbird18@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO t_test VALUES ('字段1', '20', 'mrbird19@gmail.com', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'));

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_user';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_user (
  USER_ID number(19) NOT NULL ,
  USERNAME varchar2(50) NOT NULL ,
  PASSWORD varchar2(128) NOT NULL ,
  DEPT_ID number(19) DEFAULT NULL ,
  EMAIL varchar2(128) DEFAULT NULL ,
  MOBILE varchar2(20) DEFAULT NULL ,
  STATUS char(1) NOT NULL ,
  CREATE_TIME date NOT NULL ,
  MODIFY_TIME date DEFAULT NULL ,
  LAST_LOGIN_TIME date DEFAULT NULL ,
  SSEX char(1) DEFAULT NULL ,
  DESCRIPTION varchar2(100) DEFAULT NULL ,
  AVATAR varchar2(100) DEFAULT NULL ,
  PRIMARY KEY (USER_ID)
)   ;

-- Generate ID using sequence and trigger
CREATE SEQUENCE t_user_seq START WITH 13 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER t_user_seq_tr
 BEFORE INSERT ON t_user FOR EACH ROW
 WHEN (NEW.USER_ID IS NULL)
BEGIN
 SELECT t_user_seq.NEXTVAL INTO :NEW.USER_ID FROM DUAL;
END;
/

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO t_user VALUES ('1', 'mrbird', '94f860c4bbfeb2f49c84e321fdda4b07', '1', 'mrbird123@hotmail.com', '13455533233', '1', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '2', '我是帅比作者。', 'ubnKSIfAJTxIgXOKlciN.png');
INSERT INTO t_user VALUES ('2', 'scott', '7b44a5363e3fd52435beb472e1d2b91f', '6', 'scott@qq.com', '15134627380', '1', to_date('2017-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '0', '我是scott，嗯嗯', 'jZUIxmJycoymBprLOUbT.png');
INSERT INTO t_user VALUES ('12', 'jack', '552649f10640385d0728a80a4242893e', '6', 'jack@hotmail.com', null, '1', to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), to_date('2018-11-11 12:11:11','yyyy-mm-dd hh24:mi:ss'), '0', null, 'default.jpg');

-- ----------------------------
-- Table structure for t_user_config
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_user_config';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_user_config (
  USER_ID number(19) NOT NULL ,
  THEME varchar2(10) DEFAULT NULL ,
  LAYOUT varchar2(10) DEFAULT NULL ,
  MULTI_PAGE char(1) DEFAULT NULL ,
  FIX_SIDERBAR char(1) DEFAULT NULL ,
  FIX_HEADER char(1) DEFAULT NULL ,
  COLOR varchar2(20) DEFAULT NULL ,
  PRIMARY KEY (USER_ID)
)  ;

-- ----------------------------
-- Records of t_user_config
-- ----------------------------
INSERT INTO t_user_config VALUES ('1', 'light', 'side', '1', '1', '1', 'rgb(24, 144, 255)');
INSERT INTO t_user_config VALUES ('2', 'light', 'head', '0', '1', '1', 'rgb(24, 144, 255)');
INSERT INTO t_user_config VALUES ('12', 'dark', 'side', '1', '1', '1', 'rgb(66, 185, 131)');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE t_user_role';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/
CREATE TABLE t_user_role (
  USER_ID number(19) NOT NULL ,
  ROLE_ID number(19) NOT NULL 
)  ;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO t_user_role VALUES ('1', '1');
INSERT INTO t_user_role VALUES ('2', '2');
INSERT INTO t_user_role VALUES ('12', '72');

-- ----------------------------
-- Function structure for findDeptChildren
-- ----------------------------
DROP FUNCTION IF EXISTS findDeptChildren;
CREATE OR REPLACE  FUNCTION findDeptChildren(rootId NUMBER) RETURN varchar2 IS 
BEGIN CHARSET
 END; utf8
BEGIN
  sTemp VARCHAR2(4000);
    sTempChd VARCHAR2(4000);
    sTemp := '$';
    sTempChd := CAST(rootId as CHAR);
    WHILE sTempChd is not null LOOP
    sTemp := sTemp ||',' ||sTempChd;
    SELECT GROUP_CONCAT(dept_id) INTO sTempChd FROM t_dept
    WHERE FIND_IN_SET(parent_id,sTempChd)>0;
END LOOP;
RETURN sTemp;
END
;;

-- ----------------------------
-- Function structure for findMenuChildren
-- ----------------------------
DROP FUNCTION IF EXISTS findMenuChildren;
CREATE OR REPLACE  FUNCTION findMenuChildren(rootId NUMBER) RETURN varchar2 IS 
BEGIN CHARSET
 END; utf8
BEGIN
  sTemp VARCHAR2(4000);
    sTempChd VARCHAR2(4000);
    sTemp := '$';
    sTempChd := CAST(rootId as CHAR);
    WHILE sTempChd is not null LOOP
    sTemp := sTemp ||',' ||sTempChd;
    SELECT GROUP_CONCAT(menu_id) INTO sTempChd FROM t_menu
    WHERE FIND_IN_SET(parent_id,sTempChd)>0;
END LOOP;
RETURN sTemp;
END
;;
