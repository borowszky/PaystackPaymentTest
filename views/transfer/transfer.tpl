{{ template "shared/layout_home.tpl" . }}

{{ define "mainPageTitle" }}
{{i18n .Lang "LayoutMenuTransfer"}}
{{ end }}

{{ define "content"}}
        <div class="card">
            {{if .Transfers.isOTPEnabled}}
                <button type="button" class="btn btn-danger" style="width: 30%;align-self: center;" onClick="showDisableOTPPrompt()" > {{i18n $.Lang "ButtonDisableOTPRequirement"}}</button>
            {{end}}
            {{if .Transfers.isOTPDisabled}}
                <button type="button" class="btn btn-success" style="width: 30%;align-self: center;" onClick="showEnableOTPPrompt()" > {{i18n $.Lang "ButtonEnableOTPRequirement"}}</button>
            {{end}}
            <div class="card-header header-elements-inline">
                <h4 class="card-title">{{i18n $.Lang "LayoutMenuTransfer"}}</h4>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal_newtransfer" > {{i18n $.Lang "ButtonAddNewTransfer"}}</button>
            </div>

            <div class="card-body">                  
                <table class="table datatable-responsive-row-control">
                    <thead>
                        <tr>
                            <th></th>
                            <th>{{i18n $.Lang "LocaleName"}}</th>
                            <th>{{i18n $.Lang "LocaleTransferCode"}}</th>
                            <th>{{i18n $.Lang "LocaleAmount"}}</th>
                            <th>{{i18n $.Lang "LocaleDate"}}</th>
                            <th>{{i18n $.Lang "LocaleAction"}}</th>
                        </tr>
                    </thead>
                    <tbody> 
                        {{range $key, $val := .Transfers.TransfersList}}
                            {{if eq $val.status "success"}}
                                <tr class="alpha-success">
                                    <td></td>
                                    <td>{{$val.recipient.name}}</td>
                                    <td>{{$val.transfer_code}}</td>
                                    <td>({{$val.currency}}) {{$val.amount}}</td>
                                    <td>{{ExtractReadableDateTime $val.createdAt}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="FetchTransferDetail({{$val.transfer_code}})" > {{i18n $.Lang "ButtonDetails"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}
                            {{if eq $val.status "otp"}}
                                <tr class="alpha-primary">
                                    <td></td>
                                    <td>{{$val.recipient.name}}</td>
                                    <td>{{$val.transfer_code}}</td>
                                    <td>({{$val.currency}}) {{$val.amount}}</td>
                                    <td>{{ExtractReadableDateTime $val.createdAt}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="showResendOTPPromt({{$val.transfer_code}})" > {{i18n $.Lang "ButtonResendOTP"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}                                
                            {{if eq $val.status "pending"}}
                                <tr class="alpha-purple">
                                    <td></td>
                                    <td>{{$val.recipient.name}}</td>
                                    <td>{{$val.transfer_code}}</td>
                                    <td>({{$val.currency}}) {{$val.amount}}</td>
                                    <td>{{ExtractReadableDateTime $val.createdAt}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="FetchTransferDetail({{$val.transfer_code}})" > {{i18n $.Lang "ButtonDetails"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}
                            {{if eq $val.status "failed"}}
                                <tr class="alpha-warning">
                                    <td></td>
                                    <td>{{$val.recipient.name}}</td>
                                    <td>{{$val.transfer_code}}</td>
                                    <td>({{$val.currency}}) {{$val.amount}}</td>
                                    <td>{{ExtractReadableDateTime $val.createdAt}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="FetchTransferDetail({{$val}})" > {{i18n $.Lang "ButtonDetails"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}
                        {{end}}
                    </tbody>
                </table>
            </div>
        </div>

             
        <!-- Initiate transfer form modal --> 
        <div id="modal_newtransfer" class="modal fade" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{i18n $.Lang "ButtonAddNewTransfer"}}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <form method="post" onsubmit="event.preventDefault()">   
                        <div class="card-body"> 
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleSource"}}</label>
                                        <select class="form-control select-fixed-single" id="new_transfer_Source" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleSource"}}">
                                            </optgroup>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleCurrency"}}</label>
                                        <select class="form-control select-fixed-single" id="new_transfer_currency" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleCurrency"}}">
                                                <option value="NGN">{{i18n $.Lang "CurrencyNaira"}}</option>
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleAmount"}}</label>
                                        <input type="text" id="new_transfer_amount" placeholder="{{i18n $.Lang "LocaleAmount"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LayoutMenuTransferBeneficiary"}}</label>
                                        <select class="form-control select-fixed-single" id="new_transfer_beneficiary" data-fouc required>
                                            <optgroup label="{{i18n $.Lang "LayoutMenuTransferBeneficiary"}}">
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleReason"}}</label>
                                        <input type="text" id="new_transfer_reason" placeholder="{{i18n $.Lang "LocaleReason"}}" class="form-control" required>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleReference"}}</label>
                                        <input type="text" id="new_transfer_reference" placeholder="{{i18n $.Lang "LocaleReference"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-footer bg-white d-sm-flex justify-content-sm-between align-items-sm-center">
                            <div class="btn-group">
                            </div>
                            <div class="mt-2 mt-sm-0">
                                <button type="submit" id="submit_add_transfer" onClick="performInitiateTransfer()" class="btn bg-indigo-400"><i class="icon-checkmark3 mr-4"></i> {{i18n $.Lang "ButtonSend"}}</button>
                                <a type="button" href="/transfers" class="btn btn-light ml-3"><i class="icon-cross2 mr-4"></i> {{i18n $.Lang "ButtonCancel"}}</a>
                        </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- Initiate transfer form modal -->

        <!-- Resend transfer OTP form modal --> 
        <div id="modal_resendotp" class="modal fade" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{i18n $.Lang "LocaleResendOTP"}}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <form method="post" onsubmit="event.preventDefault()">   
                        <div class="card-body"> 
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleTransferCode"}}</label>
                                        <input type="text" id="resend_otp_transfer_code" readonly class="form-control">
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleReason"}}</label>
                                        <select class="form-control select-fixed-single" id="resend_otp_Reason" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleReason"}}">
                                                <option value="resend_otp">{{i18n $.Lang "LocaleResendOTP"}}</option>
                                                <option value="transfer">{{i18n $.Lang "LocaleTransfer"}}</option>
                                            </optgroup>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-footer bg-white d-sm-flex justify-content-sm-between align-items-sm-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-success" onClick="showOTPPrompt($('#resend_otp_transfer_code').val())" > {{i18n $.Lang "ButtonAlreadyHaveOTP"}}</button>                                        
                            </div>
                            <div class="mt-2 mt-sm-0">
                                <button type="submit" id="submit_add_transfer" onClick="performResendOTP()" class="btn bg-indigo-400"><i class="icon-checkmark3 mr-4"></i> {{i18n $.Lang "ButtonSend"}}</button>
                                <a type="button" href="/transfers" class="btn btn-light ml-3"><i class="icon-cross2 mr-4"></i> {{i18n $.Lang "ButtonCancel"}}</a>
                        </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- Resend transfer OTP form modal -->

        <!-- Transfer detailp form modal --> 
        <div id="modal_transferdetail" class="modal fade" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{i18n $.Lang "ButtonTransferDetails"}}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <div class="card-body">                            
                        
                            <div class="row">
                                <div class="col-md-4">
                                    <span class="font-weight-bold">{{i18n $.Lang "LocaleName"}}: </span> <span id="detail_recipient_name"></span> 
                                </div>

                                <div class="col-md-4">
                                    <span class="font-weight-bold">{{i18n $.Lang "LocaleDescription"}}: </span> <span id="detail_recipient_description"></span> 
                                </div>

                                <div class="col-md-4">
                                    <span class="font-weight-bold">{{i18n $.Lang "LocaleRecipientCode"}}: </span> <span id="detail_recipient_code"></span> 
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <span class="font-weight-bold">{{i18n $.Lang "LocaleSource"}}: </span> <span id="detail_transfer_source"></span> 
                                </div>

                                <div class="col-md-4">
                                   <span class="font-weight-bold">{{i18n $.Lang "LocaleAmount"}}: </span> (<span id="detail_transfer_currency"></span>) <span id="detail_transfer_amount"></span> 
                                </div>

                                <div class="col-md-4">
                                   <span class="font-weight-bold">{{i18n $.Lang "LocaleTransferCode"}}: </span> <span id="detail_transfer_code"></span> 
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-4">
                                    <span class="font-weight-bold">{{i18n $.Lang "LocaleReason"}}: </span> <span id="detail_transfer_reason"></span> 
                                </div>

                                <div class="col-md-4">
                                   <span class="font-weight-bold">{{i18n $.Lang "LocaleReference"}}: </span> <span id="detail_transfer_reference"></span> 
                                </div>

                                <div class="col-md-4">
                                   <span class="font-weight-bold">{{i18n $.Lang "LocaleDate"}}: </span> <span id="detail_transfer_date"></span> 
                                </div>
                            </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Transfer detailp form modal -->

        <script>
            var reciList;
            $(function () {
                fetchSourceList();
                fecthBeneficiariesList();
                $("#new_transfer_Source").change();
                $("#new_transfer_beneficiary").change();
            });
        
            $('.select-fixed-single').select2({
                minimumResultsForSearch: Infinity,
                width: 250
            });
            
            function fetchSourceList(){
                $.ajax({
                    type: "GET",
                    url: baseUrl + "transfer/check_balance",
                    success: function(res) {
                    console.log(res);
                        TransferSourceAdd = $("#new_transfer_Source")
                        for (var i=0; i<res.Data.length; i++){
                            var opt = document.createElement('option')
                            opt.value = "balance"
                            opt.innerHTML = "Balance - (" + res.Data[i].currency + ") " + res.Data[i].balance
                            TransferSourceAdd.append(opt)
                        }
                    },
                    error: function(res) {
                    console.log(res);
                    return null
                    }
                });                
            }
            
            function fecthBeneficiariesList(){
                $.ajax({
                    type: "GET",
                    url: baseUrl + "recipients/list_recipients",
                    success: function(res) {
                    console.log(res);
                    reciList = res
                        TransferBeneficiaryAdd = $("#new_transfer_beneficiary")
                        for (var b=0; b<res.Data.length; b++){
                            if(res.Data[b].active == true){
                                var opt = document.createElement('option')
                                opt.value = res.Data[b].recipient_code
                                opt.innerHTML = res.Data[b].name + " (" + res.Data[b].details.bank_name + ")"
                                TransferBeneficiaryAdd.append(opt)
                            }
                        }
                    },
                    error: function(res) {
                    console.log(res);
                    return null
                    }
                });                
            }

            function performInitiateTransfer() {
                light_4 = $("#modal_newtransfer");
                    $(light_4).block({
                        message: '<i class=icon-spinner4 spinner></i>',
                        overlayCSS: {
                            backgroundColor: '#fff',
                            opacity: 0.8,
                            cursor: 'wait'
                        },
                        css: {
                            border: 0,
                            padding: 0,
                            backgroundColor: 'none'
                        }
                    });
                    var data = {
                        source:$("#new_transfer_Source").val(),
                        reason:$("#new_transfer_reason").val(),
                        amount:$("#new_transfer_amount").val(),
                        recipient:$("#new_transfer_beneficiary").val(),
                        reference:$("#new_transfer_reference").val()
                    };
                    console.log(data)
                    $('#modal_newtransfer').modal('hide');
                    makeTransferHttpPost('transfer/initiate_transfer', data)
            };

            function showResendOTPPromt(e) {
                var TransferCode = document.getElementById("resend_otp_transfer_code");
                TransferCode.value = e;
                $('#modal_resendotp').modal('show');
            };          

            function performResendOTP() {
                light_4 = $("#modal_resendotp");
                    $(light_4).block({
                        message: '<i class=icon-spinner4 spinner></i>',
                        overlayCSS: {
                            backgroundColor: '#fff',
                            opacity: 0.8,
                            cursor: 'wait'
                        },
                        css: {
                            border: 0,
                            padding: 0,
                            backgroundColor: 'none'
                        }
                    });
                    var data = {
                        transfer_code:$("#resend_otp_transfer_code").val(),
                        reason:$("#resend_otp_Reason").val()
                    };
                    console.log(data)
                    $('#modal_resendotp').modal('hide');
                    makeResendOTPHttpPost('transfer/resend_otp', data)
            };

            function FetchTransferDetail(e){
                console.log(e)
                var data = {
                    transfer_code: e,
                };
                makeFetchTransferPHttpPost("transfer/fetch_transfer", data)
            }

            function showSuccessPrompt(){
                swalInit({
                    title: {{i18n $.Lang "LocaleSuccessTitle"}},
                    text: {{i18n $.Lang "LocaleInitiateTransferSuccessMessage"}},
                    type: "success"
                });
                window.setTimeout(function() {
                document.location.reload();
                }, 1000);
            }
            
            function showPendingPrompt(){
                swalInit({
                    title: {{i18n $.Lang "LocalePendingTitle"}},
                    text: {{i18n $.Lang "LocaleInitiateTransferPendingMessage"}},
                    type: "info"
                });
                window.setTimeout(function() {
                document.location.reload();
                }, 1000);
            }

            function showFailedPrompt(){
                swalInit({
                        title: {{i18n $.Lang "LocaleErrorTitle"}},
                        text: {{i18n $.Lang "LocaleInitiateTransferErrorMessage"}},
                        type: "error"
                    });
            }

            function showOTPPrompt(e) {
                $('#modal_resendotp').modal('hide');

                console.log("transfer_code: " + e)
                swalInit({
                    title: {{i18n $.Lang "LocaleOtpTitle"}},
                    text: {{i18n $.Lang "LocaleInitiateTransferOtpMessage"}},
                    input: 'text',
                    inputPlaceholder: {{i18n $.Lang "LocaleEnterOTPPrompt"}},
                    showCancelButton: true,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    allowOutsideClick: false,
                    backdrop: false,
                    inputClass: 'form-control'
                    }).then(function(result) {
                        if(result.value) {
                            console.log(result.value)
                            var data = {
                                    transfer_code: e,
                                    otp: result.value
                                };
                            makeHttpPost('transfer/finalize_transfer', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleInitiateTransferSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, 'errorMessage')
                        }
                    });
            };

            function showEnableOTPPrompt(){
                swalInit({
                title: {{i18n $.Lang "ButtonEnableOTPRequirement"}},
                text: {{i18n $.Lang "LocaleEnableOTPRequirementText"}},
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: {{i18n $.Lang "ButtonYesEnableOTPRequirement"}},
                cancelButtonText: {{i18n $.Lang "ButtonNoEnableOTPRequirement"}},
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger',
                buttonsStyling: false
                }).then(function(result) {
                    if(result.value) {
                        var data = {transfer_code:""};
                        makeHttpPost('transfer/enable_otp', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleEnableOTPRequirementSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, 'errorMessage')
                    }
                });
            }
            
            function showFullDetailPrompt(e) {
                console.log(e)
                $("#detail_recipient_name").text(e.recipient.name)
                $("#detail_recipient_code").text(e.recipient.recipient_code)
                $("#detail_recipient_description").text(e.recipient.description)
                $("#detail_transfer_source").text(e.source)
                $("#detail_transfer_currency").text(e.currency)
                $("#detail_transfer_amount").text(e.amount)
                $("#detail_transfer_code").text(e.transfer_code)
                $("#detail_transfer_reason").text(e.reason)
                $("#detail_transfer_reference").text(e.reference)
                $("#detail_transfer_date").text(e.createdAt)
                $('#modal_transferdetail').modal('show');
            };

            function showDisableOTPPrompt(){
                swalInit({
                title: {{i18n $.Lang "ButtonDisableOTPRequirement"}},
                text: {{i18n $.Lang "LocaleDisableOTPRequirementText"}},
                type: 'warning',
                showCancelButton: true,
                confirmButtonText: {{i18n $.Lang "ButtonYesDisableOTPRequirement"}},
                cancelButtonText: {{i18n $.Lang "ButtonNoEnableOTPRequirement"}},
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger',
                buttonsStyling: false
                }).then(function(result) {
                    if(result.value) {
                        var data = {transfer_code:""};
                        makeDisableOTPHttpPost('transfer/disable_otp', data)
                    }
                });
            }

            function showDisableOTPFinalizePrompt() {
                swalInit({
                    title: {{i18n $.Lang "LocaleOtpTitle"}},
                    text: {{i18n $.Lang "LocaleDisableOtpRequirementMessage"}},
                    input: 'text',
                    inputPlaceholder: {{i18n $.Lang "LocaleEnterOTPPrompt"}},
                    showCancelButton: true,
                    allowEscapeKey: false,
                    allowEnterKey: false,
                    allowOutsideClick: false,
                    backdrop: false,
                    inputClass: 'form-control'
                    }).then(function(result) {
                        if(result.value) {
                            console.log(result.value)
                            var data = {
                                    otp: result.value
                                };
                            makeHttpPost('transfer/finalize_disable_otp', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleDisableOTPRequirementSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, 'errorMessage')
                        }
                    });
            };
var fetchres;
            function makeFetchTransferPHttpPost(url, data) {  
                $.ajax({
                type: "POST",
                url: baseUrl + url,
                processData: false,
                data: JSON.stringify(data),
                beforeSend: function(request) {
                    request.setRequestHeader("Content-Type", "application/json");
                },
                success: function(res) {
                    $(light_4).unblock();
                    fetchres = res
                    if(res.Status == true){
                        showFullDetailPrompt(res.Data)
                    }
                },
                error: function(res) {
                    $(light_4).unblock();
                    swalInit({
                        title: {{i18n $.Lang "LocaleErrorTitle"}},
                        text: res.responseJSON.Message,
                        type: "error"
                    });
                }
                });
            }

            function makeDisableOTPHttpPost(url, data) {  
                $.ajax({
                type: "POST",
                url: baseUrl + url,
                processData: false,
                data: JSON.stringify(data),
                beforeSend: function(request) {
                    request.setRequestHeader("Content-Type", "application/json");
                },
                success: function(res) {
                    $(light_4).unblock();
                    if(res.Status == true){
                        showDisableOTPFinalizePrompt()
                    }
                },
                error: function(res) {
                    $(light_4).unblock();
                    swalInit({
                        title: {{i18n $.Lang "LocaleErrorTitle"}},
                        text: res.responseJSON.Message,
                        type: "error"
                    });
                }
                });
            }

            function makeResendOTPHttpPost(url, data) {  
                $.ajax({
                type: "POST",
                url: baseUrl + url,
                processData: false,
                data: JSON.stringify(data),
                beforeSend: function(request) {
                    request.setRequestHeader("Content-Type", "application/json");
                },
                success: function(res) {
                    $(light_4).unblock();
                    if(res.Status == true){
                        showOTPPrompt(data.transfer_code)
                    }
                },
                error: function(res) {
                    $(light_4).unblock();
                    swalInit({
                        title: {{i18n $.Lang "LocaleErrorTitle"}},
                        text: res.responseJSON.Message,
                        type: "error"
                    });
                }
                });
            }

            function makeTransferHttpPost(url, data) {  
                $.ajax({
                type: "POST",
                url: baseUrl + url,
                processData: false,
                data: JSON.stringify(data),
                beforeSend: function(request) {
                    request.setRequestHeader("Content-Type", "application/json");
                },
                success: function(res) {
                    $(light_4).unblock();
                    if(res.Status == true && res.Data.Data.status == 'otp'){
                        showOTPPrompt(res.Data.Data.transfer_code)
                    }else if(res.Status == true && res.Data.Data.status == 'pending'){
                        showPendingPrompt()
                    }else if(res.Status == true && res.Data.Data.status == 'success'){
                        showSuccessPrompt()
                    }else if(res.Status == true && res.Data.Data.status == 'failed'){
                        showFailedPrompt()
                    }
                },
                error: function(res) {
                    $(light_4).unblock();
                    swalInit({
                        title: {{i18n $.Lang "LocaleErrorTitle"}},
                        text: res.responseJSON.Message,
                        type: "error"
                    });
                }
                });
            }
        
        </script>
{{end}}
