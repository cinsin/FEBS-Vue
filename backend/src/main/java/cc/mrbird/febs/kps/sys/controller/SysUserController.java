package cc.mrbird.febs.kps.sys.controller;


import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.kps.sys.domain.SysUser;
import cc.mrbird.febs.kps.sys.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author Cinsin
 */
@RestController
@RequestMapping("/sys/sys-user")
public class SysUserController {

    @Autowired
    ISysUserService sysUserService;

    @GetMapping
    public List<SysUser> parmBillExpendList(QueryRequest request, SysUser sysUser) {
        //return this.almParmBillExpendService.findParmBillExpend(request, almParmBillExpend);
        return this.sysUserService.findSysUser(request, sysUser);
    }
}
