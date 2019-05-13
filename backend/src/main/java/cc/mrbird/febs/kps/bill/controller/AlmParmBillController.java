package cc.mrbird.febs.kps.bill.controller;


import cc.mrbird.febs.common.annotation.Log;
import cc.mrbird.febs.common.controller.BaseController;
import cc.mrbird.febs.common.domain.QueryRequest;
import cc.mrbird.febs.common.exception.FebsException;
import cc.mrbird.febs.kps.bill.dao.AlmParmBillMapper;
import cc.mrbird.febs.kps.bill.domain.AlmParmBill;
import cc.mrbird.febs.kps.bill.service.IAlmParmBillService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.beans.PropertyEditorSupport;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Map;

/**
 * @author Cinsin
 */
@Slf4j
@Validated
@RestController
@RequestMapping("/auto-bill/parm-bill")
public class AlmParmBillController extends BaseController {

    private String message;

    @Autowired
    IAlmParmBillService almParmBillService;

    @GetMapping
    @RequiresPermissions("auto-bill/parm-bill:view")
    public Map<String, Object> ParmBillList(QueryRequest request, AlmParmBill almParmBill) {
        return getDataTable(this.almParmBillService.findParmBill(request, almParmBill));
    }

    @Log("修改派单规则")
    @PutMapping
    @RequiresPermissions("auto-bill/parm-bill:update")
    public void updateParmBill(@Valid AlmParmBill almParmBill) throws FebsException {
        try {
            this.almParmBillService.updateParmBill(almParmBill);
        } catch (Exception e) {
            message = "修改派单规则失败";
            log.error(message, e);
            throw new FebsException(message);
        }
    }

    /**
     * 将此controller中entity的非String属性为String类型
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(true);
        // 转换String -> Date
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));

        // String -> LocalDateTime
        binder.registerCustomEditor(LocalDateTime.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException{
                setValue(LocalDateTime.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")));
            }

            @Override
            public String getAsText() throws IllegalArgumentException {
                return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss").format((LocalDateTime) getValue());
            }
        });
    }
}