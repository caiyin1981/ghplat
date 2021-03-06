<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人主页</title>
<base href="/ghplat/" />
<script src="/ghplat/front/js/jquery-1.8.2.min.js" type="text/javascript"></script>
<script type="text/javascript" src="admin/js/xheditor-1.2.2.min.js"></script>
<script type="text/javascript" src="admin/js/zh-cn.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($('#typeFlag').val()==''&&$('#typeFlag').val()!='1'){
		changeDiv('passwordDiv',$('#passwdbtn'));
	}
	var uesFlag = $('#uesFlag').val(); var flag2 = uesFlag.substring(1,2);
	if(flag2=='1'){
		$('.imprtDataDiv').show();
	}else{
		$('.priceclassspan').html(parseInt($('.priceclassspan').html())*1.3);
	}
	$('.elem1').xheditor({ 
        upImgUrl: 'upploadImg', upImgExt: 'jpg,jpeg,gif,png'
    });  
})
function gostep2(){
	var pcode = $('.pcode').val();
	var mobile = $('.pmobile').val();
	if(mobile!=mobileStr){
		$('.pmobileMsg').html('手机号不对');
		$('.pmobileMsg').show();
		return;
	}
	if(regCode==pcode){
		$('.stepImage').attr('src','front/images/step02.png');
		$('.step').hide();
		$('.step02').show();
	}else{
		$('.pcodeMsg').show();
	}
}
function gostep3(){
	var ppsd = $('.ppassword').val();
	var prpsd = $('.rppassword').val();
	if(ppsd==''||ppsd.length>12||ppsd<6){
		$('.ppasswordMsg').show();
		return;
	}
	if(ppsd!=prpsd){
		$('.prpasswordMsg').show();
	}else{
		$.ajax({
			   type: "POST",
			   url: "../updatePassword",
			   data:{
				   'mobile'  :$('.pmobile').val(),
				   'password'   :prpsd
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
						$('.stepImage').attr('src','front/images/step03.png');
						$('.step').hide();
						$('.step03').show();
				   }else{
					   $('.prpasswordMsg').html('手机号错误！');
					   $('.prpasswordMsg').show();
				   }
			   }
		});
	}
}
var regCode = 01;
var mobileStr = null;
function sendCodeMsgPwd(tt,type){
	var mobile = $('.pmobile').val();
	console.log(mobile);
	var mtest = /^([0-9]){11}$/;
	if(mobile==''||!mtest.test(mobile)){
		$('.pmobileMsg').html('手机号不对');
		$('.pmobileMsg').show();
		return;
	}
	var $this = $(tt);
	if($this.attr('flag')=='-1'){
		return;
	}
	$('.pmobileMsg').hide();
	$.ajax({
		   type: "POST",
		   url: "../sendPasswordCodeMsg",
		   data:{
			   'mobile'  :mobile,
			   'type'   :type
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				   mobileStr = mobile;
				   regCode = msg.code;
					$('.ptimeCount').show();
					$('.ptimeFont').html('获取验证码');
					$this.attr('flag','-1');
					$this.css('cursor','not-allowed');
					var time60=setInterval(function(){
						var cc=parseInt($('.ptimeCount').html().replace('(','').replace(')',''));
						if(cc==0){
							clearInterval(time60);
							$('.ptimeCount').html(' ( 60 )');
							$('.ptimeCount').hide();
							$('.ptimeFont').html('重新获取');
							$this.attr('flag','1');
							$this.css('cursor','pointer');
						}else{
							$('.ptimeCount').html('( '+(cc-1)+' )');
						}
					}, 1000);
			   }else{
				   $('.pmobileMsg').html(msg.reason);
			   }
		   }
	});
}
function removeOrder(tt,orderid){
	if(confirm("确定删除订单吗?")){
		$.ajax({
			   type: "POST",
			   url: "deleteOrder",
			   data:{
				   'orderId'  :orderid
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   $(tt).parent().parent().remove();
				   }
			   }
		});
	}
}
function dataExport(tt){
	var user= $('#userType').val();
	if(user==null||user==''){
		$('#qiyeloginA').click();
	}else{
		var totalPrice = 0;
		var orderArray = new Array();
		for(var i=0;i<$(tt).parent().parent().find('.publishTr').length;i++){
			var orderObj = {};
			orderObj.publishId = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPid');
			orderObj.priceStr = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPriceStr');
			orderObj.price = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPrice');
			orderObj.publishType = $($(tt).parent().parent().find('.publishTr')[i]).attr('attrPtype');
			totalPrice = totalPrice+parseInt(orderObj.price);
			orderArray.push(orderObj);
		}
		$.ajax({
			   type: "POST",
			   url: "../orderExport",
			   data:{
				   'totalPrice'  :totalPrice,
				   'orderArray':JSON.stringify(orderArray)
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					   window.open("../downFile")
				   }else{
					   $('#qiyeloginA').click();
				   }
			   }
		});
	}
}
function changeDiv(cls,tt){
	$('.divsh').hide();
	$('.'+cls).show();
	$('.alldaodiv').removeClass('currentCas');
	$(tt).addClass('currentCas');
}
function textSelct(pid){
	$('#textare'+pid).toggle();
}
function showhide(tt,orderdetailsid){
	var val  = $(tt).val();
	if(val==4){
		$('#textarecontent'+orderdetailsid).show();
	}else{
		$('#textarecontent'+orderdetailsid).hide();
	}
}
function selectChange6(orderid,orderdetailsid,tt){
	$.ajax({
		   type: "POST",
		   url: "updateOrder",
		   data:{
			   'orderid'  :orderid,
			   'status':'6'
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				  alert('接受订单成功');
				  $('.statusSelect').hide();
				  $('.statusOk').show();
			   }
		   }
	});
}
function selectChange5(orderid,orderdetailsid,tt){
	$.ajax({
		   type: "POST",
		   url: "updateOrder",
		   data:{
			   'orderid'  :orderid,
			   'status':'5'
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				  alert('拒绝成功');
				  $('.statusSelect').hide();
				  $('.statusNo').show();
			   }
		   }
	});
}
function selectChange4(orderid,orderdetailsid,tt){
	var admincontent = $('#textarecontent'+orderdetailsid).find('.elem1').val();
	$.ajax({
		   type: "POST",
		   url: "updateOrder",
		   data:{
			   'orderid'  :orderid,
			   'admincontent':admincontent,
			   'status':'4'
		   }, 
		   dataType:"json",
		   success: function(msg){
			   if(msg.result=='yes'){
				  alert('提交成功');
			   }
		   }
	});
}
function selectChange(orderid,orderdetailsid,tt){
	var val  = $('#orstatus').val();
	if(val==4){
		var admincontent = $('#textarecontent'+orderdetailsid).find('.elem1').val();
		$.ajax({
			   type: "POST",
			   url: "updateOrder",
			   data:{
				   'orderid'  :orderid,
				   'admincontent':admincontent,
				   'status':val
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					  alert('修改成功');
				   }
			   }
		});
		return;
	}else{
		$.ajax({
			   type: "POST",
			   url: "updateOrder",
			   data:{
				   'orderid'  :orderid,
				   'status':val
			   }, 
			   dataType:"json",
			   success: function(msg){
				   if(msg.result=='yes'){
					  alert('修改成功');
				   }
			   }
		});
	}
}

</script>
<style type="text/css">
.currentCas{border-bottom: 1px #fc6769 solid;color:#fc6769 !important;}
.currentbc{border-bottom:1px #000000 solid;}
.selectClass{color:#fc6769 !important;}
input {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #ebebeb;
    color: #bdbdbd;
    float: left;
    font-size: 14px;
    height: 38px;
    line-height: 38px;
    margin: 0 5px;
    outline: medium none;
    text-align: center;
    width: 38px;
}
</style>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="${sessionScope.user.id}" id="userType" />
<input type="hidden" value="${sessionScope.type}" id="userflag" />
<input type="hidden" value="${typeFlag}" id="typeFlag" />
<input type="hidden" value="${sessionScope.user.userFlag }" id="uesFlag"/>
	<div style="width:100%;height:auto;overflow: hidden;margin-top:20px; ">
		<div style="width:92%;padding:20px 30px 40px 30px;background: white;overflow: hidden;">
			<div style="width:100%;height:36px;border-bottom: 1px #707070 solid;">
				<div style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;" class="alldaodiv currentCas" onclick="changeDiv('orderDiv',this)">订单列表</div>
				<div style="cursor:pointer;height:36px;font-size: 18px;color:#333333;float:left;width:100px;text-align: center;margin-left:25px;" id="passwdbtn" class="alldaodiv" onclick="changeDiv('passwordDiv',this)">密码修改</div>
			</div>
			<div style="width:100%;margin-top:20px;" class="orderDiv divsh">
					<table cellspacing="0px" class="plisDiv" style="width:100%;font-size:14px;border:1px #dfdfdf solid;">
					<tbody><tr valign="middle" height="40px" style="background: #f8f8f8;"><td width="150px" align="center">广告主题</td><td width="170px" align="center">投放主体</td><td width="150px" align="center">广告类型</td>
					<td width="150px" align="center">阅读量</td><td width="150px" align="center">位置</td><td width="150px" align="center">报价</td><td width="150px" align="center">金主爸爸</td><td width="150px" align="center">订单生成日期</td><td width="250px" align="center">订单状态</td><td width="200px" align="center">总金额</td><td width="150px" align="center">备注</td></tr>
		<!-- 			<div style="float:left;"><img src="front/images/weixin.png" /></div> -->
				</tbody></table>
				<div style="width:100%;overflow: hidden;">
						<table cellspacing="0px" class="plisDiv" style="font-size:14px;border:1px #dfdfdf solid;float:left;width:100%-1px;">
						<c:forEach items="${orderlist.list }" var="orderDetails"  varStatus="stt">
								<tr valign="middle" height="60px" class="publishTr" attrPid="${orderDetails.publish.id }" attrPriceStr="${orderDetails.publish_pricestr }" attrPrice="${orderDetails.publish_price }" attrPtype="${orderDetails.publish.publishTypeObj.publishFieldName }">
									 <td width="150px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><img width="48px" height="48px" src="/attachment${orderDetails.publish.image }"></td>
									 <td width="120px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishName }</div></td>
									 <td width="180px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><div style="margin-top:1px;" >${orderDetails.publish.publishTypeObj.publishFieldName }</div></td>
									 <td class="fansTd" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " width="150px" align="center">${orderDetails.publish.platformFans }</td>
									 <td width="150px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center">${orderDetails.publish_pricestr }</td>
									 <td width="150px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><span class="priceclassspan">${orderDetails.publish_price }</span></td>
									 <td width="130px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><span class="priceclass">${orderDetails.order.advertiser.corporation_name }</span></td>
									 <td width="130px" style="border-left:1px #dfdfdf solid;border-top:1px #dfdfdf solid; " align="center"><span class="priceclass">${orderDetails.order.order_createtime }</span></td>
							    	 <td width="250px" style="border-top:1px #dfdfdf solid;border-left:1px #dfdfdf solid;" align="center" rowspan="${orderDetails.order.orderDetailsList.size()}">
							    	 	<c:if test="${orderDetails.order.order_status==0 }">
							    	 		<div class="statusSelect">
								    	 		<button onclick="selectChange6(${orderDetails.order.order_id },${orderDetails.order_detail_id },this)">执行订单</button><br/>
								    	 		<button onclick="selectChange5(${orderDetails.order.order_id },${orderDetails.order_detail_id },this)">拒绝</button>
							    	 		</div>
							    	 		<div class="statusOk" style="display:none;">已确认待付款</div>
							    	 		<div class="statusNo" style="display:none;">已拒绝</div>
							    	 	</c:if>
							    	 	<c:if test="${orderDetails.order.order_status==6 }">
							    	 		已确认待付款
							    	 	</c:if>
							    	 	<c:if test="${orderDetails.order.order_status==1 }">已付款
							    	 		<button onclick="selectChange4(${orderDetails.order.order_id },${orderDetails.order_detail_id },this)">提交结案报告</button>
							    	 	</c:if>
							    	 	<c:if test="${orderDetails.order.order_status==2 }">已取消</c:if>
							    	 	<c:if test="${orderDetails.order.order_status==5 }">已拒绝</c:if>
							    	 	<c:if test="${orderDetails.order.order_status==4 }">已完成
							    	 		<button onclick="selectChange4(${orderDetails.order.order_id },${orderDetails.order_detail_id },this)">提交结案报告</button>
							    	 	</c:if>
<%-- 							    	 	<select id="orstatus" onchange="showhide(this,${orderDetails.order_detail_id })"> --%>
<%-- 												<option value="0" <c:if test="${orderDetails.order.order_status=='0' }">selected="selected"</c:if>>待付款</option> --%>
<%-- 												<option value="1" <c:if test="${orderDetails.order.order_status=='1' }">selected="selected"</c:if>>已付款</option> --%>
<%-- 												<option value="2" <c:if test="${orderDetails.order.order_status=='2' }">selected="selected"</c:if>>已取消</option> --%>
<%-- 												<option value="4" <c:if test="${orderDetails.order.order_status=='4' }">selected="selected"</c:if>>已完成</option> --%>
<!-- 											</select> -->
<%-- 											<button onclick="selectChange(${orderDetails.order.order_id },${orderDetails.order_detail_id },this)">确定</button> --%>
							    	 </td>
							    	 <td width="150px" style="border-top:1px #dfdfdf solid;border-left:1px #dfdfdf solid;" align="center" >${orderDetails.order.order_contentbudget }</td>
							    	 <td width="150px" style="border-top:1px #dfdfdf solid;border-left:1px #dfdfdf solid;" align="center" ><a onclick="textSelct(${orderDetails.order_detail_id })" href="javascript:;" style="text-decoration: none;">查看备注</a></td>
							     </tr> 
							     <tr attrflag="2" class="textTr" id="textarecontent${orderDetails.order_detail_id }" style="margin-top:-5px;<c:if test="${orderDetails.order.order_status!='4'&&orderDetails.order.order_status!='1' }">display:none;</c:if>">
							     <td colspan="11" style="border-top:1px #dfdfdf solid;">
									<div style="width:100%;overflow: hidden;">
										<div style="width:100%;font-size:16px;padding:10px;text-align: center;">结案报告：</div>
										<textarea class="elem1"  style="width: 100%;min-height:100px;">${orderDetails.order.admincontent }</textarea>
									</div>
								</td></tr>
							     <tr class="textTr" id="textare${orderDetails.order_detail_id }" style="display:none;margin-top:-5px;"><td colspan="11" style="border-top:1px #dfdfdf solid;">
									<div style="width:100%;overflow: hidden;text-align: center;">
												<div style="width:100%;font-size:16px;padding:10px;text-align: center;">用户备注：</div>
												<div style="width:100%;overflow: hidden;">${orderDetails.content }</div>   
									</div>
									</td></tr>
						</c:forEach>
					    </table>
				</div>
			</div>
			<div class="passwordDiv divsh" style="display:none;">
				<div style="width:100%;height:auto;overflow: hidden;">
					<div style="width:868px;height:90px;margin:40px auto 0px;"><img class="stepImage" src="front/images/step01.png"/></div>
				</div>
				<div class="step01 step" style="margin-top:50px;padding-bottom: 20px;">
					<div style="width:320px;margin:0 auto;position: relative;">
						<input class="pmobile" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="用户名(手机号)" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="pmobileMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">用户名已存在</div>
					</div>
					<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;overflow: hidden;">
						<div class="pcodeMsg errormsg" style="display:none;color:red;top:14px;right:152px;position: absolute;font-size:12px;">验证码不正确</div>
						<input class="pcode" style="margin:0px;width:180px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="验证码" />
						<div onclick="sendCodeMsgPwd(this,'修改密码')" style="float:left;height:42px;line-height: 42px;width:120px;text-align:center;color:black;font-size:14px;border: 1px #ebebeb solid;border-left: 0px;cursor: pointer; ">
						       <span class="ptimeFont">获取验证码</span><span class="ptimeCount" style="display:none;"> ( 60 )</span>
						</div>
					</div>
					<div onclick="gostep2()" style="width:302px;margin:20px 448px 0px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;border-radius:5px;text-align: center;cursor: pointer;">
						确定
					</div>
				</div>
				<div  class="step02 step" style="margin-top:50px;padding-bottom: 20px;display:none;">
					<div style="width:320px;margin:0 auto;position: relative;">
						<input class="ppassword" type="password" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="密码" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="ppasswordMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不对</div>
					</div>
					<div style="width:320px;margin:0 auto;margin-top:20px;position: relative;overflow: hidden;">
						<input type="password" class="rppassword" style="margin:0px;width:300px;height:44px;padding:6px;color:#333333;text-align:left;background: rgb(249,249,249);" type="text" placeholder="再次输入密码" />
						<span style="height:44px;margin-left:10px;line-height: 48px;width:5px;text-align:left;color:red;font-size:14px; ">*</span>
						<div class="prpasswordMsg errormsg" style="display:none;color:red;top:14px;right:32px;position: absolute;font-size:12px;">密码不一致</div>
					</div>
					<div onclick="gostep3()" style="width:302px;margin:20px 410px 0px;height:48px;background: #fc6769;color:white;font-size:18px;line-height: 48px;border-radius:5px;text-align: center;cursor: pointer;">
						确定
					</div>
				</div>
				<div class="step03 step" style="margin-top:50px;padding-bottom: 20px;display:none;">
					<div style="width:320px;margin:0 auto;position: relative;text-align: center;color:28px;margin-top:60px;">
						修改密码成功！
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>