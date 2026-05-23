<template>
  <div class="manage-page">
    <!-- 操作栏 -->
    <div class="action-bar">
      <div class="action-left">
        <el-button type="primary" @click="add">
          <i class="el-icon-plus"></i> 新增商品
        </el-button>
      </div>
      <div class="action-right">
        <el-input
          v-model="search"
          placeholder="搜索商品卖点..."
          clearable
          class="search-input"
          @keydown.enter.native="goSearch"
        >
          <template #prefix>
            <i class="el-icon-search"></i>
          </template>
        </el-input>
        <el-button type="primary" @click="goSearch">搜索</el-button>
      </div>
    </div>

    <!-- 表格区域 -->
    <div class="table-container">
      <el-table
        :data="tableData"
        stripe
        v-loading="loading"
        :header-cell-style="{ background: '#fafafa', color: '#333', fontWeight: '600' }"
      >
        <el-table-column prop="id" label="商品ID" width="80" sortable align="center"></el-table-column>
        <el-table-column prop="title" label="商品标题" min-width="150"></el-table-column>
        <el-table-column prop="sellPoint" label="卖点" show-overflow-tooltip min-width="180"></el-table-column>
        <el-table-column label="价格" width="100" align="center">
          <template #default="scope">
            <span class="price-text">¥{{ scope.row.price }}</span>
          </template>
        </el-table-column>
        <el-table-column label="商品图片" width="120" align="center">
          <template #default="scope">
            <el-image
              class="product-thumb"
              :src="scope.row.image"
              :preview-src-list="[scope.row.image]"
              fit="cover"
            ></el-image>
          </template>
        </el-table-column>
        <el-table-column label="库存" width="100" align="center">
          <template #default="scope">
            <el-tag v-if="scope.row.stock > 10" type="success" size="small">{{ scope.row.stock }}</el-tag>
            <el-tag v-else-if="scope.row.stock > 0" type="warning" size="small">{{ scope.row.stock }}</el-tag>
            <el-tag v-else type="danger" size="small">缺货</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="created" sortable label="创建时间" width="160" align="center"></el-table-column>
        <el-table-column prop="updated" sortable label="更新时间" width="160" align="center"></el-table-column>
        <el-table-column fixed="right" label="操作" align="center" width="140">
          <template #default="scope">
            <div class="action-links">
              <el-button type="text" size="mini" @click="editeClick(scope.row)">
                编辑
              </el-button>
              <el-divider direction="vertical"></el-divider>
              <el-popconfirm title="确定要删除这个商品吗？" @confirm="deleteClick(scope.row.id)">
                <template #reference>
                  <el-button type="text" size="mini" class="danger-link">删除</el-button>
                </template>
              </el-popconfirm>
            </div>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页 -->
    <div class="pagination-wrapper">
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
      :title="form.id ? '编辑商品' : '新增商品'"
      :visible.sync="dialogVisible"
      width="550px"
      class="manage-dialog"
    >
      <el-form :model="form" label-width="100px" class="manage-form">
        <el-form-item label="商品标题">
          <el-input v-model="form.title" placeholder="请输入商品标题"></el-input>
        </el-form-item>
        <el-form-item label="价格">
          <el-input v-model="form.price" placeholder="请输入价格" type="number"></el-input>
        </el-form-item>
        <el-form-item label="库存数量">
          <el-input v-model="form.stock" placeholder="请输入库存数量" type="number"></el-input>
        </el-form-item>
        <el-form-item label="商品类目">
          <el-select v-model="form.cid" placeholder="请选择类目" style="width: 100%">
            <el-option
              v-for="(item, index) in ['童书','科技','小说','文学','青春文学','艺术','成功励志','管理','历史','哲学']"
              :key="item"
              :label="item"
              :value="index + 1"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品状态">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">正常</el-radio>
            <el-radio :label="2">下架</el-radio>
            <el-radio :label="3">删除</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="卖点">
          <el-input type="textarea" v-model="form.sellPoint" placeholder="请输入商品卖点" :rows="3"></el-input>
        </el-form-item>
        <el-form-item label="商品图片">
          <el-upload
            class="avatar-uploader"
            action="/api/files/upload"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload"
          >
            <img v-if="form.image" :src="form.image" class="avatar" alt="商品图片">
            <div v-else class="avatar-placeholder">
              <i class="el-icon-plus"></i>
              <span>上传图片</span>
            </div>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

export default {
  name: 'ItemView',
  components: {},
  created() {
    document.title = '商品管理';
    this.loadData();
  },
  methods: {
    // 搜索功能
    goSearch:function (){
      this.loadData();
    },
    // 加载表格数据,Get请求，Get请求不能直接传对象，只有Post可以直接传对象进去
    loadData() {
      this.loading = true;
      request.get("/item", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log(res);
        this.tableData = res.data.records;
        this.totalNumber = res.data.total;
        this.loading = false;
      })
    },
    // 打开表单栏
    add() {
      // 先清空表单
      this.form = {};
      // 再打开表单
      this.dialogVisible = true;
    },
    // 点击表单的确定按钮，保存数据到后台，Post请求和Put请求
    save() {
      // alert("马上保存/修改~");  使用下面那个elementUI的弹出框
      this.$message({
        type: "info",
        message: "马上保存/修改~"
      })

      if (this.form.id) {
        //   有ID就更新
        request.put("/item",this.form).then(res =>{
          console.log(res);
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "更新成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        })
      }else {
        // 没有就新增
        // 这里不用添加/api，在request.js中我们已经添加了baseurl为api了，然后在vue.config.js中会被拦截
        request.post("/item", this.form).then(res => {
          console.log(res);
          if (res.code === '0'){
            this.$message({
              type: "success",
              message: "新增成功"
            })
          }else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
        });
      }
      // alert("保存/修改成功");  需要检查之后再看是否成功
      // 更新tableData的数据
      this.loadData();
      this.dialogVisible = false;
    },
    // 修改行数据
    editeClick(row) {
      // 将数据深拷贝过来，避免浅拷贝的修改问题
      this.form = JSON.parse(JSON.stringify(row));
      this.dialogVisible = true;
    },
    // 删除数据
    deleteClick(id) {
      request.delete('/item', {
        params: {
          id : id
        }
      }).then(res=>{
        if (res.code === '0') {
          this.$message({
            type: "warning",
            message: "删除成功",
          })
        }else {
          this.$message({
            type: "error",
            message: res.msg,
          })
        }
      });
      // 更新数据
      this.loadData();
    },
    // 表单每页大小的改变，因为有了双向绑定，直接更新一下数据就好了
    handleSizeChange() {
      this.loadData();
    },
    // 改变当前页码
    handleCurrentChange: function () {
      this.loadData();
    },
    handleAvatarSuccess(res) {
      this.form.image = res.data;
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!');
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!');
      }
      return isJPG && isLt2M;
    }
  },
  data() {
    return {
      // 表单加载中~
      loading: true,
      //新建一个表单，用来储存新增商品和修改商品的数据
      form: {
      },
      // 增加框是否可见
      dialogVisible: false,
      // 总数据数
      totalNumber: 400,
      // 当前页码
      currentPage: 1,
      // 一页多少个
      pageSize: 5,
      // 输入框的数据
      search: '',
      // 表格的数据
      tableData: []
    }
  }
}
</script>
<style scoped>
.manage-page {
  padding: 20px;
}

/* 操作栏 */
.action-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding: 16px 20px;
  background: #fff;
  border-radius: var(--radius-md, 8px);
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

.action-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-input {
  width: 280px;
}

.search-input >>> .el-input__inner {
  border-radius: 20px;
  padding-left: 36px;
}

/* 表格容器 */
.table-container {
  background: #fff;
  border-radius: var(--radius-md, 8px);
  overflow: hidden;
  box-shadow: var(--shadow-sm, 0 1px 2px rgba(0,0,0,0.06));
}

/* 商品缩略图 */
.product-thumb {
  width: 80px;
  height: 80px;
  border-radius: var(--radius-sm, 4px);
  overflow: hidden;
}

/* 价格样式 */
.price-text {
  font-size: 16px;
  font-weight: 600;
  color: var(--primary-color, #ff5000);
  font-family: "DIN Alternate", "Helvetica Neue", Arial, sans-serif;
}

/* 表格操作按钮 */
.table-actions {
  display: flex;
  gap: 8px;
  justify-content: center;
  flex-wrap: nowrap;
}

.table-actions .el-button {
  padding: 5px 10px;
  font-size: 12px;
}

/* 文字链接操作按钮 */
.action-links {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0;
  white-space: nowrap;
}

.action-links .el-button--text {
  padding: 4px 8px;
  font-size: 13px;
  color: var(--primary-color, #ff5000);
}

.action-links .el-button--text:hover {
  color: var(--primary-light, #ff7433);
}

.action-links .danger-link {
  color: #f56c6c !important;
}

.action-links .danger-link:hover {
  color: #f78989 !important;
}

.action-links .el-divider--vertical {
  margin: 0 4px;
  height: 14px;
  background-color: #dcdfe6;
}

/* 分页 */
.pagination-wrapper {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

/* 弹窗样式 */
.manage-dialog >>> .el-dialog {
  border-radius: var(--radius-lg, 12px);
}

.manage-dialog >>> .el-dialog__header {
  border-bottom: 1px solid var(--border-color, #e8e8e8);
  padding: 16px 20px;
}

.manage-dialog >>> .el-dialog__title {
  font-size: 16px;
  font-weight: 600;
}

.manage-dialog >>> .el-dialog__body {
  padding: 24px 20px;
}

.manage-form .el-form-item {
  margin-bottom: 18px;
}

.manage-form >>> .el-input__inner {
  border-radius: var(--radius-sm, 4px);
}

.manage-form >>> .el-textarea__inner {
  border-radius: var(--radius-sm, 4px);
}

/* 图片上传 */
.avatar-uploader {
  border: 2px dashed var(--border-color, #e8e8e8);
  border-radius: var(--radius-md, 8px);
  cursor: pointer;
  overflow: hidden;
  transition: all 0.25s ease;
  width: 150px;
  height: 150px;
}

.avatar-uploader:hover {
  border-color: var(--primary-color, #ff5000);
}

.avatar {
  width: 150px;
  height: 150px;
  display: block;
  object-fit: cover;
}

.avatar-placeholder {
  width: 150px;
  height: 150px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--text-placeholder, #999);
  background: #fafafa;
}

.avatar-placeholder i {
  font-size: 28px;
  margin-bottom: 8px;
}

.avatar-placeholder span {
  font-size: 12px;
}
</style>