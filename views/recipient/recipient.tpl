{{ template "shared/layout_home.tpl" . }}

{{ define "mainPageTitle" }}
{{i18n .Lang "LayoutMenuTransferBeneficiaries"}}
{{ end }}

{{ define "content"}}
        <div class="card">
            <div class="card-header header-elements-inline">
                <h4 class="card-title">{{i18n $.Lang "LayoutMenuTransferBeneficiaries"}}</h4>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal_addrecipient" > {{i18n $.Lang "ButtonAddNewRecipient"}}</button>
            </div>
            <div class="card-body">                  
                <table class="table datatable-responsive-row-control">
                    <thead>
                        <tr>
                            <th></th>
                            <th>{{i18n $.Lang "LocaleName"}}</th>
                            <th>{{i18n $.Lang "LocaleRecipientCode"}}</th>
                            <th>{{i18n $.Lang "LocaleBankName"}}</th>
                            <th>{{i18n $.Lang "LocaleAccountName"}}</th>
                            <th>{{i18n $.Lang "LocaleAction"}}</th>
                        </tr>
                    </thead>
                    <tbody>                                
                        {{range $key, $val := .TransferRecipients.Recipients}}
                            {{if eq $val.active true}}
                                <tr class="alpha-primary" onClick="showDetailsPrompt({{$val.recipient_code}})">
                                    <td></td>
                                    <td>{{$val.name}}</td>
                                    <td>{{$val.recipient_code}}</td>
                                    <td>{{$val.details.bank_name}}</td>
                                    <td>{{$val.details.account_number}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="showEditPromt({{$val}})" > {{i18n $.Lang "ButtonEdit"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}
                            {{if eq $val.active false}}
                                <tr class="alpha-danger" onClick="showDetailsPrompt({{$val.recipient_code}})">
                                    <td></td>
                                    <td>{{$val.name}}</td>
                                    <td>{{$val.recipient_code}}</td>
                                    <td>{{$val.details.bank_name}}</td>
                                    <td>{{$val.details.account_number}}</td>
                                    <td class="text-center">                       
                                        <button type="button" class="btn btn-primary" onClick="showDetailsPrompt({{$val}})" > {{i18n $.Lang "ButtonDetails"}}</button>                                        
                                    </td>
                                </tr>
                            {{end}}
                        {{end}}
                    </tbody>
                </table>
            </div>
        </div>
             
        <!-- Add New Recipient form modal --> 
        <div id="modal_addrecipient" class="modal fade" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{i18n $.Lang "ButtonAddNewRecipient"}}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <form method="post" onsubmit="event.preventDefault()">   
                        <div class="card-body"> 
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleType"}}</label>
                                        <select class="form-control select-fixed-single" id="new_recipient_type" data-fouc required>
                                            <optgroup label="{{i18n $.Lang "LocaleType"}}">
                                                <option value="nuban">Nuban</option>
                                                <option value="authorization">Authorization</option>
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleName"}}</label>
                                        <input type="text" id="new_recipient_name" placeholder="{{i18n $.Lang "LocaleName"}}" class="form-control" required>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleDescription"}}</label>
                                        <input type="text" id="new_recipient_desription" placeholder="{{i18n $.Lang "LocaleDescription"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleBankName"}}</label>
                                        <select class="form-control select-fixed-single" id="new_recipient_bankcode" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleBankName"}}">
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleAccountNumber"}}</label>
                                        <input type="text" id="new_recipient_accountnumber" placeholder="{{i18n $.Lang "LocaleAccountNumber"}}" class="form-control">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleAuthorizationCode"}}</label>
                                        <input type="text" id="new_recipient_authorizationcode" placeholder="{{i18n $.Lang "LocaleAuthorizationCode"}}" class="form-control">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group"><div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleCurrency"}}</label>
                                        <select class="form-control select-fixed-single" id="new_recipient_currency" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleCurrency"}}">
                                                <option value="NGN">{{i18n $.Lang "CurrencyNaira"}}</option>
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-8">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleMetadata"}}</label>
                                        <input type="text" id="new_recipient_metadata" placeholder="{{i18n $.Lang "LocaleMetadata"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-footer bg-white d-sm-flex justify-content-sm-between align-items-sm-center">
                            <div class="btn-group">
                            </div>
                            <div class="mt-2 mt-sm-0">
                                <button type="submit" id="submit_add_recipient" onClick="performAddNewRecipient()" class="btn bg-indigo-400"><i class="icon-checkmark3 mr-4"></i> {{i18n $.Lang "ButtonSave"}}</button>
                                <a type="button" href="/recipients" class="btn btn-light ml-3"><i class="icon-cross2 mr-4"></i> {{i18n $.Lang "ButtonCancel"}}</a>
                        </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- Add New Recipient form modal -->

        <!-- Edit Recipient form modal --> 
        <div id="modal_editrecipient" class="modal fade" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">{{i18n $.Lang "ButtonEditRecipient"}}</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <form method="post" onsubmit="event.preventDefault()">   
                        <div class="card-body"> 
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleType"}}</label>
                                        <input type="text" id="edit_recipient_code" style="display:none">
                                        <input type="text" id="edit_recipient_domain" style="display:none">
                                        <select class="form-control select-fixed-single" id="edit_recipient_type" data-fouc required>
                                            <optgroup label="{{i18n $.Lang "LocaleType"}}">
                                                <option value="nuban">Nuban</option>
                                                <option value="authorization">Authorization</option>
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleName"}}</label>
                                        <input type="text" id="edit_recipient_name" placeholder="{{i18n $.Lang "LocaleName"}}" class="form-control" required>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleDescription"}}</label>
                                        <input type="text" id="edit_recipient_description" placeholder="{{i18n $.Lang "LocaleDescription"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleBankName"}}</label>
                                        <select class="form-control select-fixed-single" id="edit_recipient_bankcode" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleBankName"}}">
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleCurrency"}}</label>
                                        <select class="form-control select-fixed-single" id="edit_recipient_currency" data-fouc>
                                            <optgroup label="{{i18n $.Lang "LocaleCurrency"}}">
                                                <option value="NGN">{{i18n $.Lang "CurrencyNaira"}}</option>
                                            </optgroup>
                                        </select>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleAccountNumber"}}</label>
                                        <input type="text" id="edit_recipient_accountnumber" placeholder="{{i18n $.Lang "LocaleAccountNumber"}}" class="form-control">
                                    </div>

                                </div>
                            </div>

                            <div class="form-group"><div class="row">
                                    <div class="col-md-12">
                                        <label class="font-weight-semibold">{{i18n $.Lang "LocaleMetadata"}}</label>
                                        <input type="text" id="edit_recipient_metadata" placeholder="{{i18n $.Lang "LocaleMetadata"}}" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-footer bg-white d-sm-flex justify-content-sm-between align-items-sm-center">
                            <div class="btn-group">
                            </div>
                            <div class="mt-2 mt-sm-0">
                                <button type="submit" id="submit_edit_recipient" onClick="performUpdateRecipient()" class="btn bg-indigo-400"><i class="icon-checkmark3 mr-4"></i> {{i18n $.Lang "ButtonSave"}}</button>
                                <a type="button" href="/recipients" class="btn btn-light ml-3"><i class="icon-cross2 mr-4"></i> {{i18n $.Lang "ButtonCancel"}}</a>
                        </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
        <!-- Edit Recipient form modal -->

        <script>
            $(function () {
                updateBankList();
                $("#new_recipient_bankcode").change();
                $("#edit_recipient_bankcode").change();
            });

            $('.select-fixed-single').select2({
                minimumResultsForSearch: Infinity,
                width: 250
            });
            
            function updateBankList(){
                $.ajax({
                    type: "GET",
                    url: baseUrl + "banks",
                    success: function(res) {
                    console.log(res);
                        bankSelectAdd = $("#new_recipient_bankcode")
                        bankSelectEdit = $("#edit_recipient_bankcode")
                        for (var i=0; i<res.Data.length; i++){
                            var opt = document.createElement('option')
                            opt.value = res.Data[i].code
                            opt.innerHTML = res.Data[i].name
                            bankSelectAdd.append(opt)
                        }
                        for (var i=0; i<res.Data.length; i++){
                            var opt = document.createElement('option')
                            opt.value = res.Data[i].code
                            opt.innerHTML = res.Data[i].name
                            bankSelectEdit.append(opt)
                        }
                    },
                    error: function(res) {
                    console.log(res);
                    return null
                    }
                });                
            }

            function performAddNewRecipient() {
                light_4 = $("#modal_addrecipient");
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
                        type:$("#new_recipient_type").val(),
                        name:$("#new_recipient_name").val(),
                        description:$("#new_recipient_desription").val(),
                        bank_code:$("#new_recipient_bankcode").val(),
                        account_number:$("#new_recipient_accountnumber").val(),
                        currency:$("#new_recipient_currency").val(),
                        metadata:$("#new_recipient_metadata").val(),
                        authorization_code:$("#new_recipient_authorizationcode").val()
                    };
                    console.log(data)
                    makeHttpPost('recipient/create_recipient', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleAddRecipientSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, {{i18n $.Lang "LocaleAddRecipientErrorMessage"}})
            };
            
            function showEditPromt(e) {
                var Name = document.getElementById("edit_recipient_name");
                Name.value = e.name;
                var Description = document.getElementById("edit_recipient_description");
                Description.value = e.description;
                var AccountNumber = document.getElementById("edit_recipient_accountnumber");
                AccountNumber.value = e.details.account_number;
                var Domain = document.getElementById("edit_recipient_domain");
                Domain.value = e.domain;
                var Metadata = document.getElementById("edit_recipient_metadata");
                Metadata.value = e.metadata;
                $("#edit_recipient_type").val(e.type.toString()).change()
                $("#edit_recipient_currency").val(e.currency.toString()).change()
                $("#edit_recipient_bankcode").val(e.details.bank_code.toString()).change()
                var Code = document.getElementById("edit_recipient_code");
                Code.value = e.recipient_code;
                $('#modal_editrecipient').modal('show');
            };
            
            function performUpdateRecipient() {
                light_4 = $('#modal_editrecipient');
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
                    recipient_code_or_id:$("#edit_recipient_code").val(),
                    domain:$("#edit_recipient_domain").val(),
                    type:$("#edit_recipient_type").val(),
                    currency:$("#edit_recipient_currency").val(),
                    name:$("#edit_recipient_name").val(),
                    details:{
                        account_number:$("#edit_recipient_accountnumber").val(),
                        bank_code:$("#edit_recipient_bankcode").val()
                    },
                    metadata:$("#edit_recipient_metadata").val(),
                    description:$("#edit_recipient_description").val(),
                };
                console.log(data)
                makeHttpPost('recipient/update_recipient', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleUpdateRecipientSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, {{i18n $.Lang "LocaleUpdateRecipientErrorMessage"}})
            };

            function showDeletePromt(e) {
                console.log(e)
                light_4 = $(this).closest('.card');
                        $(light_4).block({
                            message: '<i class="icon-spinner4 spinner"></i>',
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

                // Initialize
                swalInit({
                    title: {{i18n $.Lang "DeleteRecipientTitle"}},
                    text: {{i18n $.Lang "DeleteRecipientMessage"}},
                    showCancelButton: true,
                    inputClass: 'form-control',
                    }).then(function(result) {
                        if(result.value) {
                            var data = {
                                recipient_code_or_id: e
                                };
                            makeHttpPost('recipient/delete_recipient', data, {{i18n $.Lang "LocaleSuccessTitle"}}, {{i18n $.Lang "LocaleDeleteRecipientSuccessMessage"}}, {{i18n $.Lang "LocaleErrorTitle"}}, {{i18n $.Lang "LocaleDeleteRecipientErrorMessage"}})
                        }
                 });
            };
        
        </script>
{{end}}