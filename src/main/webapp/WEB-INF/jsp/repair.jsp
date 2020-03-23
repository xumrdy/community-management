<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>报修信息</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body style="background-color: rgb(245,245,245)">
    <div class="container-fluid" id="app">
		<div class="row">
			<div>
				<h1 style="text-align: center;">报修信息</h1>
			</div>
			<table class="table table-bordered table-hover text-center" style="background-color: white;">
				<thead>
					<tr>
						<th>
							<input type="checkbox" value="">
						</th>
						<th class="col-md-1 text-center">序号</th>
						<th class="col-md-1 text-center">报修人</th>
						<th class="col-md-1 text-center">房间号</th>
						<th class="col-md-1 text-center">手机号</th>
						<th class="col-md-1 text-center">报修物品</th>
						<th class="col-md-1 text-center">报修时间</th>
						<th class="col-md-1 text-center">报修原因</th>
						<th class="col-md-1 text-center">状态</th>
						<th class="col-md-1 text-center">受理人</th>
						<th class="col-md-1 text-center">解决时间</th>
						<th class="col-md-2 text-center">操作</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="(list,index) in listrepairinfo">
						<td>
							<input type="checkbox" value="">
						</td>
						<td>{{index+1}}</td>
						<td>{{list.houseOwner.ownerName}}</td>
						<td>{{list.houseOwner.houseInfo.houseNumber}}</td>
						<td>{{list.houseOwner.ownerPhone}}</td>
						<td>{{list.repairGoods}}</td>
						<td>{{list.repairTime}}</td>
						<td>{{list.repairReason}}</td>
						<td>{{list.repairState==0?'未受理':(list.repairState==1?'已受理':'已解决')}}</td>
						<td>{{list.admin==null?'':list.admin.adminName}}</td>
						<td>{{list.repairSettleTime==null?'':list.repairSettleTime}}</td>
						<td>
							<button type="button" class="btn btn-primary btn-sm" @click="Acceptance(list.repairId)" v-if="list.repairState==0">受理</button>
							<button type="button" class="btn btn-primary btn-sm" @click="Acceptance(list.repairId)" disabled="disabled" v-else>受理</button>
                            <button type="button" class="btn btn-success btn-sm" @click="settled(list.repairId)" v-if="list.repairState==1">已解决</button>
                            <button type="button" class="btn btn-success btn-sm" @click="settled(list.repairId)" disabled="disabled" v-else>已解决</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
    <script src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
    <script>
		var app = new Vue({
			el : '#app',
			data : {
				listrepairinfo:[],//所有家庭成员信息
			},
			mounted : function() {
				this.get();
			},
			methods : {
				get : function() {
					$.ajax({
						url : '/community/repairinfo/getallrepairinfo',
						type : 'GET',
						dataType : 'JSON',
						success : function(result) {
							app.listrepairinfo = result;
						},							
						error : function() {
							console.log("请求失败处理");
						}
					});
				},
				//受理报修
    			Acceptance:function(repairId){
    				$.ajax({
    					url:'/community/repairinfo/acceptance',
    					type:'POST',
    					dataType:'JSON',
    					data:{"repairId":repairId},
    					success:function(result){
    						alert(result.msg);
    						app.get();
    					},
    					error:function(){
    						console.log("请求失败处理");
    					}
    				});
    			},
    			//报修已解决
    			settled:function(repairId){
    				$.ajax({
    					url:'/community/repairinfo/settled',
    					type:'POST',
    					dataType:'JSON',
    					data:{"repairId":repairId},
    					success:function(result){
    						alert(result.msg);
    						app.get();
    					},
    					error:function(){
    						console.log("请求失败处理");
    					}
    				});
    			}
			}
		});
	</script>
  </body>
</html>