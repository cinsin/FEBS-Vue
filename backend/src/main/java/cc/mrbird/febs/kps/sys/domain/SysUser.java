package cc.mrbird.febs.kps.sys.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;

import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * SUSER系统用户
 *
 * @author Cinsin
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("T_SYS_USER")
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户号
     */
    @TableId("USER_ID")
    private String userId;

    /**
     * 网管区域号
     */
    @TableField("AREA_ID")
    private String areaId;

    /**
     * 中文全名
     */
    @TableField("USER_NAME")
    private String userName;

    /**
     * 性别:1-男;0-女
     */
    @TableField("USER_GENDER_TYPE")
    private Integer userGenderType;

    /**
     * 登录名
     */
    @TableField("USER_LOGIN_NAME")
    private String userLoginName;

    /**
     * 登录密码
     */
    @TableField("USER_LOGIN_PWD")
    private String userLoginPwd;

    /**
     * 有效:1-是;0-否
     */
    @TableField("IS_VALID")
    private Integer isValid;

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
     * 手机号
     */
    @TableField("USER_MOBILE_NUM")
    private String userMobileNum;

    /**
     * 办公电话
     */
    @TableField("USER_OFFICE_NUM")
    private String userOfficeNum;

    /**
     * 邮箱
     */
    @TableField("USER_MAIL")
    private String userMail;

    /**
     * 用户说明
     */
    @TableField("USER_DESC")
    private String userDesc;

    /**
     * 连续错误登陆次数，如果该用户被锁，只需将该值设为0即可解锁
     */
    @TableField("LOGIN_WRONG_TIME")
    private Double loginWrongTime;

    /**
     * 专业id
     */
    @TableField("SPEC_ID")
    private String specId;

    /**
     * 是否锁定:1-是;0-否
     */
    @TableField("IS_LOCKED")
    private Integer isLocked;

    /**
     * 部门ID
     */
    @TableField("DEPT_ID")
    private Long deptId;

    /**
     * 最后登录时间
     */
    @TableField("LAST_LOGIN_TIME")
    private LocalDateTime lastLoginTime;

    /**
     * 头像
     */
    @TableField("AVATAR")
    private String avatar;

    /**
     * 真实姓名
     */
    @TableField("REAL_NAME")
    private String realName;

    /**
     * 身份证号
     */
    @TableField("ID_CARD_NO")
    private String idCardNo;


}
