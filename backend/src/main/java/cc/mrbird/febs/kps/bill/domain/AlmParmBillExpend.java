package cc.mrbird.febs.kps.bill.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * APBEX派单模式扩展表
 *
 * @author Cinsin
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("T_ALM_PARM_BILL_EXPEND")
public class AlmParmBillExpend implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 派单扩展配置编号
     */
    @TableId("PBEX_ID")
    private String pbexId;

    /**
     * 派单扩展配置名称
     */
    @TableField("PBEX_NAME")
    private String pbexName;

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
     * 管控权限
     */
    @TableField("CONTROL_PERMISSIONS")
    private Integer controlPermissions;

    /**
     * 派单扩展配置关联编号
     */
    @TableField("PBEX_ID_FK")
    private String pbexIdFk;

    /**
     * 归并标签表达式
     */
    @TableField("PBIL_MERGE_LABEL")
    private String pbilMergeLabel;

    @TableField("BILL_AREA_CODE")
    private String billAreaCode;

    @TableField("BILL_TYPE")
    private Integer billType;


}
