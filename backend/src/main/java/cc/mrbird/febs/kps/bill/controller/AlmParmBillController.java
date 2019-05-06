package cc.mrbird.febs.kps.bill.controller;


import cc.mrbird.febs.kps.bill.dao.AlmParmBillMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * @author Cinsin
 */
@RestController
@RequestMapping("/kps.bill/alm-parm-bill")
public class AlmParmBillController {

    @Autowired
    AlmParmBillMapper almParmBillMapper;
}
