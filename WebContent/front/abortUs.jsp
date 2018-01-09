<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>关于我们</title>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=imKM0mOZxKRRXXmCGF8QC6UCiQ2qBBQo"></script>
<script type="text/javascript">
function changeButton(type){
	if(type==1){
		$('html, body').animate({  
            scrollTop: $("#abortUsDiv").offset().top  
        }, 500);
	}else if(type==2){
		 $('html, body').animate({  
             scrollTop: $("#phoneUsDiv").offset().top  
         }, 500);
	}
}
</script>
</head>
<body style="padding:0px;margin:0px;">
<input type="hidden" value="2" id="headType" />
<%@include file="header.jsp" %>
<div style="width:100%;background:rgb(242,242,242);height:auto;overflow: hidden; ">
	<div style="width:1200px;margin:0 auto;margin-top:15px;margin-bottom:20px;overflow: hidden;">
		<div style="width:200px;float:left;">
			<div onclick="changeButton(1)" style="width:200px;height:42px;background: #fc6769;float:left;line-height: 38px;text-align: center;font-size:14px;color:#ffffff;cursor:pointer;border: 1px #707070 solid;border-bottom: 0px;">
				关于我们
			</div>
			<div onclick="changeButton(2)" style="width:200px;height:42px;float:left;line-height: 38px;text-align: center;font-size:14px;color:#707070;cursor:pointer;background: white;border: 1px #707070 solid;">
				联系我们
			</div>
		</div>
		<div style="width:928px;float:left;margin-left:10px;padding:20px 30px 40px 30px;background: white;border:1px #eeeeee solid;overflow: hidden;">
			<div id="abortUsDiv" style="width:100%;border-bottom: 1px #e0dbe0 solid;height:35px;">关于我们</div>
			<div style="width:100%;margin-top:15px;">
				<div><img src="/ghplat/attachment/banner/201707211127557082.jpg" width="100%"/></div>
				<div style="width:100%;color:#707070;font-size:15px;font-family: 黑体;margin-top:15px;">
					<div style="text-indent: 2em;line-height:24px;letter-spacing:1px;">勾画互动由一批互联网数字营销领域的资深专家于2016年创建，整个团队均来自中国知名互联网企业，核心团队成员曾在千橡互动，宝宝树，好耶，Linkedin，电信等知名企业担当高层管理职务，在数字媒体领域有丰富的市场策划和运营经验。</div>
					<div style="margin-top:10px;text-indent: 2em;line-height:24px;letter-spacing:1px;">勾画互动致力于打造中国领先的自媒体商业化聚合平台，在自媒体领域实现自媒体内容营销分发、自媒体孵化、自媒体行业研究、自媒体数据聚合和分析、海外自媒体内容营销分发等，包括但不仅限于微信公众号、网红主播、微博、自媒体头条号、短视频等专业的自媒体领域。</div>
				</div>
			</div>
			<div id="phoneUsDiv" style="width:100%;border-bottom: 1px #e0dbe0 solid;height:35px;margin-top:50px;">联系我们</div>
			<div style="width:100%;margin-top:15px;">
				<div style="width:100%;color:#333333;font-size:18px;font-family: 黑体;margin-top:15px;margin-bottom:15px;">勾画互动上海总部</div>
				<div id="shmap" style="width:100%;height:275px;"></div>
				<div style="width:100%;color:#707070;font-size:15px;font-family: 黑体;margin-top:15px;">
					<div style="margin-top:0px;">联系人：任先生</div>
					<div style="margin-top:10px;">联系方式：18616878426</div>
					<div style="margin-top:10px;">邮箱地址：kenney@ghplat.com</div>
					<div style="margin-top:10px;">地址：上海市江场路1367号绿地中央广场3号楼4楼416室</div>
				</div>
				<br>
				<div style="width:100%;color:#333333;font-size:18px;font-family: 黑体;margin-top:15px;margin-bottom:15px;">勾画互动北京分公司</div>
				<div id="bjmap" style="width:100%;height:275px;"></div>
				<div style="width:100%;color:#707070;font-size:15px;font-family: 黑体;margin-top:15px;">
					<div style="margin-top:0px;">联系人：高女士</div>
					<div style="margin-top:10px;">联系方式：13691195186</div>
					<div style="margin-top:10px;">邮箱地址：gaoyu@ghplat.com</div>
					<div style="margin-top:10px;">地址：北京市朝阳区广渠路28号院401号楼</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp" %>
</body>
<script type="text/javascript">
	// 百度地图API功能
	var shmap = new BMap.Map("shmap");          
	shmap.centerAndZoom(new BMap.Point(121.487899,31.249162), 11);
	var shlocal = new BMap.LocalSearch(shmap, {
		renderOptions:{map: shmap}
	});
	shlocal.search("上海勾画网络科技有限公司");
	
	var bjmap = new BMap.Map("bjmap");          
	bjmap.centerAndZoom(new BMap.Point(116.490348,39.893829), 11);
	var bjlocal = new BMap.LocalSearch(bjmap, {
		renderOptions:{map: bjmap}
	});
	bjlocal.search("北京市珠江帝景E区");
	
</script>
</html>