<template>
  <a-card :bordered="false" class="card-area">
    <div :class="advanced ? 'search' : null">
      <!-- 搜索区域 -->
      <a-form layout="horizontal">
        <a-row >
          <div :class="advanced ? null: 'fold'">
            <a-col :md="12" :sm="24" >
              <a-form-item
                label="派单名"
                :labelCol="{span: 4}"
                :wrapperCol="{span: 18, offset: 2}">
                <a-input v-model="queryParams.username"/>
              </a-form-item>
            </a-col>
            <a-col :md="12" :sm="24" >
              <a-form-item
                label="部门"
                :labelCol="{span: 4}"
                :wrapperCol="{span: 18, offset: 2}">
              </a-form-item>
            </a-col>
          </div>
          <span style="float: right; margin-top: 3px;">
            <a-button type="primary" @click="search">查询</a-button>
            <a-button style="margin-left: 8px" @click="reset">重置</a-button>
             <a @click="toggleAdvanced" style="margin-left: 8px">
              {{advanced ? '收起' : '展开'}}
              <a-icon :type="advanced ? 'up' : 'down'" />
            </a>
          </span>
        </a-row>
      </a-form>
    </div>
    <div>
      <div class="operator">
        <a-button v-hasPermission="'auto-bill/parm-bill:add'" type="primary" ghost @click="add">新增</a-button>
        <a-button v-hasPermission="'auto-bill/parm-bill:delete'" @click="batchDelete">删除</a-button>
        <a-dropdown v-hasPermission="'auto-bill/parm-bill:export'">
          <a-menu slot="overlay">
            <a-menu-item key="export-data" @click="exportExcel">导出Excel</a-menu-item>
          </a-menu>
          <a-button>
            更多操作 <a-icon type="down" />
          </a-button>
        </a-dropdown>
      </div>
      <!-- 表格区域 -->
      <a-table ref="TableInfo"
               :columns="columns"
               :dataSource="dataSource"
               :pagination="pagination"
               :loading="loading"
               :rowSelection="{selectedRowKeys: selectedRowKeys, onChange: onSelectChange}"
               @change="handleTableChange"
               :scroll="{ x: 900 }">
        <template slot="remark" slot-scope="text, record">
          <a-popover placement="topLeft">
            <template slot="content">
              <div style="max-width: 200px">{{text}}</div>
            </template>
            <p style="width: 200px;margin-bottom: 0">{{text}}</p>
          </a-popover>
        </template>
        <template slot="operation" slot-scope="text, record">
          <a-icon v-hasPermission="'auto-bill/parm-bill:update'" type="setting" theme="twoTone" twoToneColor="#4a9ff5" @click="edit(record)" title="修改"></a-icon>
          <a-badge v-hasNoPermission="'auto-bill/parm-bill:update'" status="warning" text="无权限"></a-badge>
        </template>
      </a-table>
    </div>
    <!-- 新增字典 -->
    <parm-bill-add
      @close="handleParmBillAddClose"
      @success="handleParmBillAddSuccess"
     :parmBillAddVisiable="parmBillAddVisiable">
    </parm-bill-add>
    <!-- 修改字典 -->
    <parm-bill-edit
      ref="parmBillEdit"
      @close="handleParmBillEditClose"
      @success="handleParmBillEditSuccess"
      :parmBillEditVisiable="parmBillEditVisiable">
    </parm-bill-edit>
  </a-card>
</template>

<script>

import ParmBillAdd from './ParmBillAdd'
import ParmBillEdit from './ParmBillEdit'
export default {
  name: 'ParmBill',
  components: {ParmBillEdit, ParmBillAdd},
  data () {
    return {
      advanced: false,
      dataSource: [],
      selectedRowKeys: [],
      paginationInfo: null,
      pagination: {
        pageSizeOptions: ['10', '20', '30', '40', '100'],
        defaultCurrent: 1,
        defaultPageSize: 10,
        showQuickJumper: true,
        showSizeChanger: true,
        showTotal: (total, range) => `显示 ${range[0]} ~ ${range[1]} 条记录，共 ${total} 条记录`
      },
      queryParams: {},
      parmBillAddVisiable: false,
      parmBillEditVisiable: false,
      loading: false
    }
  },
  computed: {
    columns () {
      return [{
        title: '创建人',
        dataIndex: 'userName',
        width: 130,
        fixed: 'left'
      }, {
        title: '网管',
        dataIndex: 'nmName',
        width: 150
      }, {
        title: '派单分组',
        dataIndex: 'fgbiName',
        width: 230
      }, {
        title: '派单名',
        dataIndex: 'pbilName',
        width: 400
      }, /*, {
        title: '派单描述',
        dataIndex: 'pbilDesc',
        width: 230
      } */ {
        title: '开关状态',
        dataIndex: 'pbilSwStat',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="red">关</a-tag>
            case 1:
              return <a-tag color="cyan">开</a-tag>
            default:
              return text
          }
        }
      }, {
        title: '审核状态',
        dataIndex: 'auditStat',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="red">初始</a-tag>
            case 1:
              return <a-tag color="red">二级</a-tag>
            case 2:
              return <a-tag color="red">三级</a-tag>
            case 3:
              return <a-tag color="cyan">生效</a-tag>
            default:
              return text
          }
        }
      }, {
        title: '匹配层次',
        dataIndex: 'pbilLevel',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="cyan">首层</a-tag>
            case 1:
              return <a-tag color="cyan">二层</a-tag>
            case 2:
              return <a-tag color="cyan">三层</a-tag>
            case 3:
              return <a-tag color="cyan">四层</a-tag>
            default:
              return text
          }
        }
      },
      /*, {
        title: '预处理取消',
        dataIndex: 'pbilIsRevokable',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="red">否</a-tag>
            case 1:
              return <a-tag color="cyan">是</a-tag>
            default:
              return text
          }
        }
      }, {
        title: '忽略恢复',
        dataIndex: 'pbilIsIgnoreCleared',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="red">否</a-tag>
            case 1:
              return <a-tag color="cyan">是</a-tag>
            default:
              return text
          }
        }
      } */
      {
        title: '次日补派',
        dataIndex: 'pbilIsRebill',
        customRender: (text, row, index) => {
          switch (text) {
            case 0:
              return <a-tag color="red">否</a-tag>
            case 1:
              return <a-tag color="cyan">是</a-tag>
            default:
              return text
          }
        }
      }, {
        title: '操作',
        dataIndex: 'operation',
        scopedSlots: { customRender: 'operation' },
        fixed: 'right',
        width: 100
      }]
    }
  },
  mounted () {
    this.fetch()
  },
  methods: {
    onSelectChange (selectedRowKeys) {
      this.selectedRowKeys = selectedRowKeys
    },
    toggleAdvanced () {
      this.advanced = !this.advanced
      if (!this.advanced) {
        this.queryParams.fieldName = ''
      }
    },
    handleParmBillAddSuccess () {
      this.parmBillAddVisiable = false
      this.$message.success('新增字典成功')
      this.search()
    },
    handleParmBillAddClose () {
      this.parmBillAddVisiable = false
    },
    add () {
      this.parmBillAddVisiable = true
    },
    handleParmBillEditSuccess () {
      this.parmBillEditVisiable = false
      this.$message.success('修改字典成功')
      this.search()
    },
    handleParmBillEditClose () {
      this.parmBillEditVisiable = false
    },
    edit (record) {
      this.$refs.parmBillEdit.setFormValues(record)
      this.parmBillEditVisiable = true
    },
    batchDelete () {
      if (!this.selectedRowKeys.length) {
        this.$message.warning('请选择需要删除的记录')
        return
      }
      let that = this
      this.$confirm({
        title: '确定删除所选中的记录?',
        content: '当您点击确定按钮后，这些记录将会被彻底删除',
        centered: true,
        onOk () {
          let parmBillIds = []
          for (let key of that.selectedRowKeys) {
            parmBillIds.push(that.dataSource[key].parmBillId)
          }
          that.$delete('auto-bill/parm-bill/' + parmBillIds.join(',')).then(() => {
            that.$message.success('删除成功')
            that.selectedRowKeys = []
            that.search()
          })
        },
        onCancel () {
          that.selectedRowKeys = []
        }
      })
    },
    exportExcel () {
      this.$export('parmBill/excel', {
        ...this.queryParams
      })
    },
    search () {
      this.fetch({
        ...this.queryParams
      })
    },
    reset () {
      // 取消选中
      this.selectedRowKeys = []
      // 重置分页
      this.$refs.TableInfo.pagination.current = this.pagination.defaultCurrent
      if (this.paginationInfo) {
        this.paginationInfo.current = this.pagination.defaultCurrent
        this.paginationInfo.pageSize = this.pagination.defaultPageSize
      }
      this.paginationInfo = null
      // 重置查询参数
      this.queryParams = {}
      this.fetch()
    },
    handleTableChange (pagination, filters, sorter) {
      this.paginationInfo = pagination
      this.fetch({
        ...this.queryParams
      })
    },
    fetch (params = {}) {
      this.loading = true
      if (this.paginationInfo) {
        // 如果分页信息不为空，则设置表格当前第几页，每页条数，并设置查询分页参数
        this.$refs.TableInfo.pagination.current = this.paginationInfo.current
        this.$refs.TableInfo.pagination.pageSize = this.paginationInfo.pageSize
        params.pageSize = this.paginationInfo.pageSize
        params.pageNum = this.paginationInfo.current
      } else {
        // 如果分页信息为空，则设置为默认值
        params.pageSize = this.pagination.defaultPageSize
        params.pageNum = this.pagination.defaultCurrent
      }
      this.$get('auto-bill/parm-bill', {
        ...params
      }).then((r) => {
        let data = r.data
        const pagination = { ...this.pagination }
        pagination.total = data.total
        this.loading = false
        this.dataSource = data.rows
        this.pagination = pagination
      })
    }
  }
}
</script>

<style lang="less" scoped>
@import "../../../../static/less/Common";
</style>
