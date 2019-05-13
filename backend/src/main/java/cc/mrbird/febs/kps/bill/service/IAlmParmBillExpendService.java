package cc.mrbird.febs.kps.bill.service;

import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.kps.bill.domain.AlmParmBillExpend;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * @author Cinsin
 */
public interface IAlmParmBillExpendService extends IService<AlmParmBillExpend> {

    List<AlmParmBillExpend> findParmBillExpend(QueryRequest request, AlmParmBillExpend almParmBillExpend);
}
