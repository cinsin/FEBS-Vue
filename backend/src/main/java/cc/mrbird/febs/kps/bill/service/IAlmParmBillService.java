package cc.mrbird.febs.kps.bill.service;

import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.kps.bill.domain.AlmParmBill;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * @author Cinsin
 */
public interface IAlmParmBillService extends IService<AlmParmBill> {

    IPage<AlmParmBill> findParmBill(QueryRequest request, AlmParmBill dict);

    void createParmBill(AlmParmBill almParmBill);

    void updateParmBill(AlmParmBill almParmBill);

    void deleteParmBills(String[] pbilIds);

}
