<template>
  <div style="padding: 10px">
    <div style="margin: 10px 0;">
      <!--    功能区域-->
      <el-button type="primary" round v-on:click="add">新增</el-button>
      <!-- <el-button type="success" round>导入</el-button>
      <el-button type="success" round>导出</el-button> -->
      <!--    搜索区域-->
      <el-button type="primary" icon="el-icon-search" style="margin-outside: 10px; float: right" @click="load()">搜索</el-button>
      <el-input v-model="search" @keydown.enter.native="load()" placeholder="请输入你要搜索的商品ID" style="width: 20%; float: right" clearable></el-input>
    </div>

    <!--    表格区域-->
    <el-table
        :data="tableData" border style="width: 100%">
      <el-table-column
          prop="itemId" label="ID" sortable>
      </el-table-column>
      <el-table-column align="center"
          label="描述">
        <template #default="scope">
          <el-button type="primary" style="margin-left:5px" @click="handleLook(scope.row)">查看</el-button>
        </template>
      </el-table-column>
      <el-table-column
          prop="createTime"
          label="创建时间"></el-table-column>
      <el-table-column
          prop="updateTime"
          label="更新时间"></el-table-column>
      <!--     操作区域-->
      <el-table-column fixed="right" label="操作" align = "center" width="150">
        <template #default="scope">
          <!--          这里scope.row传入直接是传入一行的数据对象，可以使用row.username取出用户名的-->
          <el-button v-on:click="editeClick(scope.row)" type="primary" size="small">编辑</el-button>
          <el-popconfirm title="确定要删除这个商品吗？" @confirm="deleteClick(scope.row.itemId)" style="margin-left: 10px">
            <template #reference>
              <el-button type="danger" size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>


    <div>
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[5, 10,  20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>

      <!--      新增的框-->
      <el-dialog title="新增/修改商品详情" :visible.sync="dialogVisible" width="60%">
        <el-form :model="form" label-width="120px">
          <el-form-item v-if="id_judge" label="商品ID：">
            <el-input v-model="form.itemId" style="width: 80%"></el-input>
          </el-form-item>
          <div id="div1"></div>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogVisible = false,save()">确 定</el-button>
        </span>
      </el-dialog>


      <el-dialog title="详情" :visible.sync="vis" width="55%">
        <el-card>
          <div v-html="detail.itemDetail" style="min-height: 100px"></div>
        </el-card>
      </el-dialog>

    </div>
  </div>
</template>

import request from "../utils/request";
<script>
import request from "@/utils/request";
import E from 'wangeditor';

let editor;
export default {
  name: "Description",
  data() {
    return {
      // 控制是否显示ID
      id_judge: true,
      form: {},
      dialogVisible: false,
      dialogVisible1: false,
      total: 10,
      search: '',
      currentPage: 1,
      tableData: [],
      pageSize: 10,
      size: '',
      vis: false,
      detail: {},
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      document.title = "商品详情管理";
      request.get("/itemDetail/getAll", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add() {
      this.id_judge = true;
      this.dialogVisible = true;
      this.form = {};
      if (!editor) {
        this.$nextTick(() => {
          editor = new E('#div1')
          editor.txt.clear()
          editor.config.uploadImgServer = '/api/files/editor/upload'
          editor.config.uploadFileName = "file"
          editor.create()
        })
      }
      if (editor) {
        editor.txt.clear()
      }
    },
    save() {
      this.form.itemDetail = editor.txt.html();
      if (!this.id_judge) {
        request.put("/itemDetail", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "修改成功"
            })
          } else {
            this.$message({
              type: "error",
              message: "修改失败"
            })
          }
        })
        this.load();
        this.dialogVisible = false;
      } else {
        request.post("/itemDetail", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
            })
          } else {
            this.$message({
              type: "error",
              message: "新增失败"
            })
          }

        })
        this.load();
        this.dialogVisible = false;
      }
    },

    editeClick(row) {
      this.id_judge = false;
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      if (!editor) {
        this.$nextTick(() => {
              editor = new E('#div1')
              editor.config.uploadImgServer = '/api/files/editor/upload'
              editor.config.uploadFileName = "file"
              editor.create()
              editor.txt.html(row.itemDetail)
            }
        )
      }
      if (editor) editor.txt.html(row.itemDetail)
    },

    deleteClick(id) {
      request.delete("/itemDetail/" + id).then(res => {
        console.log(id)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "删除成功"
          })
        } else {
          this.$message({
            type: "error",
            message: "删除失败"
          })
        }
      })
      this.load()
    },
    handleSizeChange(pageSize) {
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(val) {
      this.currentPage = val
      this.load()
      console.log(`当前页: ${val}`);
    },


    handleLook(value) {
      this.detail = value
      this.vis = true
    }
  }
}
</script>