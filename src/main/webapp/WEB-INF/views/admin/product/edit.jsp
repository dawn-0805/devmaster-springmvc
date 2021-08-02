<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="newURL" value="/quan-tri/san-pham/danh-sach"/>
<c:url var="editNewURL" value="/quan-tri/san-pham/chinh-sua"/>
<c:url var="newAPI" value="/api/product"/>
<c:url var="uploadAPI" value="/api/upload"/>
<c:url var="homeURL" value="/quan-tri/san-pham/danh-sach" />
<html>
<head>
    <title>Chỉnh sửa sản phẩm </title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li><i class="ace-icon fa fa-home home-icon"></i> <a href="${homeURL}">Trang chủ</a>
                </li>

                <li><a href="${newURL}">Danh sách sản phẩm </a></li>
            </ul>
            <!-- /.breadcrumb -->
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                  <c:if test="${not empty message}">
                        <div class="alert alert-${alert}">
                                ${message}
                        </div>
                    </c:if>
                    <form:form class="form-horizontal" role="form" id="formSubmit" modelAttribute="model"  enctype="multipart/form-data">
                       
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" >Tên sản phẩm : </label>
                            <div class="col-sm-9">
                                <form:input path="name" cssClass="col-xs-10 col-sm-5"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" >Ảnh đại diện :</label>
                            <div class="col-sm-9">
                                <input type="file" class="col-xs-10 col-sm-5" id="thumbnail" name="thumbnail"/>
                            </div>
                        </div>
                           <div class="form-group">
                            <label for="content" class="col-sm-3 control-label no-padding-right">Giá sản phẩm :</label>
                            <div class="col-sm-9">
                                <form:input path="price" cssClass="col-xs-10 col-sm-5"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="shortDescription" class="col-sm-3 control-label no-padding-right">Mô tả ngắn :</label>
                            <div class="col-sm-9">
                                <form:textarea path="shortDescription" rows="5" cols="10" cssClass="form-control" id="shortDescription"/>
                            </div>
                        </div>
                     
                        <form:hidden path="id" id="newId"/>
                        <div class="clearfix form-actions">
                            <div class="col-md-offset-3 col-md-9">
                                <c:if test="${not empty model.id}">
                                    <button class="btn btn-info" type="button" id="btnAddOrUpdateNew">
                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                        Cập nhật sản phẩm
                                    </button>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <button class="btn btn-info" type="button" id="btnAddOrUpdateNew">
                                        <i class="ace-icon fa fa-check bigger-110"></i>
                                        Thêm sản phẩm
                                    </button>
                                </c:if>
                                &nbsp; &nbsp; &nbsp;
                                <button class="btn" type="reset">
                                    <i class="ace-icon fa fa-undo bigger-110"></i>
                                    Hủy
                                </button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
	
	
	
	
	

    $('#btnAddOrUpdateNew').click(function (e){
        e.preventDefault();
        var data ={};
        var formData = $('#formSubmit').serializeArray();
        $.each(formData, function (i, v) {
            data[""+v.name+""] = v.value;
        });
        data["thumbnail"] = "abc.png";
        var id = $('#newId').val();
        if (id == "") {
            addNew(data);
        } else {
            updateNew(data);
        }

    });
    function  addNew(data){
        $.ajax({
            url : '${newAPI}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	 window.location.href = "${newURL}?message=insert_success";
            },
            error: function (error) {
            	 window.location.href = "${newURL}?message=error_system";
            }

        });
    }
    function  updateNew(data){
        $.ajax({
            url : '${newAPI}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
            	 window.location.href = "${newURL}?message=update_success";
            },
            error: function (error) {
            	window.location.href = "${editNewURL}?id="+error.id+"&message=error_system";
            }

        });
    }


</script>
</body>
</html>