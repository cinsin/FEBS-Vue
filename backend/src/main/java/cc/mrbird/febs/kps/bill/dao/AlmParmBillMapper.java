package cc.mrbird.febs.kps.bill.dao;

import cc.mrbird.febs.kps.bill.domain.AlmParmBill;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.data.repository.query.Param;


/**
 * @author Cinsin
 */
public interface AlmParmBillMapper extends BaseMapper<AlmParmBill> {
    IPage<AlmParmBill> findAlmParmBill(Page page, @Param("ew") QueryWrapper<AlmParmBill> queryWrapper);
}
