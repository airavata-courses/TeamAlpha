
<%@ page import="com.teamAlpha.airavata.utils.Constants"%>

<link rel="stylesheet" type="text/css"
	href="css/bootstrap.progressbar.css" />
<link rel="stylesheet" type="text/css"
	href="css/jquery-fileupload/jquery.fileupload-ui.css" />

<form class="navbar-form1" id="fileupload" action="uploadJob.htm"
	method="POST" enctype="multipart/form-data" onsubmit="validate()">

	<input id="fileType" name="fileType" type="hidden" />
	<div class="box-body">
		<div class="fileupload-buttonbar">
			<div class="col-sm-12">

				<div class="row">
					<div class="col-sm-12">
						<div class="form-group">

							<label>No. of Nodes :</label> <input type="text"
								class="form-control validation-field" name="noOfNodes" id="noOfNodes"
								placeholder="Enter">
						</div>
						<div class="form-group">

							<label>Processors Per Node :</label> <input type="text"
								class="form-control validation-field" name="procPerNode" id="procPerNode"
								placeholder="Enter">
						</div>
						<div class="form-group">
							<label>Wall time :</label> <input type="text"
								class="form-control validation-field" name="wallTime" id="wallTime"
								placeholder="HH:mm:ss">
						</div>
						
						<div class="form-group">
							<label>Select Cluster</label>
							<!-- <input type="text" -->
							<!-- class="form-control" name="jobType" id="jobType" placeholder="Enter"> -->
							<select class="form-control" name="hostType" id="hostType"
								placeholder="Select JobType">
								<option value="" disabled selected>Select</option>
								<option value="${HOST_KARST}">Karst</option>
								<option value="${HOST_BIGRED2}">Big Red 2</option>
							</select>
						</div>

						<div class="form-group">
							<label>Job Type</label>
							<!-- <input type="text" -->
							<!-- class="form-control" name="jobType" id="jobType" placeholder="Enter"> -->
							<select class="form-control" name="jobType" id="jobType"
								placeholder="Select JobType">
								<option value="" disabled selected>Select</option>
								<option value="${TYPE_PBS}">PBS</option>
<%-- 								<option value="${TYPE_LAMMPS}">LAMMPS</option> --%>
								<option value="${TYPE_GROMACS}">GROMACS</option> 
							</select>
						</div>

						<div class="form-group">
							<div class="validation-message error hide"></div>
						</div>
					</div>
				</div>

				<!-- The fileinput-button span is used to style the file input field as button -->

<!-- 				<span class="btn btn-primary fileinput-button"> <i -->
<!-- 					class="icon-plus icon-white"></i><span>Add Job</span> <input -->
<!-- 					type="file" name="files" id="file"> </a> -->
<!-- 				</span> -->
<!-- 					<div class="fileUpld btn btn-primary"> -->
<!-- 					    <span>Upload</span> -->
<!-- 					    <input type="file" class="upload" /> -->
<!-- 					</div> -->
<!-- 					<div class="fileUpld btn btn-primary"> -->
<!-- 					    <span>Upload</span> -->
<!-- 					    <input type="file" class="upload" /> -->
<!-- 					</div> -->
					<div id="up1" class="row hide">
						<div class="col-sm-3">
							<div class="form-group">
							    <input type="file" name="file"/>
						    </div>
						</div>
					</div>
					<div id="up2" class="row hide">
						<div class="col-sm-3">
							<div class="form-group">
							    <input type="file" name="file"/>
							</div>
						</div>
					</div>
<!-- 					<div id="up1" class="row hide"> -->
<!-- 						<div class="col-sm-3"> -->
<!-- 							<input class="form-control uploadFile" placeholder="Choose File" disabled="disabled" /> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-3"> -->
<!-- 							<div class="fileUpld btn btn-primary"> -->
<!-- 							    <span>Upload</span> -->
<!-- 							    <input type="file" name="file" class="upload" /> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div id="up2" class="row hide"> -->
<!-- 						<div class="col-sm-3"> -->
<!-- 							<input class="form-control uploadFile" placeholder="Choose File" disabled="disabled" /> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-3"> -->
<!-- 							<div class="fileUpld btn btn-primary"> -->
<!-- 							    <span>Upload</span> -->
<!-- 							    <input type="file" name="file" class="upload" /> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				<input -->
<!-- 					type="file" name="file" /> -->
<!-- 					<input -->
<!-- 					type="file" name="file" /> -->

				<button type="submit" class="btn btn-primary start hide" id="submit">
					<i class="icon-upload icon-white"></i> <span>Submit Job</span>
				</button>

<!-- 				<button type="reset" class="btn btn-primary cancel"> -->
<!-- 					<i class="icon-ban-circle icon-white"></i> <span>Cancel -->
<!-- 						upload</span> -->
<!-- 				</button> -->

			</div>
			<br>
			<div class="fileupload-progress">
				<div class="box-body no-padding">
					<div class="bulk-upload-row">
						<div class="col-sm-12">
							<div role="presentation" id="fileupload-tables">
								<div class="files" data-toggle="modal-gallery"
									data-target="#modal-gallery"></div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>






</form>

<!-- The template to display files available for upload -->

<script id="template-upload" type="text/x-tmpl">
{% 
	var cnt = 0;
for (var i=0, file; file=o.files[i]; i++) { 
	cnt = $("#fileupload-tables > tbody > tr").length+1;
 	
%}
    <div class="template-upload fade">
		<div class="row">
       	 <div class="name col-sm-5"><span class="adjust-name"><b>{%=file.name%}</b></span></div>
         <div class="size col-sm-2"><span>{%=o.formatFileSize(file.size)%}</span></div>
        {% if (file.error) { %}
            <div class="error-fileUpload col-sm-5"><span class="label label-important background-red adjust-name">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</div>
		
        {% } else if (o.files.valid && !i) { %}
            <div>
                <div class="progress progress-success progress-sdiviped active button-hidden hide" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </div>
			<div class="start hide">{% if (!o.options.autoUpload) { %}
                <button id="{%=cnt%}" class="btn btn-primary button-hidden">
                    <i class="icon-upload icon-white"></i>
                    <span>{%=locale.fileupload.start%}</span>
                </button>
            {% } %}</div>
        {% } else { %}
            <div ></div>
			<div ></div>
        {% } %}
        <div class="cancel hide">{% if (!i) { %}
            <button class="btn btn-warning button-hidden">
                <i class="icon-ban-circle icon-white"></i>
                <span>{%=locale.fileupload.cancel%}</span>
            </button>
        {% } %}
    </div>
   </div>
    <div class="row">
	<div class="col-sm-12">
		<div>
			<div class="span5 fileupload-progress fade">
				
							<div class="progress progress-success progress-sdiviped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
								<div class="bar"></div>
							</div>
							
							<div class="progress-extended">&nbsp;</div>
			</div>
         <div>
    </div>
			</div>
	</div>
{% } %}
</script>

<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% 
for (var i=0, file; file=o.files[i]; i++) { 
%}
<tr class="template-upload fade">
<td>
	<table>
		<tr>
		{% if (file.error) { %}
       		<td class="name"><span><b>{%=$.trim(file.name)%}</b></span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
			<td></td>
            <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (file.isFileErrored) { %}
            <td class="name">
                <b>{%=$.trim(file.name)%}</b>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
			<td></td><td></td><td></td></tr>
			<tr><td class="error" colspan="4"><span class="label label-important background-red">{%=file.errorMessage %}</span></td>
        {% } else { %}
            <td class="name">
				 <b>{%=$.trim(file.name)%}</b>	
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
			<td class="error" colspan="2"><span class="label label-important" style="background-color:green">File uploaded successfully.</span></td>
			<td></td>
        {% } %}
		</tr>
	</table>
</td>
</tr>
{% } %}
</script>

<script type="text/javascript" src="js/custom/bulkUpload.js"></script>
<!-- <script type="text/javascript" src="js/fileupload/tmpl.min.js"></script> -->
<!-- <script type="text/javascript" src="js/fileupload/load-image.min.js"></script> -->
<!-- <script type="text/javascript" src="js/fileupload/canvas-to-blob.min.js"></script> -->
<!-- 	<script type="text/javascript" src="js/fileupload/bootstrap.min.js"></script> -->
<!-- 	<script type="text/javascript" src="js/fileupload/bootstrap-image-gallery.min.js"></script> -->
<!-- <script type="text/javascript" -->
<!-- 	src="js/fileupload/jquery.iframe-transport.js"></script> -->
<!-- <script type="text/javascript" src="js/fileupload/main.scroll.js"></script> -->

