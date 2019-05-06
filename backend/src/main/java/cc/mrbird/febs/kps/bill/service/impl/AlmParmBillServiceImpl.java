package cc.mrbird.febs.kps.bill.service.impl;

import cc.mrbird.febs.kps.bill.domain.AlmParmBill;
import cc.mrbird.febs.kps.bill.dao.AlmParmBillMapper;
import cc.mrbird.febs.kps.bill.service.IAlmParmBillService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Cinsin
 */
@Service
public class AlmParmBillServiceImpl extends ServiceImpl<AlmParmBillMapper, AlmParmBill> implements IAlmParmBillService {
    @Autowired
    AlmParmBillMapper almParmBillMapper;
}
