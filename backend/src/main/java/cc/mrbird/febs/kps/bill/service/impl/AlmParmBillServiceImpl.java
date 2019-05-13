package cc.mrbird.febs.kps.bill.service.impl;

import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.common.utils.SortUtil;
import cc.mrbird.febs.kps.bill.domain.AlmParmBill;
import cc.mrbird.febs.kps.bill.dao.AlmParmBillMapper;
import cc.mrbird.febs.kps.bill.service.IAlmParmBillService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Cinsin
 */
@Slf4j
@Service
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public class AlmParmBillServiceImpl extends ServiceImpl<AlmParmBillMapper, AlmParmBill> implements IAlmParmBillService {
    @Autowired
    AlmParmBillMapper almParmBillMapper;

    @Override
    public IPage<AlmParmBill> findParmBill(QueryRequest request, AlmParmBill almParmBill) {

        QueryWrapper<AlmParmBill> queryWrapper = new QueryWrapper<>();

        Page<AlmParmBill> page = new Page<>();
        SortUtil.handlePageSort(request, page, true);

        return almParmBillMapper.findAlmParmBill(page, queryWrapper);
    }

    @Override
    public void createParmBill(AlmParmBill almParmBill) {

    }

    @Override
    public void updateParmBill(AlmParmBill almParmBill) {
        almParmBill.setLastUpdated(LocalDateTime.now());
        baseMapper.updateById(almParmBill);
    }

    @Override
    public void deleteParmBills(String[] pbilIds) {

    }
}
