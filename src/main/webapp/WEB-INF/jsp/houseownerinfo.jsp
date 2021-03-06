<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>业主信息</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body style="background-color: rgb(245,245,245)">
    <div class="container-fluid" id="app">
    	<div class="row" style="background-color: white;margin-top: 20px;padding-left: 10px;margin-bottom: 20px">
            <h1>业主信息</h1>
            <h5><a href="#" onclick="top.location.href ='/community/admin/adminback'">首页&nbsp;&nbsp;</a>/<span>&nbsp;&nbsp;业主信息管理&nbsp;&nbsp;/</span><span>&nbsp;&nbsp;业主信息</span></h5>
        </div>
        <div class="row" style="background-color: white;padding-left: 10px;margin-bottom: 20px;">
            <h4 data-toggle="collapse" href="#collapseExample">查询条件</h4><hr>
            <form id="collapseExample" class="form-inline collapse" style="padding-bottom: 25px;">
                <input type="text" class="form-control" id="likebuildnumber" placeholder="请输入楼栋编号">
                <input type="text" class="form-control" id="likehouseunit" placeholder="请输入单元号">
                <input type="text" class="form-control" id="likehousenumber" placeholder="请输入房间号">
                <input type="text" class="form-control" id="likeownername" placeholder="请输入业主姓名">
                <input type="text" class="form-control" id="likeownerphone" placeholder="请输入手机号">
                <button type="button" class="btn btn-default" @click="getownerinfolike()">查询</button>
            </form>
        </div>
    	<div class="row">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2" @click="add()">新增</button>
			<button type="button" class="btn btn-danger" @click="checkdelete()">批量删除</button>
			<span style="color: red;text-align: center;">注：新增业主的默认密码为000000</span>
		</div>
		<div class="row">
			<table class="table table-striped table-bordered table-hover text-center" style="background-color: white;">
				<thead>
					<tr>
						<th class="text-center">
							<input type="checkbox" v-model="checked" @click="checkedAll()">
						</th>
						<th class="text-center">序号</th>
						<th class="text-center">姓名</th>
						<th class="text-center">楼栋</th>
						<th class="text-center">单元</th>
						<th class="text-center">房间号</th>
						<th class="text-center">性别</th>
						<th class="text-center">电话</th>
						<th class="text-center">出生日期</th>
						<th class="text-center">身份证号</th>
						<th class="text-center">籍贯</th>
						<th class="text-center">工作单位</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(list,index) in listhouseownerinfo">
						<td>
							<input type="checkbox" v-model="arr" :value="list.ownerId">
						</td>
						<td>{{index+1}}</td>
						<td>{{list.ownerName}}</td>
						<td>{{list.buildingInfo.buildNumber}}</td>
						<td>{{list.houseInfo.houseUnit}}</td>
						<td>{{list.houseInfo.houseNumber}}</td>
						<td>{{list.ownerSex==1?'男':'女'}}</td>
						<td>{{list.ownerPhone}}</td>
						<td>{{list.ownerBirthday}}</td>
						<td>{{list.ownerIdCard}}</td>
						<td>{{list.ownerNativePlace}}</td>
						<td>{{list.ownerWorkPlace}}</td>
						<td>
							<button type="button" class="btn btn-primary btn-sm" data-toggle="modal"
                                data-target="#myModal1" @click="change(list.ownerId,list.ownerName,list.ownerSex,list.ownerPhone,
                                list.ownerBirthday,list.ownerIdCard,list.ownerNativePlace,list.ownerWorkPlace)">修改</button>
                            <button type="button" class="btn btn-danger btn-sm" @click="deleteowner(list.ownerId)">迁出</button>
						</td>
					</tr>
				</tbody>
			</table>
			<!--修改业主信息的模态框-->
			<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document" style="width: 32%;">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title text-center" id="myModalLabel">修改业主信息</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal">
								<div class="form-group">
									<label class="col-sm-3 control-label">姓名</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="ownername">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">性别</label>
									<div class="col-sm-9">
										<select required="required" class="form-control" id="ownersex">
											<option value="男">男</option>
											<option value="女">女</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">电话</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="ownerphone">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">出生日期</label>
									<div class="col-sm-9">
										<input id="ownerbirthday" class="form-control" type="text" onclick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d'})"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">身份证号</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="owneridcard">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">籍贯</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="ownernativeplace">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">工作单位</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="ownerworkplace">
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary" id="savechange" @click="savechange()">确定</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 新增业主信息的模态框 -->
			<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document" style="width: 32%;">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title text-center" id="myModalLabel">新增业主信息</h4>
						</div>
						<div class="modal-body">
							<form class="form-horizontal">
								<div class="form-group">
									<label class="col-sm-3 control-label">姓名</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="addownername">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">楼栋</label>
									<div class="col-sm-9">
										<select required="required" class="form-control" id="addbuildnumber" @click="gethavenullhousehouseunit()">
											<option v-for="list in listhavenullhousebuildnumber">{{list}}</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">单元</label>
									<div class="col-sm-9">
										<select required="required" class="form-control" id="addhouseunit" @click="getnullhousehousenumber()">
											<option v-for="list in listhouseunit">{{list}}</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">房间号</label>
									<div class="col-sm-9">
										<select required="required" class="form-control" id="addhousenumber">
											<option v-for="list in listhousenumber">{{list}}</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">性别</label>
									<div class="col-sm-9">
										<select required="required" class="form-control" id="addownersex">
											<option value="男">男</option>
											<option value="女">女</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">电话</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="addownerphone">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-3 control-label">出生日期</label>
									<div class="col-sm-9">
										<input id="addownerbirthday" class="form-control" type="text" onclick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d'})"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">身份证号</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="addowneridcard">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">籍贯</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="addownernativeplace">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">工作单位</label>
									<div class="col-sm-9">
										<input type="text" class="form-control" id="addownerworkplace">
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary" @click="saveaddownerinfo()" >确定</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="col-md-12" style="padding-top: 20px;">
					<h4>总记录数：{{total}}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总页数：{{pagetotal}}</h4>
				</div>
			</div>
			<div class="col-md-6 text-right">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li @click="firstpage()"><a style="cursor:pointer;"><span aria-hidden="true">首页</span></a></li>
						<li><a style="cursor:pointer;" @click="previous()"><span>上一页</span></a></li>
						
						<li v-for="n in pageRange" v-if="n==page&&state==1" class="active"><span>{{n}}</span></li>
						<li v-else-if="state==1" @click="tiaozhuan(n)"><a style="cursor:pointer;">{{n}}</a></li>
						<li v-for="n_like in pageRange" v-if="n_like==likepage&&state==0" class="active"><span>{{n_like}}</span></li>
						<li v-else-if="state==0" @click="tiaozhuan(n_like)"><a style="cursor:pointer;">{{n_like}}</a></li>
						
						<li><a style="cursor:pointer;" aria-label="Next" @click="next()"><span aria-hidden="true">下一页</span></a></li>
						<li @click="lastpage()"><a style="cursor:pointer;"><span aria-hidden="true">尾页</span></a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="../static/js/vue.min.js"></script>
    <script src="../static/datepicker/WdatePicker.js"></script>
    <script>
		var app = new Vue({
			el : '#app',
			data : {
				listhouseownerinfo:[],//所有业主信息
				changeid:0,
				oldownerphone:'',//业主原来的手机号
				listhavenullhousebuildnumber:[],//所有还有空房间的楼栋编号
				listhouseunit:[],//所属楼栋中还有空房间的单元号
				listhousenumber:[],//根据楼栋号,单元号查出的所有空房间的房间号
				checked:false,
				arr:[],
				page:1,//当前页
				size:6,//每页记录条数
				total:0,//记录总数
				pagetotal:0,//总页数
				begin:1,//起始页
				end:1,//显示的最大页
				pageRange:[],//页码显示的范围
				state:1,//1表示执行get方法，查询所有房间信息，0表示执行gethouseinfolike方法，模糊查询房间信息
				likepage:1,//当前页
				likesize:6//每页记录条数
			},
			mounted : function() {
				this.get();
			},
			methods : {
				get : function() {
					var page = this.page;
					var size = this.size;
					$.ajax({
						url : '/community/houseownerinfo/pagegetallhouseownerinfo',
						type : 'GET',
						dataType : 'JSON',
						data:{"page":page,"size":size},
						success : function(result) {
							app.listhouseownerinfo = result.rows;
							app.total = result.total;
							app.pagetotal=Math.ceil((app.total)/app.size);//向上取整
							if((app.page-1)%5==0){
								app.begin=app.page;
								app.end = app.page+4;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									if(current>app.pagetotal)break;
									app.pageRange[i]=current;
									current++;
								}
							}
							if(app.page%5==0){
								app.begin=app.page-4;
								app.end=app.page;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									app.pageRange[i]=current;
									current++;
								}
							}
						},
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//跳转到第一页，首页
				firstpage : function(){
					if(app.state==1){
						if(app.page==1){
							alert("已经是第一页了！");
						}else{
							app.page=1;
							app.get();
						}
					}else{
						if(app.likepage==1){
							alert("已经是第一页了！");
						}else{
							app.likepage=1;
							app.getownerinfolike();
						}
					}
				},
				//点击上一页
				previous : function(){
					if(app.state==1){
						if(app.page==1){
							alert("已经是第一页了！");
						}else{
							app.page -=1;
							app.get();
						}
					}else{
						if(app.likepage==1){
							alert("已经是第一页了！");
						}else{
							app.likepage-=1;
							app.getownerinfolike();
						}
					}
					
				},
				//跳转页面
				tiaozhuan : function(n){
					if(app.state==1){
						app.page=n;
						app.get();
					}else{
						app.likepage=n;
						app.getownerinfolike();
					}
				},
				//点击下一页
				next : function(){
					if(app.state==1){
						if(app.page==app.pagetotal){
							alert("已经是最后一页了！");	
						}else{
							app.page+=1;
							app.get();
						}
					}else{
						if(app.likepage==app.pagetotal){
							alert("已经是最后一页了！");
						}else{
							app.likepage+=1;
							app.getownerinfolike();
						}
					}
				},
				//跳转到最后一页，尾页
				lastpage : function(){
					if(app.state==1){
						if(app.page==app.pagetotal){
							alert("已经是最后一页了！");
						}else{
							app.page=app.pagetotal;
							if(app.page%5!=0&&(app.page-1)%5!=0){
								//跳转到最后一页，可能并不是完整的五个页码
								app.begin=(Math.floor(app.page/5))*5+1;//向下取整。例如：第七页，从第六页开始查询
								app.end=app.page;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									if(current>app.pagetotal)break;
									app.pageRange[i]=current;
									current++;
								}
							}
							app.get();
						}
					}else{
						if(app.likepage==app.pagetotal){
							alert("已经是最后一页了！");
						}else{
							app.likepage=app.pagetotal;
							if(app.likepage%5!=0&&(app.likepage-1)%5!=0){
								//跳转到最后一页，可能并不是完整的五个页码
								app.begin=(Math.floor(app.likepage/5))*5+1;//例如：第七页，从第六页开始查询
								app.end=app.likepage;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									if(current>app.pagetotal)break;
									app.pageRange[i]=current;
									current++;
								}
							}
							app.getownerinfolike();
						}
					}
				},
				//点击修改按钮，显示业主信息在模态框中
				change:function(ownerId,ownerName,ownerSex,ownerPhone,ownerBirthday,ownerIdCard,ownerNativePlace,ownerWorkPlace){
					app.changeid=ownerId;
					app.oldownerphone=ownerPhone;
					$("#ownername").val(ownerName);
					$("#ownersex").val(ownerSex==1?'男':'女');
					$("#ownerphone").val(ownerPhone);
					$("#ownerbirthday").val(ownerBirthday);
					$("#owneridcard").val(ownerIdCard);
					$("#ownernativeplace").val(ownerNativePlace);
					$("#ownerworkplace").val(ownerWorkPlace);
				},
				savechange:function(){
					var ownerId=app.changeid;
					var oldownerPhone= app.oldownerphone;
					var ownerName=$("#ownername").val();
					var ownerSex=$("#ownersex").val()=='男'?1:0;
					var ownerPhone=$("#ownerphone").val();
					var ownerBirthday=$("#ownerbirthday").val();
					var ownerIdCard=$("#owneridcard").val();
					var ownerNativePlace=$("#ownernativeplace").val();
					var ownerWorkPlace=$("#ownerworkplace").val();
					if(ownerName==''||ownerPhone==''||ownerBirthday==''||ownerIdCard==''||ownerNativePlace==''||ownerWorkPlace==''){
						alert("请将信息填写完整！");
					}else{
						$.ajax({
							url:'/community/houseownerinfo/updatehouseownerinfo',
							type:'POST',
							dataType:'JSON',
							data:{"oldownerPhone":oldownerPhone,"ownerId":ownerId,"ownerName":ownerName,"ownerSex":ownerSex,"ownerPhone":ownerPhone,"ownerBirthday":ownerBirthday,
								"ownerIdCard":ownerIdCard,"ownerNativePlace":ownerNativePlace,"ownerWorkPlace":ownerWorkPlace},
							success : function(result) {
								alert(result.msg);
								app.get();
							}
						});
					}
				},
				//点击新增按钮，查询所有楼栋号，所有房间号
				add:function(){
					//获取所有还有空房间的楼栋编号
					$.ajax({
						url : '/community/houseownerinfo/getallhavenullhousebuildnumber',
						type : 'GET',
						dataType : 'JSON',
						success : function(result) {
							app.listhavenullhousebuildnumber = result;
							//点击新增按钮时，同时查询默认显示的楼号所属的还有空房间的单元号
							var buildNumber=result[0];
							$.ajax({
								url : '/community/houseownerinfo/getallhavenullhousehouseunit',
								type : 'GET',
								dataType : 'JSON',
								data:{"buildNumber":buildNumber},
								success : function(result) {
									app.listhouseunit = result;
									var houseUnit = result[0];
									//点击新增按钮时，根据默认显示的楼栋号，单元号查询所有空房间的房间号
									$.ajax({
										url : '/community/houseownerinfo/getallnullhousehousenumber',
										type : 'GET',
										dataType : 'JSON',
										data:{"buildNumber":buildNumber,"houseUnit":houseUnit},
										success : function(result) {
											app.listhousenumber = result;
										},
										error : function() {
											console.log("请求失败处理");
										}
									});
								},
								error : function() {
									console.log("请求失败处理");
								}
							});
							
						},
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//点击楼号下拉框时同步更新单元号下拉框里的内容
				gethavenullhousehouseunit:function(){
					//根据楼栋号，获取还有空房间的单元号
					var buildNumber=$("#addbuildnumber").val();
					$.ajax({
						url : '/community/houseownerinfo/getallhavenullhousehouseunit',
						type : 'GET',
						dataType : 'JSON',
						data:{"buildNumber":buildNumber},
						success : function(result) {
							app.listhouseunit = result;
							var houseUnit=$("#addhouseunit").val();
							$.ajax({
								url : '/community/houseownerinfo/getallnullhousehousenumber',
								type : 'GET',
								dataType : 'JSON',
								data:{"buildNumber":buildNumber,"houseUnit":houseUnit},
								success : function(result) {
									app.listhousenumber = result;
								},
								error : function() {
									console.log("请求失败处理");
								}
							});
						},
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//点击单元号下拉框，根据默认显示的楼栋号，单元号查询所有空房间的房间号
				getnullhousehousenumber : function(){
					var buildNumber=$("#addbuildnumber").val();
					var houseUnit=$("#addhouseunit").val();
					$.ajax({
						url : '/community/houseownerinfo/getallnullhousehousenumber',
						type : 'GET',
						dataType : 'JSON',
						data:{"buildNumber":buildNumber,"houseUnit":houseUnit},
						success : function(result) {
							app.listhousenumber = result;
						},
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//确定新增的业主信息
				saveaddownerinfo:function(){
					var ownerName=$("#addownername").val();
					var	buildNumber = $("#addbuildnumber").val();
					var houseUnit = $("#addhouseunit").val();
					var houseNumber=$("#addhousenumber").val();
					var ownerSex=$("#addownersex").val()=='男'?1:0;
					var ownerPhone=$("#addownerphone").val();
					var ownerBirthday=$("#addownerbirthday").val();
					var ownerIdCard=$("#addowneridcard").val();
					var ownerNativePlace=$("#addownernativeplace").val();
					var ownerWorkPlace=$("#addownerworkplace").val();
					if(ownerName==''||buildNumber==''||houseUnit==''||houseNumber==''||ownerPhone==''||ownerBirthday==''||ownerIdCard==''||ownerNativePlace==''||ownerWorkPlace==''){
						alert("请将信息填写完整！");
					}else{
						$.ajax({
							url : '/community/houseownerinfo/inserthouseownerinfo',
							type : 'POST',
							dataType : 'JSON',
							data:{"ownerName":ownerName,"buildNumber":buildNumber,"houseUnit":houseUnit,"houseNumber":houseNumber,"ownerSex":ownerSex,"ownerPhone":ownerPhone,"ownerBirthday":ownerBirthday,
								"ownerIdCard":ownerIdCard,"ownerNativePlace":ownerNativePlace,"ownerWorkPlace":ownerWorkPlace},
							success : function(result) {
								alert(result.msg);
								app.get();
							},
							error : function() {
								console.log("请求失败处理");
							}
						});
					}
				},
				//业主迁出
				deleteowner:function(ownerId){
					$.ajax({
						url : '/community/houseownerinfo/deleteowner',
						type : 'POST',
						dataType : 'JSON',
						data:{"ownerId":ownerId},
						success : function(result) {
							alert(result.msg);
							app.get();
						},
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//模糊查询业主信息
				getownerinfolike : function(){
					app.state=0;
					var buildNumber = $("#likebuildnumber").val();
					var houseUnit = $("#likehouseunit").val();
					var houseNumber = $("#likehousenumber").val();
					var ownerName = $("#likeownername").val();
					var ownerPhone = $("#likeownerphone").val();
					var page = this.likepage;
					var size = this.likesize;
					$.ajax({
						url:'/community/houseownerinfo/gethouseownerinfolike',
						type:'POST',
						dataType:'JSON',
						data:{"buildNumber":"%"+buildNumber+"%","houseUnit":"%"+houseUnit+"%","houseNumber":"%"+houseNumber+"%",
							"ownerName":"%"+ownerName+"%","ownerPhone":"%"+ownerPhone+"%","page":page,"size":size},
						success : function(result) {
							app.listhouseownerinfo = result.rows;
							app.total = result.total;
							app.pagetotal=Math.ceil(app.total/app.likesize);//向上取整
							if((app.likepage-1)%5==0){
								app.begin=app.likepage;
								app.end = app.likepage+4;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									if(current>app.pagetotal)break;
									app.pageRange[i]=current;
									current++;
								}
							}
							if(app.likepage%5==0){
								app.begin=app.likepage-4;
								app.end=app.likepage;
								var current=app.begin;
								app.pageRange=[];
								for(var i=0;i<=app.end-app.begin;i++){
									app.pageRange[i]=current;
									current++;
								}
							}
						}
					});
				},
				checkedAll : function(){
                    if(this.checked){//实现反选
                        this.arr=[];
                    }else{//实现全选
                        this.arr=[];
                        this.listhouseownerinfo.forEach( (item) => {
                            this.arr.push(item.ownerId);
                        })
                    }
                },
                //批量删除
                checkdelete : function(){
                	var listownerId= app.arr;
                	if(listownerId==''){
                		alert("请选择要删除的项目！");
                	}else{
                		$.ajax({
    						type:'POST',
    						dataType:'JSON',
    						url:'/community/houseownerinfo/checkdelete',
    						contentType: "application/json;charset=utf-8",
    						data:JSON.stringify(listownerId),
    						success:function(result){
    							alert(result.msg);
    							app.get();
    						}
    					});
                	}
                }
			},
			watch:{//深度watcher
                arr:{
                    handler:function(val,oldval){
                        if(this.arr.length==this.listhouseownerinfo.length){
                            this.checked=true;
                        }else{
                            this.checked=false;
                        }
                    },
                    deep:true
                }
            }
		});
	</script>
  </body>
</html>