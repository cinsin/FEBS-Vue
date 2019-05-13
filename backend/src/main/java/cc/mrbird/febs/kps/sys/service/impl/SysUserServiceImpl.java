package cc.mrbird.febs.kps.sys.service.impl;

import cc.mrbird.febs.common.domain.FebsConstant;
import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.common.utils.DESUtil;
import cc.mrbird.febs.common.utils.SortUtil;
import cc.mrbird.febs.kps.sys.domain.SysUser;
import cc.mrbird.febs.kps.sys.dao.SysUserMapper;
import cc.mrbird.febs.kps.sys.service.ISysUserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Cinsin
 */
@Slf4j
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {

    @Override
    public List<SysUser> findSysUser(QueryRequest request, SysUser sysUser) {


        QueryWrapper<SysUser> queryWrapper = new QueryWrapper<>();

        /*if (StringUtils.isNotBlank(dept.getDeptName()))
            queryWrapper.lambda().eq(Dept::getDeptName, dept.getDeptName());
        if (StringUtils.isNotBlank(dept.getCreateTimeFrom()) && StringUtils.isNotBlank(dept.getCreateTimeTo()))
            queryWrapper.lambda()
                    .ge(Dept::getCreateTime, dept.getCreateTimeFrom())
                    .le(Dept::getCreateTime, dept.getCreateTimeTo());*/
        queryWrapper.eq("is_valid", 1);
        SortUtil.handleWrapperSort(request, queryWrapper, "userName", FebsConstant.ORDER_ASC, true);
        List<SysUser> result =  this.baseMapper.selectList(queryWrapper);

        DESUtil desUtil = null;
        try {
            desUtil = new DESUtil();
        } catch (Exception e) {
            e.printStackTrace();
        }

        DESUtil finalDesUtil = desUtil;
        result.forEach(user -> {
            String userName = user.getUserName();
            String userLoginName = user.getUserLoginName();
            String userLoginPwd = user.getUserLoginPwd();
            String dePwd = null;
            try {
                dePwd = finalDesUtil.decrypt(userLoginPwd);
            } catch (Exception e) {
                e.printStackTrace();
            }

            log.info("loginName [{}], loginPwd [{}], dePwd [{}]", userLoginName, userLoginPwd, dePwd);

        });

        return result;
    }
}
