package cc.mrbird.febs.kps.bill.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * APBIL派单模式
 *
 * @author Cinsin
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("T_ALM_PARM_BILL")
public class AlmParmBill implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 派单编号
     */
            @TableId("PBIL_ID")
    private String pbilId;

    /**
     * 用户号
     */
        @TableField("USER_ID")
    private String userId;

    /**
     * 网管编号
     */
        @TableField("NM_ID")
    private String nmId;

    /**
     * 派单分组编号
     */
        @TableField("FGBI_ID")
    private String fgbiId;

    /**
     * 故障区域代码包含
     */
        @TableField("RELATED_AREA_CODE_INC")
    private String relatedAreaCodeInc;

    /**
     * 故障区域代码不包含
     */
        @TableField("RELATED_AREA_CODE_EXC")
    private String relatedAreaCodeExc;

    /**
     * 故障区域名包含
     */
        @TableField("FAULT_AREA_NAME_INC")
    private String faultAreaNameInc;

    /**
     * 故障区域名不包含
     */
        @TableField("FAULT_AREA_NAME_EXC")
    private String faultAreaNameExc;

    /**
     * 故障子区域代码包含
     */
        @TableField("RELATED_SUBAREA_CODE_INC")
    private String relatedSubareaCodeInc;

    /**
     * 故障子区域代码不包含
     */
        @TableField("RELATED_SUBAREA_CODE_EXC")
    private String relatedSubareaCodeExc;

    /**
     * 故障子区域名包含
     */
        @TableField("FAULT_SUBAREA_NAME_INC")
    private String faultSubareaNameInc;

    /**
     * 故障子区域名不包含
     */
        @TableField("FAULT_SUBAREA_NAME_EXC")
    private String faultSubareaNameExc;

    /**
     * 优先级包含:1-紧急;2-主要;3-次要;4-警告;9-未定
     */
        @TableField("PRIORITY_INC")
    private String priorityInc;

    /**
     * 优先级不包含:1-紧急;2-主要;3-次要;4-警告;9-未定
     */
        @TableField("PRIORITY_EXC")
    private String priorityExc;

    /**
     * 恢复标识包含:0-未恢复;1-网管恢复
     */
        @TableField("CLEARED_INC")
    private String clearedInc;

    /**
     * 恢复标识不包含:0-未恢复;1-网管恢复
     */
        @TableField("CLEARED_EXC")
    private String clearedExc;

    /**
     * 割接状态包含:0-无割接;1-正在割接
     */
        @TableField("CUT_STAT_INC")
    private String cutStatInc;

    /**
     * 割接状态不包含:0-无割接;1-正在割接
     */
        @TableField("CUT_STAT_EXC")
    private String cutStatExc;

    /**
     * 设备名称包含
     */
        @TableField("USER_LABEL_INC")
    private String userLabelInc;

    /**
     * 设备名称不包含
     */
        @TableField("USER_LABEL_EXC")
    private String userLabelExc;

    /**
     * 设备名称大写包含
     */
        @TableField("USER_LABEL_UCASE_INC")
    private String userLabelUcaseInc;

    /**
     * 设备名称大写不包含
     */
        @TableField("USER_LABEL_UCASE_EXC")
    private String userLabelUcaseExc;

    /**
     * 概要包含
     */
        @TableField("SUMMARY_INC")
    private String summaryInc;

    /**
     * 概要不包含
     */
        @TableField("SUMMARY_EXC")
    private String summaryExc;

    /**
     * 概要大写包含
     */
        @TableField("SUMMARY_UCASE_INC")
    private String summaryUcaseInc;

    /**
     * 概要大写不包含
     */
        @TableField("SUMMARY_UCASE_EXC")
    private String summaryUcaseExc;

    /**
     * 消息类型编号包含
     */
        @TableField("MSTY_ID_INC")
    private String mstyIdInc;

    /**
     * 消息类型编号不包含
     */
        @TableField("MSTY_ID_EXC")
    private String mstyIdExc;

    /**
     * 消息类型名包含
     */
        @TableField("MSTY_NAME_INC")
    private String mstyNameInc;

    /**
     * 消息类型名不包含
     */
        @TableField("MSTY_NAME_EXC")
    private String mstyNameExc;

    /**
     * 故障信息包含
     */
        @TableField("FAULT_INFO_INC")
    private String faultInfoInc;

    /**
     * 故障信息不包含
     */
        @TableField("FAULT_INFO_EXC")
    private String faultInfoExc;

    /**
     * 网元类型编号包含
     */
        @TableField("EQTY_ID_INC")
    private String eqtyIdInc;

    /**
     * 网元类型编号不包含
     */
        @TableField("EQTY_ID_EXC")
    private String eqtyIdExc;

    /**
     * 网元类型名包含
     */
        @TableField("EQTY_NAME_INC")
    private String eqtyNameInc;

    /**
     * 网元类型名不包含
     */
        @TableField("EQTY_NAME_EXC")
    private String eqtyNameExc;

    /**
     * 网元号包含
     */
        @TableField("EQP_ID_INC")
    private String eqpIdInc;

    /**
     * 网元号不包含
     */
        @TableField("EQP_ID_EXC")
    private String eqpIdExc;

    /**
     * 网元名称包含
     */
        @TableField("EQP_NAME_INC")
    private String eqpNameInc;

    /**
     * 网元名称不包含
     */
        @TableField("EQP_NAME_EXC")
    private String eqpNameExc;

    /**
     * 局点名包含
     */
        @TableField("EQP_SPOFFICE_INC")
    private String eqpSpofficeInc;

    /**
     * 局点名不包含
     */
        @TableField("EQP_SPOFFICE_EXC")
    private String eqpSpofficeExc;

    /**
     * 地点信息包含
     */
        @TableField("EQP_PLACE_INC")
    private String eqpPlaceInc;

    /**
     * 地点信息不包含
     */
        @TableField("EQP_PLACE_EXC")
    private String eqpPlaceExc;

    /**
     * 位置信息包含
     */
        @TableField("EQP_POST_INC")
    private String eqpPostInc;

    /**
     * 位置信息不包含
     */
        @TableField("EQP_POST_EXC")
    private String eqpPostExc;

    /**
     * 端口编号包含
     */
        @TableField("PORT_ID_INC")
    private String portIdInc;

    /**
     * 端口编号不包含
     */
        @TableField("PORT_ID_EXC")
    private String portIdExc;

    /**
     * 端口名包含
     */
        @TableField("PORT_NAME_INC")
    private String portNameInc;

    /**
     * 端口名不包含
     */
        @TableField("PORT_NAME_EXC")
    private String portNameExc;

    /**
     * 负责人包含
     */
        @TableField("ALM_RSPR_INC")
    private String almRsprInc;

    /**
     * 负责人不包含
     */
        @TableField("ALM_RSPR_EXC")
    private String almRsprExc;

    /**
     * 扩充A包含
     */
        @TableField("CONTEXTA_INC")
    private String contextaInc;

    /**
     * 扩充A不包含
     */
        @TableField("CONTEXTA_EXC")
    private String contextaExc;

    /**
     * 扩充B包含
     */
        @TableField("CONTEXTB_INC")
    private String contextbInc;

    /**
     * 扩充B不包含
     */
        @TableField("CONTEXTB_EXC")
    private String contextbExc;

    /**
     * 扩充C包含
     */
        @TableField("CONTEXTC_INC")
    private String contextcInc;

    /**
     * 扩充C不包含
     */
        @TableField("CONTEXTC_EXC")
    private String contextcExc;

    /**
     * 扩充D包含
     */
        @TableField("CONTEXTD_INC")
    private String contextdInc;

    /**
     * 扩充D不包含
     */
        @TableField("CONTEXTD_EXC")
    private String contextdExc;

    /**
     * 扩充E包含
     */
        @TableField("CONTEXTE_INC")
    private String contexteInc;

    /**
     * 扩充E不包含
     */
        @TableField("CONTEXTE_EXC")
    private String contexteExc;

    /**
     * 扩充F包含
     */
        @TableField("CONTEXTF_INC")
    private String contextfInc;

    /**
     * 扩充F不包含
     */
        @TableField("CONTEXTF_EXC")
    private String contextfExc;

    /**
     * 详细内容包含
     */
        @TableField("DETAILS_INC")
    private String detailsInc;

    /**
     * 详细内容不包含
     */
        @TableField("DETAILS_EXC")
    private String detailsExc;

    /**
     * 详细内容大写包含
     */
        @TableField("DETAILS_UCASE_INC")
    private String detailsUcaseInc;

    /**
     * 详细内容大写不包含
     */
        @TableField("DETAILS_UCASE_EXC")
    private String detailsUcaseExc;

    /**
     * 告警星期值包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6
     */
        @TableField("MEDIATION_TIME_WEEK_INC")
    private String mediationTimeWeekInc;

    /**
     * 告警星期值不包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6
     */
        @TableField("MEDIATION_TIME_WEEK_EXC")
    private String mediationTimeWeekExc;

    /**
     * 告警小时值包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6;7-7;8-8;9-9;10-10;11-11;12-12;13-13;14-14;15-15;16-16;17-17;18-18;19-19;20-20;21-21;22-22;23-23
     */
        @TableField("MEDIATION_TIME_HOUR_INC")
    private String mediationTimeHourInc;

    /**
     * 告警小时值不包含:0-0;1-1;2-2;3-3;4-4;5-5;6-6;7-7;8-8;9-9;10-10;11-11;12-12;13-13;14-14;15-15;16-16;17-17;18-18;19-19;20-20;21-21;22-22;23-23
     */
        @TableField("MEDIATION_TIME_HOUR_EXC")
    private String mediationTimeHourExc;

    /**
     * 修改人
     */
        @TableField("USER_UPDATED")
    private String userUpdated;

    /**
     * 审核状态:0-初始;1-二级审核;2-三级审核;3-生效
     */
        @TableField("AUDIT_STAT")
    private Integer auditStat;

    /**
     * 新增时间
     */
        @TableField("DATE_CREATED")
    private LocalDateTime dateCreated;

    /**
     * 修改时间
     */
        @TableField("LAST_UPDATED")
    private LocalDateTime lastUpdated;

    /**
     * 派单代码
     */
        @TableField("PBIL_CODE")
    private String pbilCode;

    /**
     * 派单名
     */
        @TableField("PBIL_NAME")
    private String pbilName;

    /**
     * 开关状态:1-开;0-关
     */
        @TableField("PBIL_SW_STAT")
    private Integer pbilSwStat;

    /**
     * 匹配层次:0-首次匹配;1-二次匹配;2-三次匹配;3-四次匹配
     */
        @TableField("PBIL_LEVEL")
    private Integer pbilLevel;

    /**
     * 预处理取消:0-否;1-是
     */
        @TableField("PBIL_IS_REVOKABLE")
    private Integer pbilIsRevokable;

    /**
     * 忽略恢复:0-否;1-是
     */
        @TableField("PBIL_IS_IGNORE_CLEARED")
    private Integer pbilIsIgnoreCleared;

    /**
     * 是否归并:1-是;0-否
     */
        @TableField("PBIL_IS_MERGE")
    private Integer pbilIsMerge;

    /**
     * 次日补派:0-否;1-是
     */
        @TableField("PBIL_IS_REBILL")
    private Integer pbilIsRebill;

    /**
     * 补派范围(小时)
     */
        @TableField("PBIL_REBIL_LEN")
    private Integer pbilRebilLen;

    /**
     * 延时时长(秒)
     */
        @TableField("PBIL_DELAY_LEN")
    private Integer pbilDelayLen;

    /**
     * 设备重复派单时长(秒)
     */
        @TableField("PBIL_EQP_REP_LEN")
    private Integer pbilEqpRepLen;

    /**
     * 数量门限类型:0-归并数;1-累计数
     */
        @TableField("PBIL_LIMIT_TYPE")
    private Integer pbilLimitType;

    /**
     * 告警数门限
     */
        @TableField("PBIL_LIMIT_COUNT")
    private Integer pbilLimitCount;

    /**
     * 主专业类型
     */
        @TableField("MAIN_SPECIALID")
    private String mainSpecialid;

    /**
     * 专业类型
     */
        @TableField("SPECIALID")
    private String specialid;

    /**
     * 故障类型
     */
        @TableField("FAULTTYPEID")
    private String faulttypeid;

    /**
     * 故障单等级
     */
        @TableField("BILL_PRIORITY")
    private String billPriority;

    /**
     * 预警对象名称
     */
        @TableField("ALARM_CONTENT")
    private String alarmContent;

    /**
     * 预警详细内容
     */
        @TableField("ALARM_OBJ_NAME")
    private String alarmObjName;

    /**
     * 预警指标名称
     */
        @TableField("ALARM_INDEX_NAME")
    private String alarmIndexName;

    /**
     * 预警生成城市
     */
        @TableField("ALARM_CITY")
    private String alarmCity;

    /**
     * 区域ID
     */
        @TableField("BILL_AREA_ID")
    private String billAreaId;

    /**
     * 自动派单到人:0-否;1-是
     */
        @TableField("IS_AUTO")
    private Integer isAuto;

    /**
     * 网元名称
     */
        @TableField("NET_NAME")
    private String netName;

    /**
     * 运营商信息
     */
        @TableField("TRADER_INFO")
    private String traderInfo;

    /**
     * 障碍现象
     */
        @TableField("FAULT_ACTUAL")
    private String faultActual;

    /**
     * 障碍信息
     */
        @TableField("FAULT_INFO")
    private String faultInfo;

    /**
     * 障碍标题
     */
        @TableField("TITLE")
    private String title;

    /**
     * 障碍来源
     */
        @TableField("FAULT_SRC_ID")
    private String faultSrcId;

    /**
     * 告警类型
     */
        @TableField("ALARM_TYPE")
    private String alarmType;

    /**
     * 专业局向
     */
        @TableField("SPOFFICE")
    private String spoffice;

    /**
     * 派单描述
     */
        @TableField("PBIL_DESC")
    private String pbilDesc;

    /**
     * 归并标签表达式
     */
        @TableField("PBIL_MERGE_LABEL")
    private String pbilMergeLabel;

    /**
     * 补派时间
     */
        @TableField("PBIL_REBILL_HOUR_INC")
    private String pbilRebillHourInc;

    /**
     * 派单开始时间
     */
        @TableField("MEDIATION_TIME_START")
    private Double mediationTimeStart;

    /**
     * 派单结束时间
     */
        @TableField("MEDIATION_TIME_END")
    private Double mediationTimeEnd;

    /**
     * 管控权限:0-本地网，2-省公司
     */
        @TableField("CONTROL_PERMISSIONS")
    private Integer controlPermissions;

    /**
     * 派单扩展配置编号
     */
        @TableField("PBEX_ID")
    private String pbexId;

    /**
     * 障碍描述
     */
        @TableField("COMPLAINT_INFO")
    private String complaintInfo;

    /**
     * 工单类型：1-网络单；2-用户单
     */
        @TableField("BILL_TYPE")
    private Integer billType;

    /**
     * 派单本地网
     */
        @TableField("BILL_AREA_CODE")
    private String billAreaCode;

    /**
     * 是否关联网格信息:0-否;1-是
     */
        @TableField("IS_RELATED_GRID")
    private Integer isRelatedGrid;

    /**
     * 一级派单规则
     */
        @TableField("PBIL_FIRST_MERGE_LABEL")
    private String pbilFirstMergeLabel;

    /**
     * 归并描述
     */
        @TableField("MERGER_CAUSE")
    private String mergerCause;

    /**
     * 归并信息
     */
        @TableField("MERGER_INFO")
    private String mergerInfo;

    /**
     * 起始时间
     */
        @TableField("BEGIN_TIME")
    private LocalDateTime beginTime;

    /**
     * 结束时间
     */
        @TableField("END_TIME")
    private LocalDateTime endTime;

    /**
     * 网管名称包含，用与跨网管的派单策略
     */
        @TableField("NM_NAME_INC")
    private String nmNameInc;

    /**
     * 是否跨网管：0-否；1-是 
     */
        @TableField("IS_CROSS_NM")
    private Integer isCrossNm;

    /**
     * 网元编码，对应综调接口 netcode
     */
        @TableField("NET_CODE")
    private String netCode;

    /**
     * 主告警告警概要包含
     */
        @TableField("MASTER_SUMMARY_INC")
    private String masterSummaryInc;

    /**
     * 需求提出人 request user
     */
        @TableField("REQ_USER")
    private String reqUser;

    /**
     * 需求详细内容 request detail
     */
        @TableField("REQ_DETAIL")
    private String reqDetail;

    /**
     * 需求审核人 request auditer
     */
        @TableField("REQ_AUDITER")
    private String reqAuditer;

    /**
     * 需求研发人 request developer
     */
        @TableField("REQ_DEVELOPER")
    private String reqDeveloper;

    /**
     * 需求发布人 request publisher
     */
        @TableField("REQ_PUBLISHER")
    private String reqPublisher;

    /**
     * 发布时间 publish time
     */
        @TableField("PUB_TIME")
    private LocalDateTime pubTime;

    /**
     * 更新内容 release note
     */
        @TableField("RELEASE_NOTE")
    private String releaseNote;

    /**
     * 告警规则适用范围 scope application
     */
        @TableField("SCOPE_APP")
    private String scopeApp;


}
