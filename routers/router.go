package routers

import (
	"PaystackInterviewTest/controllers"

	"github.com/astaxie/beego"
)

func init() {

	beego.Router("/account/login", &controllers.AccountController{}, "*:Login")
	beego.Router("/account/LoginPost", &controllers.AccountController{}, "*:LoginPost")
	beego.Router("/account/logout", &controllers.AccountController{}, "*:Logout")

	beego.Router("/", &controllers.RecipientController{}, "*:TransferRecipients")
	beego.Router("/recipients", &controllers.RecipientController{}, "*:TransferRecipients")
	beego.Router("/banks", &controllers.RecipientController{}, "*:ListBanks")
	beego.Router("/recipients/list_recipients", &controllers.RecipientController{}, "*:ListTransferRecipients")
	beego.Router("/recipient/create_recipient", &controllers.RecipientController{}, "*:CreateTransferRecipient")
	beego.Router("/recipient/update_recipient", &controllers.RecipientController{}, "*:UpdateTransferRecipient")
	beego.Router("/recipient/delete_recipient", &controllers.RecipientController{}, "*:DeleteTransferRecipient")

	beego.Router("/transfers", &controllers.TransferController{}, "*:ListTransfers")
	beego.Router("/transfer/list_transfers", &controllers.TransferController{}, "*:ListTransfers")
	beego.Router("/transfer/initiate_transfer", &controllers.TransferController{}, "*:InitiateTransfer")
	beego.Router("/transfer/fetch_transfer", &controllers.TransferController{}, "*:FetchTransfer")
	beego.Router("/transfer/finalize_transfer", &controllers.TransferController{}, "*:FinalizeTransfer")
	beego.Router("/transfer/bulk_transfer", &controllers.TransferController{}, "*:BulkTransfer")

	beego.Router("/transfer/check_balance", &controllers.TransferController{}, "*:CheckBalance")
	beego.Router("/transfer/resend_otp", &controllers.TransferController{}, "*:ResendOTPForTransfer")
	beego.Router("/transfer/enable_otp", &controllers.TransferController{}, "*:EnableOTPRequirementForTransfer")
	beego.Router("/transfer/disable_otp", &controllers.TransferController{}, "*:DisableOTPRequirementForTransfer")
	beego.Router("/transfer/finalize_disable_otp", &controllers.TransferController{}, "*:FinalizeDisableOTPRequirementForTransfer")

}
