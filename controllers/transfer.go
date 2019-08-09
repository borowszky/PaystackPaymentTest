package controllers

import (
	"PaystackInterviewTest/models"
	"PaystackInterviewTest/utilities"
	"encoding/json"

	"github.com/astaxie/beego"
)

// TransferController operations for Transfer
type TransferController struct {
	utilities.ExtendedBeegoController
}

func (c *TransferController) URLMapping() {
	c.SetLanguange()
}

func (c *TransferController) InitiateTransfer() {
	var v models.NewTransferModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) ListTransfers() {
	sess := c.GetSession(beego.AppConfig.String("SessionName"))
	if sess == nil {
		c.Redirect("/account/login", 302)
		return
	}

	c.TplName = "transfer/transfer.tpl"

	viewData := make(map[string]interface{})

	viewTransfers, err := utilities.MakeHTTPGet("transfer")
	if err != nil {
		viewTransfers.Data = make([]models.TransferDetail, 0)
	}

	otpConfig := utilities.ReadFileContent(beego.AppConfig.String("OTPConfigFileUrl"))
	if otpConfig == "true" || otpConfig == "" {
		viewData["isOTPEnabled"] = "true"
	} else {
		viewData["isOTPDisabled"] = "true"
	}
	viewData["TransfersList"] = viewTransfers.Data

	userData := c.GetSession(beego.AppConfig.String("UserDetailSession"))
	c.Data["UserDetail"] = userData
	c.Data["Transfers"] = viewData
}

func (c *TransferController) FetchTransfer() {
	var v models.TransferCodeModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		transferDetail, err := utilities.MakeHTTPGet("transfer/" + v.Transfer_code)
		if err == nil {
			if transferDetail.Status {
				c.Ctx.Output.SetStatus(201)
			} else {
				c.Ctx.Output.SetStatus(500)
			}
			c.Data["json"] = utilities.BaseHTTPResponseModel{Data: transferDetail.Data, Status: transferDetail.Status, Message: transferDetail.Message}
		} else {
			c.Ctx.Output.SetStatus(500)
			c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
		}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) FinalizeTransfer() {
	var v models.FinalizeTransferModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "finalize_transfer", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) BulkTransfer() {
	var v models.BulkTransferModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) CheckBalance() {
	balanceDetail, err := utilities.MakeHTTPGet("balance")
	if err == nil {
		if balanceDetail.Status {
			c.Ctx.Output.SetStatus(201)
		} else {
			c.Ctx.Output.SetStatus(500)
		}
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: balanceDetail.Data, Status: balanceDetail.Status, Message: balanceDetail.Message}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) ResendOTPForTransfer() {
	var v models.ResendOTPForTransferModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "resend_otp", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) EnableOTPRequirementForTransfer() {
	var v models.TransferCodeModel
	c.ProcessHttpRequest(&v, "enable_otp", "POST")
	c.ServeJSON()
}

func (c *TransferController) DisableOTPRequirementForTransfer() {
	var v models.TransferCodeModel
	c.ProcessHttpRequest(&v, "disable_otp", "POST")
	c.ServeJSON()
}

func (c *TransferController) FinalizeDisableOTPRequirementForTransfer() {
	var v models.FinalizeDisableOTPRequirementForTransferModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "disable_otp_finalize", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *TransferController) ProcessHttpRequest(requestBody interface{}, relativeUrl, httpVerb string) {
	if result, err := utilities.MakeHTTPCall(requestBody, "transfer/"+relativeUrl, httpVerb); err == nil {
		if result.Status {
			c.Ctx.Output.SetStatus(201)
			if relativeUrl == "disable_otp_finalize" {
				utilities.WriteTextToFile(beego.AppConfig.String("OTPConfigFileUrl"), "false")
			} else if relativeUrl == "enable_otp" {
				utilities.WriteTextToFile(beego.AppConfig.String("OTPConfigFileUrl"), "true")
			}
		} else {
			c.Ctx.Output.SetStatus(500)
		}
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: result, Status: result.Status, Message: result.Message}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
}
