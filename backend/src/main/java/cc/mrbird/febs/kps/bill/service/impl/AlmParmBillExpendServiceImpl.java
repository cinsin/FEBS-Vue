package cc.mrbird.febs.kps.bill.service.impl;

import cc.mrbird.febs.common.domain.FebsConstant;
import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.common.utils.SortUtil;
import cc.mrbird.febs.kps.bill.dao.AlmParmBillExpendMapper;
import cc.mrbird.febs.kps.bill.domain.AlmParmBillExpend;
import cc.mrbird.febs.kps.bill.service.IAlmParmBillExpendService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Cinsin
 */
@Service
@Slf4j
public class AlmParmBillExpendServiceImpl extends ServiceImpl<AlmParmBillExpendMapper, AlmParmBillExpend> implements IAlmParmBillExpendService {

    @Override
    public List<AlmParmBillExpend> findParmBillExpend(QueryRequest request, AlmParmBillExpend almParmBillExpend) {
        QueryWrapper<AlmParmBillExpend> queryWrapper = new QueryWrapper<>();

        /*if (StringUtils.isNotBlank(dept.getDeptName()))
            queryWrapper.lambda().eq(Dept::getDeptName, dept.getDeptName());
        if (StringUtils.isNotBlank(dept.getCreateTimeFrom()) && StringUtils.isNotBlank(dept.getCreateTimeTo()))
            queryWrapper.lambda()
                    .ge(Dept::getCreateTime, dept.getCreateTimeFrom())
                    .le(Dept::getCreateTime, dept.getCreateTimeTo());*/
        SortUtil.handleWrapperSort(request, queryWrapper, "pbexName", FebsConstant.ORDER_ASC, true);
        return this.baseMapper.selectList(queryWrapper);
    }
}
