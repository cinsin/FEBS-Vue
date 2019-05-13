<template>
  <a-drawer
    title="修改派单规则"
    :maskClosable="false"
    width=650
    placement="right"
    :closable="false"
    @close="onClose"
    :visible="parmBillEditVisiable"
    style="height: calc(100% - 55px);overflow: auto;padding-bottom: 53px;">
    <a-form :form="form">
      <a-form-item label='是否跨网管' v-bind="formItemLayout">
        <a-switch v-decorator="['isCrossNm',{rules: [{ required: true, message: '不能为空'}]}]"
                  :checked="this.form.getFieldValue('isCrossNm')"
                  checkedChildren="是" unCheckedChildren="否" />
      </a-form-item>
      <!--网管名称通过数据库加载，并且支持实时搜索、支持多选，且至少选2个或以上-->
      <a-form-item label='网管名称包含' v-bind="formItemLayout" v-show="this.form.getFieldValue('isCrossNm')">
        <a-input v-decorator="['nmNameInc',{rules: [
                    { required: this.form.getFieldValue('isCrossNm'), message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='网管' v-bind="formItemLayout">
        <a-input v-decorator="['nmName',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='派单分组' v-bind="formItemLayout">
        <a-input v-decorator="['fgbiName',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='派单名' v-bind="formItemLayout">
        <a-input v-decorator="['pbilName',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='派单代码' v-bind="formItemLayout">
        <a-input v-decorator="['pbilCode',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='派单描述' v-bind="formItemLayout">
        <a-textarea v-decorator="['pbilDesc']" :autosize="{ minRows: 2, maxRows: 6 }"/>
      </a-form-item>
      <a-form-item label='需求提出人' v-bind="formItemLayout">
        <a-input v-decorator="['reqUser',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]"/>
      </a-form-item>
      <a-form-item label='需求详细内容' v-bind="formItemLayout">
        <a-textarea v-decorator="['reqDetail',
                   {rules: [
                    { required: true, message: '不能为空'}
                  ]}]" :autosize="{ minRows: 2, maxRows: 6 }"/>
      </a-form-item>
      <a-form-item label='需求审核人' v-bind="formItemLayout">
        <a-select v-decorator="['reqAuditer', {rules: [ { required: true, message: '不能为空'} ]}]"
                  @focus="handleSelectFocus('reqAuditer')"
                  @blur="handleSelectBlur('reqAuditer')">
          <a-select-option v-for="d in this.reqAuditer" :key="d.userId">{{d.userName}}</a-select-option>
        </a-select>
      </a-form-item>
      <a-form-item label='需求研发人' v-bind="formItemLayout">
        <a-input v-decorator="['reqDeveloper']"/>
      </a-form-item>
      <a-form-item label='需求发布人' v-bind="formItemLayout">
        <a-input v-decorator="['reqPublisher']"/>
      </a-form-item>
      <a-form-item label='发布时间' v-bind="formItemLayout">
        <a-input v-decorator="['pubTime']"/>
      </a-form-item>
      <a-form-item label='更新内容' v-bind="formItemLayout">
        <a-textarea v-decorator="['releaseNote']" :autosize="{ minRows: 2, maxRows: 6 }"/>
      </a-form-item>
      <a-form-item label='告警规则适用范围' v-bind="formItemLayout">
        <a-textarea v-decorator="['scopeApp']" :autosize="{ minRows: 2, maxRows: 6 }"/>
      </a-form-item>
      <a-row type="flex" justify="end" :gutter="4">
        <a-col :span="11">
          <a-form-item label='预处理取消' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['pbilIsRevokable', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('pbilIsRevokable')"
                      checkedChildren="是" unCheckedChildren="否" />
          </a-form-item>
        </a-col>
        <a-col :span="11">
          <a-form-item label='忽略恢复' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['pbilIsIgnoreCleared', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('pbilIsIgnoreCleared')"
                      checkedChildren="是" unCheckedChildren="否" />
          </a-form-item>
        </a-col>
      </a-row>
      <a-row type="flex" justify="end" :gutter="4">
        <a-col :span="11">
          <a-form-item label='是否归并' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['pbilIsMerge', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('pbilIsMerge')"
                      checkedChildren="是" unCheckedChildren="否" />
          </a-form-item>
        </a-col>
        <a-col :span="11">
          <a-form-item label='自动派单到人' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['isAuto', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('isAuto')"
                      checkedChildren="是" unCheckedChildren="否" />
          </a-form-item>
        </a-col>
      </a-row>
      <a-row type="flex" justify="end" :gutter="4">
        <a-col :span="11">
          <a-form-item label='次日补派' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['pbilIsRebill', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('pbilIsRebill')"
                      checkedChildren="是" unCheckedChildren="否" />
          </a-form-item>
        </a-col>
        <a-col :span="11">
          <a-form-item label='审核状态' v-bind="formItemLayoutHalf">
            <a-switch v-decorator="['auditStat', {rules: [ { required: true, message: '不能为空'} ]}]"
                      :checked="this.form.getFieldValue('auditStat')"
                      checkedChildren="审核通过" unCheckedChildren="未生效" />
          </a-form-item>
        </a-col>
      </a-row>
      <a-form-item label='开关状态' v-bind="formItemLayout">
        <a-switch v-decorator="['pbilSwStat', {rules: [ { required: true, message: '不能为空'} ]}]"
                  :checked="this.form.getFieldValue('pbilSwStat')"
                  checkedChildren="开" unCheckedChildren="关" />
      </a-form-item>
      <a-form-item label='匹配层次' v-bind="formItemLayout">
        <a-radio-group
          v-decorator="[
            'pbilLevel',
            {rules: [{ required: true, message: '请选择' }]}
          ]">
          <a-radio value="0">首次匹配</a-radio>
          <a-radio value="1">二次匹配</a-radio>
          <a-radio value="2">三次匹配</a-radio>
          <a-radio value="3">四次匹配</a-radio>
        </a-radio-group>
      </a-form-item>
      <a-form-item label='数量门限类型' v-bind="formItemLayout">
        <a-radio-group
          v-decorator="[
            'pbilLimitType',
            {rules: [{ required: true, message: '请选择' }]}
          ]">
          <a-radio value="0">归并数</a-radio>
          <a-radio value="1">累计数</a-radio>
        </a-radio-group>
      </a-form-item>
      <a-form-item label='下级关联扩展表' v-bind="formItemLayout">
        <a-select v-decorator="['pbexName']"
                  @focus="handleSelectFocus('pbexName')"
                  @blur="handleSelectBlur('pbexName')">
          <a-select-option v-for="d in this.parmBillExpend" :key="d.pbexId">{{d.pbexName}}</a-select-option>
        </a-select>
      </a-form-item>
      <!--<a-form-item label='故障区域代码包含' v-bind="formItemLayout">
        <a-select
          mode="multiple"
          placeholder="可选择多个本地网"
          @change="handleChange"
          style="width: 100%">
          <a-select-option value="常州">常州</a-select-option>
          <a-select-option value="淮安">淮安</a-select-option>
          <a-select-option value="连云港">连云港</a-select-option>
          <a-select-option value="南京">南京</a-select-option>
        </a-select>
      </a-form-item>-->
      <a-form-item label='故障区域代码包含' v-bind="formItemLayout">
        <a-input v-decorator="['relatedAreaCodeInc']"/>
      </a-form-item>
      <a-form-item label='故障区域代码不包含' v-bind="formItemLayout">
        <a-input v-decorator="['relatedAreaCodeExc']"/>
      </a-form-item>
      <a-form-item label='故障区域名包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultAreaNameInc']"/>
      </a-form-item>
      <a-form-item label='故障区域名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultAreaNameExc']"/>
      </a-form-item>
      <a-form-item label='故障子区域代码包含' v-bind="formItemLayout">
        <a-input v-decorator="['relatedSubareaCodeInc']"/>
      </a-form-item>
      <a-form-item label='故障子区域代码不包含' v-bind="formItemLayout">
        <a-input v-decorator="['relatedSubareaCodeExc']"/>
      </a-form-item>
      <a-form-item label='故障子区域名包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultSubareaNameInc']"/>
      </a-form-item>
      <a-form-item label='故障子区域名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultSubareaNameExc']"/>
      </a-form-item>
      <a-form-item label='优先级包含' v-bind="formItemLayout">
        <a-input v-decorator="['priorityInc']"/>
      </a-form-item>
      <a-form-item label='优先级不包含' v-bind="formItemLayout">
        <a-input v-decorator="['priorityExc']"/>
      </a-form-item>
      <a-form-item label='恢复标识包含' v-bind="formItemLayout">
        <a-input v-decorator="['clearedInc']"/>
      </a-form-item>
      <a-form-item label='恢复标识不包含' v-bind="formItemLayout">
        <a-input v-decorator="['clearedExc']"/>
      </a-form-item>
      <a-form-item label='割接状态包含' v-bind="formItemLayout">
        <a-input v-decorator="['cutStatInc']"/>
      </a-form-item>
      <a-form-item label='割接状态不包含' v-bind="formItemLayout">
        <a-input v-decorator="['cutStatExc']"/>
      </a-form-item>
      <a-form-item label='设备名称包含' v-bind="formItemLayout">
        <a-input v-decorator="['userLabelInc']"/>
      </a-form-item>
      <a-form-item label='设备名称不包含' v-bind="formItemLayout">
        <a-input v-decorator="['userLabelExc']"/>
      </a-form-item>
      <a-form-item label='设备名称大写包含' v-bind="formItemLayout">
        <a-input v-decorator="['userLabelUcaseInc']"/>
      </a-form-item>
      <a-form-item label='设备名称大写不包含' v-bind="formItemLayout">
        <a-input v-decorator="['userLabelUcaseExc']"/>
      </a-form-item>
      <a-form-item label='概要包含' v-bind="formItemLayout">
        <a-input v-decorator="['summaryInc']"/>
      </a-form-item>
      <a-form-item label='概要不包含' v-bind="formItemLayout">
        <a-input v-decorator="['summaryExc']"/>
      </a-form-item>
      <a-form-item label='概要大写包含' v-bind="formItemLayout">
        <a-input v-decorator="['summaryUcaseInc']"/>
      </a-form-item>
      <a-form-item label='概要大写不包含' v-bind="formItemLayout">
        <a-input v-decorator="['summaryUcaseExc']"/>
      </a-form-item>
      <a-form-item label='消息类型编号包含' v-bind="formItemLayout">
        <a-input v-decorator="['mstyIdInc']"/>
      </a-form-item>
      <a-form-item label='消息类型名包含' v-bind="formItemLayout">
        <a-input v-decorator="['mstyNameInc']"/>
      </a-form-item>
      <a-form-item label='消息类型名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['mstyNameExc']"/>
      </a-form-item>
      <a-form-item label='故障信息包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultInfoInc']"/>
      </a-form-item>
      <a-form-item label='故障信息不包含' v-bind="formItemLayout">
        <a-input v-decorator="['faultInfoExc']"/>
      </a-form-item>
      <a-form-item label='网元类型编号包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqtyIdInc']"/>
      </a-form-item>
      <a-form-item label='网元类型编号不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqtyIdExc']"/>
      </a-form-item>
      <a-form-item label='网元类型名包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqtyNameInc']"/>
      </a-form-item>
      <a-form-item label='网元类型名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqtyNameExc']"/>
      </a-form-item>
      <a-form-item label='网元号包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpIdInc']"/>
      </a-form-item>
      <a-form-item label='网元号不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpIdExc']"/>
      </a-form-item>
      <a-form-item label='网元名称包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpNameInc']"/>
      </a-form-item>
      <a-form-item label='网元名称不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpNameExc']"/>
      </a-form-item>
      <a-form-item label='局点名包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpSpofficeInc']"/>
      </a-form-item>
      <a-form-item label='局点名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpSpofficeExc']"/>
      </a-form-item>
      <a-form-item label='地点信息包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpPlaceInc']"/>
      </a-form-item>
      <a-form-item label='地点信息不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpPlaceExc']"/>
      </a-form-item>
      <a-form-item label='位置信息包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpPostInc']"/>
      </a-form-item>
      <a-form-item label='位置信息不包含' v-bind="formItemLayout">
        <a-input v-decorator="['eqpPostExc']"/>
      </a-form-item>
      <a-form-item label='端口编号包含' v-bind="formItemLayout">
        <a-input v-decorator="['portIdInc']"/>
      </a-form-item>
      <a-form-item label='端口编号不包含' v-bind="formItemLayout">
        <a-input v-decorator="['portIdExc']"/>
      </a-form-item>
      <a-form-item label='端口名包含' v-bind="formItemLayout">
        <a-input v-decorator="['portNameInc']"/>
      </a-form-item>
      <a-form-item label='端口名不包含' v-bind="formItemLayout">
        <a-input v-decorator="['portNameExc']"/>
      </a-form-item>
      <a-form-item label='负责人包含' v-bind="formItemLayout">
        <a-input v-decorator="['almRsprInc']"/>
      </a-form-item>
      <a-form-item label='负责人不包含' v-bind="formItemLayout">
        <a-input v-decorator="['almRsprExc']"/>
      </a-form-item>
      <a-form-item label='扩充A包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextaInc']"/>
      </a-form-item>
      <a-form-item label='扩充A不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextaExc']"/>
      </a-form-item>
      <a-form-item label='扩充B包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextbInc']"/>
      </a-form-item>
      <a-form-item label='扩充B不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextbExc']"/>
      </a-form-item>
      <a-form-item label='扩充C包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextcInc']"/>
      </a-form-item>
      <a-form-item label='扩充C不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextcExc']"/>
      </a-form-item>
      <a-form-item label='扩充D包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextdInc']"/>
      </a-form-item>
      <a-form-item label='扩充D不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextdExc']"/>
      </a-form-item>
      <a-form-item label='扩充E包含' v-bind="formItemLayout">
        <a-input v-decorator="['contexteInc']"/>
      </a-form-item>
      <a-form-item label='扩充E不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contexteExc']"/>
      </a-form-item>
      <a-form-item label='扩充F包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextfInc']"/>
      </a-form-item>
      <a-form-item label='扩充F不包含' v-bind="formItemLayout">
        <a-input v-decorator="['contextfExc']"/>
      </a-form-item>
      <a-form-item label='详细内容包含' v-bind="formItemLayout">
        <a-input v-decorator="['detailsInc']"/>
      </a-form-item>
      <a-form-item label='详细内容不包含' v-bind="formItemLayout">
        <a-input v-decorator="['detailsExc']"/>
      </a-form-item>
      <a-form-item label='详细内容大写包含' v-bind="formItemLayout">
        <a-input v-decorator="['detailsUcaseInc']"/>
      </a-form-item>
      <a-form-item label='详细内容大写不包含' v-bind="formItemLayout">
        <a-input v-decorator="['detailsUcaseExc']"/>
      </a-form-item>
      <a-form-item label='告警星期值包含' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeWeekInc']"/>
      </a-form-item>
      <a-form-item label='告警星期值不包含' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeWeekExc']"/>
      </a-form-item>
      <a-form-item label='告警小时值包含' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeHourInc']"/>
      </a-form-item>
      <a-form-item label='告警小时值不包含' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeStart']"/>
      </a-form-item>
      <a-form-item label='告警时间大于' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeStart']"/>
      </a-form-item>
      <a-form-item label='告警时间小于' v-bind="formItemLayout">
        <a-input v-decorator="['mediationTimeEnd']"/>
      </a-form-item>
      <a-form-item label='一级归并标签表达式' v-bind="formItemLayout">
        <a-input v-decorator="['pbilFirstMergeLabel']"/>
      </a-form-item>
      <a-form-item label='归并标签表达式' v-bind="formItemLayout">
        <a-input v-decorator="['pbilMergeLabel']"/>
      </a-form-item>
      <a-form-item label='主告警告警概要包含' v-bind="formItemLayout">
        <a-input v-decorator="['masterSummaryInc']"/>
      </a-form-item>
      <a-form-item label='补派时间' v-bind="formItemLayout">
        <a-input v-decorator="['pbilRebillHourInc']"/>
      </a-form-item>
      <a-form-item label='补派范围(小时)' v-bind="formItemLayout">
        <a-input v-decorator="['pbilRebilLen']"/>
      </a-form-item>
      <a-form-item label='延时时长(秒)' v-bind="formItemLayout">
        <a-input v-decorator="['pbilDelayLen']"/>
      </a-form-item>
      <a-form-item label='设备重复派单时长(秒)' v-bind="formItemLayout">
        <a-input v-decorator="['pbilEqpRepLen']"/>
      </a-form-item>
      <a-form-item label='告警数门限' v-bind="formItemLayout">
        <a-input v-decorator="['pbilLimitCount']"/>
      </a-form-item>
      <a-form-item label='主专业类型' v-bind="formItemLayout">
        <a-input v-decorator="['mainSpecialid']"/>
      </a-form-item>
      <a-form-item label='专业类型' v-bind="formItemLayout">
        <a-input v-decorator="['specialid']"/>
      </a-form-item>
      <a-form-item label='管控权限' v-bind="formItemLayout">
        <a-input v-decorator="['controlPermissions']"/>
      </a-form-item>
      <a-form-item label='派单本地网' v-bind="formItemLayout">
        <a-input v-decorator="['billAreaCode']"/>
      </a-form-item>
      <a-form-item label='是否关联网格信息' v-bind="formItemLayout">
        <a-switch v-decorator="['isRelatedGrid']"
                  :checked="this.form.getFieldValue('isRelatedGrid')"
                  checkedChildren="是" unCheckedChildren="否" />
      </a-form-item>
      <a-form-item label='故障类型' v-bind="formItemLayout">
        <a-input v-decorator="['faulttypeid']"/>
      </a-form-item>
      <a-form-item label='故障单等级' v-bind="formItemLayout">
        <a-input v-decorator="['billPriority']"/>
      </a-form-item>
      <a-form-item label='预警对象名称' v-bind="formItemLayout">
        <a-input v-decorator="['alarmContent']"/>
      </a-form-item>
      <a-form-item label='预警详细内容' v-bind="formItemLayout">
        <a-input v-decorator="['alarmObjName']"/>
      </a-form-item>
      <a-form-item label='预警指标名称' v-bind="formItemLayout">
        <a-input v-decorator="['alarmIndexName']"/>
      </a-form-item>
      <a-form-item label='预警生成城市' v-bind="formItemLayout">
        <a-input v-decorator="['alarmCity']"/>
      </a-form-item>
      <a-form-item label='区域ID' v-bind="formItemLayout">
        <a-input v-decorator="['billAreaId']"/>
      </a-form-item>
      <a-form-item label='网元编码' v-bind="formItemLayout">
        <a-input v-decorator="['netCode']"/>
      </a-form-item>
      <a-form-item label='网元名称' v-bind="formItemLayout">
        <a-input v-decorator="['netName']"/>
      </a-form-item>
      <a-form-item label='运营商信息' v-bind="formItemLayout">
        <a-input v-decorator="['traderInfo']"/>
      </a-form-item>
      <a-form-item label='障碍现象' v-bind="formItemLayout">
        <a-input v-decorator="['faultActual']"/>
      </a-form-item>
      <a-form-item label='障碍信息' v-bind="formItemLayout">
        <a-input v-decorator="['faultInfo']"/>
      </a-form-item>
      <a-form-item label='障碍标题' v-bind="formItemLayout">
        <a-input v-decorator="['title']"/>
      </a-form-item>
      <a-form-item label='障碍来源' v-bind="formItemLayout">
        <a-input v-decorator="['faultSrcId']"/>
      </a-form-item>
      <a-form-item label='告警类型' v-bind="formItemLayout">
        <a-input v-decorator="['alarmType']"/>
      </a-form-item>
      <a-form-item label='专业局向' v-bind="formItemLayout">
        <a-input v-decorator="['spoffice']"/>
      </a-form-item>
      <a-form-item label='归并描述' v-bind="formItemLayout">
        <a-input v-decorator="['mergerCause']"/>
      </a-form-item>
      <a-form-item label='归并信息' v-bind="formItemLayout">
        <a-input v-decorator="['mergerInfo']"/>
      </a-form-item>
      <a-form-item label='起始时间' v-bind="formItemLayout">
        <a-input v-decorator="['beginTime']"/>
      </a-form-item>
      <a-form-item label='结束时间' v-bind="formItemLayout">
        <a-input v-decorator="['endTime']"/>
      </a-form-item>
      <a-form-item label='工单类型' v-bind="formItemLayout">
        <a-radio-group
          v-decorator="['billType',
            {rules: [{ required: true, message: '请选择' }]}
          ]">
          <a-radio value="1">网络单</a-radio>
          <a-radio value="2">用户单</a-radio>
        </a-radio-group>
      </a-form-item>
    </a-form>
    <div class="drawer-bootom-button">
      <a-popconfirm title="确定放弃编辑？" @confirm="onClose" okText="确定" cancelText="取消">
        <a-button style="margin-right: .8rem">取消</a-button>
      </a-popconfirm>
      <a-button @click="handleSubmit" type="primary" :loading="loading">提交</a-button>
    </div>
  </a-drawer>
</template>
<script>
import ATextarea from 'ant-design-vue/es/input/TextArea'
import AFormItem from 'ant-design-vue/es/form/FormItem'
import ARow from 'ant-design-vue/es/grid/Row'
import ACol from 'ant-design-vue/es/grid/Col'
const formItemLayout = {
  labelCol: { span: 6 },
  wrapperCol: { span: 18 }
}
const formItemLayoutHalf = {
  labelCol: { span: 9 },
  wrapperCol: { span: 15 }
}
export default {
  name: 'ParmBillEdit',
  components: {ACol, ARow, AFormItem, ATextarea},
  props: {
    parmBillEditVisiable: {
      default: false
    }
  },
  data () {
    return {
      loading: false,
      formItemLayout,
      formItemLayoutHalf,
      form: this.$form.createForm(this),
      parmBill: {},
      parmBillExpend: {},
      reqAuditer: {}
    }
  },
  methods: {
    reset () {
      this.loading = false
      this.form.resetFields()
    },
    onClose () {
      this.reset()
      this.$emit('close')
    },
    handleSelectFocus (column) {
      console.log('handleSelectFocus - fetch data from server for column: ' + column)
      if (column === 'pbexName') {
        this.$get('auto-bill/parm-bill-expend').then((r) => {
          this.parmBillExpend = r.data
          // console.log('data:' + JSON.stringify(this.parmBillExpend))
        })
      } else if (column === 'reqAuditer') {
        this.$get('sys/sys-user').then((r) => {
          this.reqAuditer = r.data
          // console.log('data:' + JSON.stringify(this.reqAuditer))
        })
      }
    },
    handleSelectBlur (column) {
      console.log('handleSelectBlur - fetch data from server for column: ' + column)
    },
    setFormValues ({...parmBill}) {
      // 不定义fields，把entity中所有列全部放到form中，界面展示可以直接用，注意如果表单中的数据变化，根据双向绑定，
      // 使用form.getFieldsValue()只能获取到界面上显示的列，不显示的列获取不到，提交时候可从this.parmBill变量中获取
      Object.keys(parmBill).forEach((key) => {
        this.form.getFieldDecorator(key)
        let obj = {}
        obj[key] = parmBill[key]
        // 针对A-RADIO组件：当值为数字时候，需要转换为字符串，否则界面上无法渲染（不会根据值选中相应的radio）
        let column = ['pbilLevel', 'pbilLimitType', 'billType', 'isRelatedGrid']
        column.forEach(col => {
          if (key === col) {
            obj[key] = parmBill[key].toString()
          }
        })
        // 针对A-SWITCH组件，将初始值数字转换为boolean，否则console会有错误提示
        column = ['isCrossNm', 'pbilIsRevokable', 'pbilIsIgnoreCleared', 'pbilIsMerge', 'isAuto', 'pbilIsRebill',
          'auditStat', 'pbilSwStat', 'isRelatedGrid']
        column.forEach((col) => {
          if (key === col) {
            let value = parmBill[key]
            if (typeof value === 'number' && isFinite(value)) {
              obj[key] = value === 1
            } else {
              obj[key] = value
            }
          }
        })
        this.form.setFieldsValue(obj)
      })
      // 提交表单时候，从this.parmBill中获取界面上未显示的字段
      this.parmBill = parmBill
    },
    handleSubmit () {
      this.form.validateFields((err, values) => {
        if (!err) {
          let parmBill = this.form.getFieldsValue()
          parmBill.pbilId = this.parmBill.pbilId // 通过this.parmBill变量获取主键
          this.$put('auto-bill/parm-bill', {
            ...parmBill
          }).then(() => {
            this.reset()
            this.$emit('success')
          }).catch(() => {
            this.loading = false
          })
        }
      })
    }
  }
}
</script>
