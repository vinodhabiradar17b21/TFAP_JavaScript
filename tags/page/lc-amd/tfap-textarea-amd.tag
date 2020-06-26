<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://tfap.portal.camelone.com/" prefix="tfap"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@attribute name="fieldName" type="java.lang.String" required="true" %>
<%@attribute name="fieldKey" type="java.lang.String" required="true" %>
<%@attribute name="fields" type="java.lang.String" required="true" %>
<%@attribute name="fieldId1" type="java.lang.Integer" required="true" %>
<%@attribute name="fieldId2" type="java.lang.Integer" required="true" %>
<%@attribute name="required" type="java.lang.Boolean" required="true" %>
<%@attribute name="maxlength" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxVal" type="java.lang.String" required="false" %>
<%@attribute name="requireDetails" type="java.lang.Boolean" required="false" %>
<%@attribute name="maxLines" type="java.lang.Integer" required="false" %>
<%@attribute name="maxLengthOfLine" type="java.lang.Integer" required="false" %>

<p class="msg-amendable text-amendable">
	<label for="${fieldName}"><spring:message code="${fieldKey}"/></label>
	<form:textarea id="${fieldName}" path="${fieldName}" rows="3"
		cssErrorClass="border-danger form-control ${required ? 'required' : ''}"
		cssClass="form-control ${required ? 'required' : ''}"
		readonly="true"
		disabled="${(not empty isDisabled && isDisabled) || ((not empty isdisabled && isdisabled))? 'true':'false'}"
		maxlength="${not empty maxVal && maxlength ? maxVal : ''}"/>
	
	<form:errors path="${fieldName}" class="red" />
	<c:if test="${tfApplication.tfTransaction.tfTran.state ne 'DRF'}">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#${fields}modal" disabled="disabled" >
			<i class="fa fa-pencil disabled"></i> Amend
		</button>
	</c:if>
	<c:if test="${tfApplication.tfTransaction.tfTran.state eq 'DRF'}">
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#${fields}modal">
			<i class="fa fa-pencil disabled"></i> Amend
		</button>
	</c:if>	
	<a href="#" data-toggle="modal" class="disabled"
		data-target="#${fields}historymodal" disabled>
		<%-- <button type="button" class="btn btn-primary" data-toggle="tooltip" data-placement="bottom" title="<spring:message code="label.tooltip.history"/>"
			style="border-bottom-left-radius: 0px; border-top-left-radius: 0px;"
			data-original-title="History" >
			<i class="fa fa-clock-o"></i>
		</button> --%>
	</a>
	<span id="${fieldName}_success_msg" class="text-success d-none">Text amended <i class="fa fa-check"></i><span></span></span>
	<c:if test= "${requireDetails}">
	<p class="mb-0 text-right">
		<span id="${fieldName}_char">0</span> characters remaining | <span id="${fieldName}_line">0</span> lines remaining
	</p>
	</c:if>
</p>

<!-- Modals: ADD / DELETE /REPALL amend message -->
<tfap:modal 
	button_name="label.modal.button.save.changes"
	modal_title="label.modal.title.amending.message"
	modal_Id="${fields}modal"
	modal_size="lg"
	show_button_cancel="true"
	button_cancel_name="label.modal.button.cancel"
	css_class="amend-msg-modal"
	primary_btn_id="modal_amd_msg_primary${fields}">
		
	<p>
		<label for="${fields}_originalmsg_amd">Original Message</label>
		<textarea id="${fields}_originalmsg_amd" class="form-control" rows="3" disabled></textarea>
	</p>
	
    <p id="amend-ctrl" class="text-right">
        <span class="btn-group" role="group" aria-label="Basic example">
            <button id="${fields}amend-add" type="button" class="btn btn-outline-primary add-msg" onclick="addAddAmendHistory${fieldId1}('${fields}')">ADD</button>
            <button id="${fields}amend-del" type="button" class="btn btn-outline-primary del-msg" onclick="addDeleteAmendHistory${fieldId1}('${fields}')">DELETE</button>
            <button id="${fields}amend-all" type="button" class="btn btn-outline-primary rep-all" onclick="addReplaceAmendHistory${fieldId1}('${fields}')">REPLACE</button>
        </span>
    </p>
    <div class="col-12 p-0" id="amend-msgs${fields}">
	    <!-- <div id="amendment-message-logs">
			
		</div> -->
	</div>
	<div id="hidden-amendment-message-field-${fields}" class="d-none field">
		<label></label>
		<textarea class="form-control" rows="3"></textarea>
		<button type="button" class="" onclick="selfElementDetele(this)"><i class="fa fa-times"></i></button>
		<!-- <p class="mb-0 text-right">
			<span class="_char">0</span> characters remaining | <span class="_line">0</span> lines remaining
		</p> -->
	</div>
	
    
    <script>

    var originalText = $('textarea[id="${fields}_originalmsg_amd"]').text();
		// delete msg inut
    	function addDeleteAmendHistory${fieldId1}(fields){
    		var delMaxlength = $('textarea[id="${fields}_originalmsg_amd"]').text().length;
    		originalText = $('textarea[id="${fields}_originalmsg_amd"]').text();
    		if( $('.msg-all.fleid${fieldId1}').length > 0 ){
    			$("div#amend-msgs"+fields).empty();
    			replaceCount${fieldId1} = 0;
    		}
    		var deleteElem = $('<div class="msg-del field fleid${fieldId1}" style="">'
				    		+'<label for="">Message to delete</label>'
					        +'<textarea class="form-control" rows="3" maxlength="${delMaxlength}"  placeholder="Enter message to delete" onchange="toSearchText(this)"></textarea>'
					        +'<button type="button" class="" onclick="selfElementDetele(this)"><i class="fa fa-times"></i></button>'
					        +'<label id="textNotFoundId" value=""></label>'
					    +'</div>');
    		$(deleteElem).find('textarea').first().bind('keyup', textAreaChange);
    		$("#amend-msgs"+fields).prepend(deleteElem);
		    
    	}
		var n= -1
    	function toSearchText(deleteElem){
    		var stringToBeDeleted = deleteElem.value;
    		var n = originalText.match(stringToBeDeleted);
    		var lbl = document.getElementById('textNotFoundId');
    		if(n != stringToBeDeleted ){
    			lbl.innerText="Entered text not found in original text";
    			$("#textNotFoundId").css("color", "red");
    		}else{
    			lbl.innerText="";
    		}
    		return n;
    	}
    	
		// add msg input
		var addCount${fieldId1} = 0;
    	function addAddAmendHistory${fieldId1}(fields){
    		var addMaxlength = ${maxVal} - $('textarea[id="${fields}_originalmsg_amd"]').text().length;
    		if( $('.msg-all.fleid${fieldId1}').length > 0 ){
    			$("div#amend-msgs"+fields).empty();
    		}
    		
    		if( $('.msg-add.fleid${fieldId1}').length == 0 ){
    			
    			var $addElem = $('<div class="msg-add field fleid${fieldId1}" style="" data-id="'+ addCount${fieldId1} +'">'
		        		+'<label for="">Message to add</label>'
	    		        +'<textarea class="form-control" rows="3" maxlength="${addMaxlength}" placeholder="Enter message to append" "></textarea>'
	    		        +'<button type="button" class="" onclick="selfElementDetele(this)"><i class="fa fa-times"></i></button>'
	    		    +'</div>');
    			$("#amend-msgs"+fields).prepend($addElem);	
    		}
    		addCount${fieldId1}++
		}
		

		// replay msg input
		var replaceCount${fieldId1} = 0;
    	function addReplaceAmendHistory${fieldId1}(fields){
    		if( $('.msg-all.fleid${fieldId1}').length == 0 ){
    			
    			var $replaceElem = $('<div class="msg-all field fleid${fieldId1}" style="">'
		        		+'<label for="">Replace all with the following</label>'
	    		        +'<textarea class="form-control" rows="3" maxlength="${maxVal}" placeholder="Enter text to replace"></textarea>'
	    		        +'<button type="button" class="" onclick="selfElementDetele(this)"><i class="fa fa-times"></i></button>'
	    		    +'</div>');
    			$("#amend-msgs"+fields).empty().prepend($replaceElem);	
    		}
    		addCount${fieldId1} = 0;
    		replaceCount${fieldId1}++
		}
    	
    	function selfElementDetele(el){
    		var element = $(el).closest('div.field');
    		var id = parseInt(element[0].dataset.id) > 0 || !element[0].dataset.id ? addCount${fieldId1} = 0 : '' ;
    		
    		$(element).remove();
    	}
    	
    	function textAreaChange(e){
    		if(e.target.value.length > 0){
    			console.log('enable btn')
    			$('[id="${fields}amend-del"]').removeAttr('disabled');
    		}else{
    			console.log('disabled btn')
    			$('[id="${fields}amend-del"]').attr('disabled', 'disabled');
    		}
    	} 
		
    </script>
	
</tfap:modal>
<!-- End modal : ADD /DELETE / REPALL -->

<!-- Modals: ADD / DELETE /REPALL amend message - history trail -->
<tfap:modal 
	button_name="label.modal.button.close"
	modal_title_prefix="${fieldKey}"
	modal_title="label.modal.title.amendment"
	modal_Id="${fields}historymodal"
	modal_size="lg"
	primary_btn_id="modal_amd_history_primary${fields}">
	
	<p>
		<label for="${fields}_originalmsg_history">Original Message</label>	
		<textarea id="${fields}_originalmsg_history" class="form-control" rows="3" disabled></textarea>
	</p>
	
	
	<div id="amendment-history-logs${fields}">
		
	</div>
	<p id="hidden-amendment-history-field-${fields}" class="d-none">
		<label></label>
		<textarea class="form-control" rows="3" disabled></textarea>
	</p>
	
</tfap:modal>
<!-- End modal : ADD /DELETE / REPALL-->



<script>
	$(document).ready(function(){
		
		loadDataToAmendAndHistoryModals${fields}();
		
		$('[id="modal_amd_msg_primary${fields}"]').removeAttr('data-dismiss');
		
		$('[id="${fields}historymodal"], [id="${fields}modal"]').on('shown.bs.modal', function (e) {
			loadDataToAmendAndHistoryModals${fields}();
			showSuccess${fields}(false);
		});
		
		$('[id="modal_amd_msg_primary${fields}"]').on('click', function(e){
			sendAmendModalHistory${fields}();
		});
		
		
		function loadDataToAmendAndHistoryModals${fields}(){
			$.ajax({
				url : '/TFAPortal/principleaccount/history/text-area?parentTfapId=${tfApplication.tfTransaction.tfTran.tftRelatedTftId}&tfapId=${tfApplication.tfTransaction.tfTran.ttfId}&fieldId=${fieldId1}&state=${tfApplication.tfTransaction.tfTran.state}',
				method : "GET",
				success : function(rsp){
					var rsp = JSON.parse(rsp);
					var data = rsp.data;
					var amendList = data.amendList;
					var originalMessage = data.originalMessage;
					var displayMessage = data.displayMessage;
					var currentInitialMessage = data.currentInitialMessage;
					
					if(rsp.success){
						$('[id="amendment-history-logs${fields}"]').empty();
						$('[id="amend-msgs${fields}"]').empty();
						$('textarea[id="${fields}_originalmsg_history"]').text(originalMessage);
						$('textarea[id="${fields}_originalmsg_amd"]').text(currentInitialMessage);
						$('textarea[id="${fieldName}"]').text(displayMessage);
						
						$.each(amendList, function(i, item){
							
							if(!item.draft){
								var newField = $('[id="hidden-amendment-history-field-${fields}"]').clone();
								$(newField).removeClass('d-none');
								$(newField).removeAttr('id');
								$(newField).find('label').first().text(item.action);
								$(newField).find('textarea').first().text(item.content);
								$(newField).find('textarea').first().attr('maxlength','${maxVal}');
								$('[id="amendment-history-logs${fields}"]').append(newField);
								
							}else{
								var newField = $('[id="hidden-amendment-message-field-${fields}"]').clone();
								$(newField).removeClass('d-none');
								$(newField).removeAttr('id');
								$(newField).find('label').first().text("Message to "+item.action.toLowerCase());
								$(newField).find('textarea').first().text(item.content);
								$(newField).find('textarea').first().attr('maxlength','${maxVal}');
								
								if(item.action.toUpperCase() == 'ADD'){
									$(newField).addClass('msg-add fleid${fieldId1}');
									addCount${fieldId1}++;
								}else if(item.action.toUpperCase() == 'DELETE'){
									$(newField).addClass('msg-del fleid${fieldId1}');
								}else if(item.action.toUpperCase() == 'REPLACE'){
									$(newField).addClass('msg-all fleid${fieldId1}');
								}
								
								$('[id="amend-msgs${fields}"]').append(newField);
							}
						});
					}else{
						$('textarea[id="${fields}_originalmsg_amd"]').text($('textarea[id="${fieldName}"]').val());
						$('textarea[id="${fields}_originalmsg_history"]').text($('textarea[id="${fieldName}"]').val());
					}
				}
			});
		}
	
		
		function sendAmendModalHistory${fields}(){
			var lbl;
			if(document.getElementById('textNotFoundId') != null){
				lbl = document.getElementById('textNotFoundId').innerText;
				if(lbl === "Entered text not found in original text"){
					return;
				}
			}
			
			var amendList = [];
			
			var replaceFileds = $('[id="amend-msgs${fields}"]').find('.msg-all textarea')
			var deleteFields = $('[id="amend-msgs${fields}"]').find('.msg-del textarea')
			var addFields = $('[id="amend-msgs${fields}"]').find('.msg-add textarea')
			
			$.each(replaceFileds, function(i, field){
				if($(field).val()!=$('textarea[id="${fields}_originalmsg_history"]').val()){
					amendList.push({
						action : 'REPLACE',
						content : $(field).val()
					})
				}
				
			});
			
			$.each(deleteFields, function(i, field){
				if($('textarea[id="${fields}_originalmsg_history"]').val().indexOf($(field).val())>-1 && $(field).val() != ''){ 
					amendList.push({
						action : 'DELETE',
						content : $(field).val()
					});
				} 
			});
			
			$.each(addFields, function(i, field){
				amendList.push({
					action : 'ADD',
					content : $(field).val()
				});
			});
			
			
			
			
			var obj = {
			    "tfapId": "${tfApplication.tfTransaction.tfTran.ttfId}",
			    "parentTfapId": "${tfApplication.tfTransaction.tfTran.tftRelatedTftId}",
			    "content": $('textarea[id="${fields}_originalmsg_amd"]').text(),
			    "amendList": amendList,
			    "fieldId":${fieldId1}
			}
			
			$.ajax({
                url:  "/TFAPortal/principleaccount/amend/text-area",
                dataType: 'json',
                type: 'post',
                contentType: 'application/json',
                data: JSON.stringify(obj),
                beforeSend: function(){
            		$('[id="modal_amd_msg_primary${fields}"]').attr('disabled', 'disabled');
                },
                success: function( data, textStatus, jQxhr ){
                    if(data.success){
                    	$('[id="${fieldName}"]').empty();
                    	$('[id="${fieldName}"]').val(data.data);
                    	initTextareaManipulator($('[id="${fieldName}"]'), $('[id="${fieldName}_char"]'), $('[id="${fieldName}_line"]'));

                    	evt = jQuery.Event("keypress");
                    	evt.which = 37; // left key
                    	$('[id="${fieldName}"]').trigger(evt);
                   	
                    	showSuccess${fields}(obj.amendList.length > 0);
                    	$('[id="${fields}modal"]').modal('hide');
                    }else{
                    	showSuccess${fields}(false);
                    }
                    
                    $('[id="modal_amd_msg_primary${fields}"]').removeAttr('disabled');
                },
                error: function( jqXhr, textStatus, errorThrown ){
                	showSuccess${fields}(false);
                	$('[id="modal_amd_msg_primary${fields}"]').removeAttr('disabled');
                }
            });
		}
		
		function showSuccess${fields}(success){
			if(success){
				$('[id="${fieldName}_success_msg"]').removeClass('d-none');
				$('[id="${fieldName}"]').removeClass('border-danger');
				$('[id="${fieldName}.errors"]').remove();
			}else{
				$('[id="${fieldName}_success_msg"]').addClass('d-none');
			}
		}
	});
</script>
<c:if test= "${requireDetails}">
<script>
	function initTextareaManipulator(textarea, charCountElem, lineCountElem){
		$(textarea).tfapTextareaManipulator({
			maxLines : ${maxLines},
			maxLengthOfLine : ${maxLengthOfLine},
			charCountElem : $(charCountElem),
			lineCountElem : $(lineCountElem)
		});
	}
	$(document).ready(function() {
		initTextareaManipulator($('[id="${fieldName}"]'), $('[id="${fieldName}_char"]'), $('[id="${fieldName}_line"]'));
	});
</script>
</c:if>