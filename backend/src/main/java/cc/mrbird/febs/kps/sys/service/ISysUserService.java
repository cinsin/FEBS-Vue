package cc.mrbird.febs.kps.sys.service;

import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.kps.sys.domain.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author Cinsin
 */
public interface ISysUserService extends IService<SysUser> {

    List<SysUser> findSysUser(QueryRequest request, SysUser sysUser);
}
