<template>
  <div class="address-page">
    <!-- 页面标题 -->
    <div class="page-header">
      <h2><i class="el-icon-location-outline"></i> 地址管理</h2>
      <el-button type="primary" size="small" @click="add">
        <i class="el-icon-plus"></i> 新增地址
      </el-button>
    </div>

    <!-- 表格区域 -->
    <div class="address-table">
      <el-table
        :data="tableData"
        v-loading="loading"
        :header-cell-style="{ background: '#fafafa', color: '#333', fontWeight: '600' }"
      >
        <el-table-column prop="addName" label="收货人" width="100" align="center">
          <template #default="scope">
            <span class="receiver-name">{{ scope.row.addName }}</span>
          </template>
        </el-table-column>

        <el-table-column prop="phone" label="手机号" width="130" align="center">
          <template #default="scope">
            <span class="phone-number">{{ scope.row.phone }}</span>
          </template>
        </el-table-column>

        <el-table-column prop="address" label="所在地区" width="200">
        </el-table-column>

        <el-table-column prop="addDetail" label="详细地址" min-width="250">
          <template #default="scope">
            <span class="address-detail">{{ scope.row.addDetail }}</span>
          </template>
        </el-table-column>

        <el-table-column fixed="right" label="操作" align="center" width="150">
          <template #default="scope">
            <div class="action-buttons">
              <el-button type="primary" size="mini" plain @click="editeClick(scope.row)">
                <i class="el-icon-edit"></i> 编辑
              </el-button>
              <el-popconfirm title="确定删除这个地址吗？" @confirm="deleteClick(scope.row.id)">
                <template #reference>
                  <el-button type="danger" size="mini" plain>
                    <i class="el-icon-delete"></i> 删除
                  </el-button>
                </template>
              </el-popconfirm>
            </div>
          </template>
        </el-table-column>
      </el-table>

      <!-- 空状态 -->
      <div v-if="!loading && tableData.length === 0" class="empty-state">
        <i class="el-icon-location-outline"></i>
        <p>暂无收货地址</p>
        <el-button type="primary" size="small" @click="add">添加地址</el-button>
      </div>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrapper" v-if="totalNumber > 0">
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-sizes="[5, 10, 20]"
        :page-size.sync="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="totalNumber"
      ></el-pagination>
    </div>

    <!-- 新增/编辑弹窗 -->
    <el-dialog
      :title="form.id ? '编辑地址' : '新增地址'"
      :visible.sync="dialogVisible"
      width="500px"
      class="address-dialog"
    >
      <el-form :model="form" label-width="90px" class="address-form">
        <el-form-item label="所在地区" required>
          <el-cascader
            v-model="form.address"
            :options="options"
            :placeholder="form.address || '请选择省/市/区'"
            filterable
            clearable
            style="width: 100%"
            @change="addressChoose"
          ></el-cascader>
        </el-form-item>

        <el-form-item label="详细地址" required>
          <el-input
            type="textarea"
            v-model="form.addDetail"
            :rows="3"
            placeholder="请输入详细地址，如道路、门牌号、小区、楼栋号等"
          ></el-input>
        </el-form-item>

        <el-form-item label="收货人" required>
          <el-input v-model="form.addName" placeholder="请输入收货人姓名">
            <template #prefix>
              <i class="el-icon-user"></i>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item label="手机号码" required>
          <el-input v-model="form.phone" placeholder="请输入11位手机号" maxlength="11">
            <template #prefix>
              <i class="el-icon-phone"></i>
            </template>
          </el-input>
        </el-form-item>
      </el-form>

      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";
import { pcaTextArr } from "element-china-area-data";

export default {
  name: "AddressManage",
  created() {
    document.title = "地址管理 - TJU网上书店";
    let str = sessionStorage.getItem("user") || "{}";
    this.user = JSON.parse(str);
    this.loadData();
  },
  data() {
    return {
      options: pcaTextArr,
      loading: true,
      form: {},
      dialogVisible: false,
      totalNumber: 0,
      currentPage: 1,
      pageSize: 5,
      search: '',
      tableData: [],
      user: {}
    }
  },
  methods: {
    loadData() {
      this.loading = true;
      request.get("/address", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          userId: this.user.id
        }
      }).then(res => {
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      });
    },
    add() {
      this.form = {};
      this.dialogVisible = true;
    },
    save() {
      if (!this.form.address || this.form.address.length < 3) {
        this.$message.warning("请选择所在地区");
        return;
      }
      if (!this.form.addDetail) {
        this.$message.warning("请输入详细地址");
        return;
      }
      if (!this.form.addName) {
        this.$message.warning("请输入收货人姓名");
        return;
      }
      if (!this.form.phone || this.form.phone.length !== 11) {
        this.$message.warning("请输入正确的11位手机号");
        return;
      }

      // 处理地址
      if (Array.isArray(this.form.address)) {
        this.form.address = this.form.address.join(" ");
      }
      this.form.userId = this.user.id;

      const request_method = this.form.id ? request.put : request.post;
      request_method("/address", this.form).then(res => {
        if (res.code === '0') {
          this.$message.success(this.form.id ? "修改成功" : "新增成功");
          this.dialogVisible = false;
          this.loadData();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    deleteClick(id) {
      request.delete('/address', {
        params: { id: id }
      }).then(res => {
        if (res.code === '0') {
          this.$message.success("删除成功");
          this.loadData();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    editeClick(row) {
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },
    addressChoose(value) {
      console.log("选中的地区", value);
    },
    handleSizeChange() {
      this.loadData();
    },
    handleCurrentChange() {
      this.loadData();
    },
  }
}
</script>

<style scoped>
.address-page {
  padding: 24px;
}

/* 页面标题 */
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--border-color, #e8e8e8);
}

.page-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: var(--text-primary, #333);
  margin: 0;
  display: flex;
  align-items: center;
  gap: 8px;
}

.page-header h2 i {
  color: var(--primary-color, #ff5000);
}

/* 表格 */
.address-table {
  background: #fff;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
}

.receiver-name {
  font-weight: 500;
  color: var(--text-primary, #333);
}

.phone-number {
  font-family: "DIN Alternate", monospace;
  color: var(--text-secondary, #666);
}

.address-detail {
  color: var(--text-secondary, #666);
  font-size: 13px;
}

/* 操作按钮 */
.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: center;
}

.action-buttons .el-button {
  padding: 5px 10px;
  font-size: 12px;
}

/* 空状态 */
.empty-state {
  text-align: center;
  padding: 60px 0;
  color: var(--text-placeholder, #999);
}

.empty-state i {
  font-size: 64px;
  margin-bottom: 16px;
  color: #ddd;
}

.empty-state p {
  font-size: 14px;
  margin: 0 0 20px 0;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 弹窗 */
.address-dialog >>> .el-dialog {
  border-radius: var(--radius-lg, 12px);
}

.address-dialog >>> .el-dialog__header {
  border-bottom: 1px solid var(--border-color, #e8e8e8);
  padding: 16px 20px;
}

.address-dialog >>> .el-dialog__title {
  font-size: 16px;
  font-weight: 600;
}

.address-dialog >>> .el-dialog__body {
  padding: 24px 20px;
}

.address-form .el-form-item {
  margin-bottom: 20px;
}

.address-form >>> .el-input__inner {
  border-radius: var(--radius-sm, 4px);
}

.address-form >>> .el-textarea__inner {
  border-radius: var(--radius-sm, 4px);
}
</style>
