package cc.mrbird.febs.kps.bill.controller;


import cc.mrbird.febs.common.controller.BaseController;
import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.kps.bill.domain.AlmParmBillExpend;
import cc.mrbird.febs.kps.bill.service.IAlmParmBillExpendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author Cinsin
 */
@RestController
@RequestMapping("/auto-bill/parm-bill-expend")
public class AlmParmBillExpendController extends BaseController {
    @Autowired
    private IAlmParmBillExpendService almParmBillExpendService;

    @GetMapping
    public List<AlmParmBillExpend> parmBillExpendList(QueryRequest request, AlmParmBillExpend almParmBillExpend) {
        return this.almParmBillExpendService.findParmBillExpend(request, almParmBillExpend);
    }
}
