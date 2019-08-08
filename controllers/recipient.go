package controllers

import (
	"PaystackInterviewTest/models"
	"PaystackInterviewTest/utilities"
	"encoding/json"
	"fmt"

	"github.com/astaxie/beego"
)

// RecipientController operations for Recipient
type RecipientController struct {
	utilities.ExtendedBeegoController
}

func (c *RecipientController) URLMapping() {
	c.SetLanguange()
}

func (c *RecipientController) TransferRecipients() {
	sess := c.GetSession(beego.AppConfig.String("SessionName"))
	if sess == nil {
		c.Redirect("/account/login", 302)
		return
	}
	c.TplName = "recipient/recipient.tpl"

	viewData := make(map[string]interface{})

	viewTransferRecipients, err := utilities.MakeHTTPGet("transferrecipient")
	if err == nil {
		viewTransferRecipients.Data = make([]models.RecipientInfo, 0)
	}

	viewData["Recipients"] = viewTransferRecipients.Data

	userData := c.GetSession(beego.AppConfig.String("UserDetailSession"))
	c.Data["UserDetail"] = userData
	c.Data["TransferRecipients"] = viewData
}

func (c *RecipientController) ListTransferRecipients() {
	recipientList, err := utilities.MakeHTTPGet("transferrecipient")
	if err == nil {
		if recipientList.Status {
			c.Ctx.Output.SetStatus(201)
		} else {
			c.Ctx.Output.SetStatus(500)
		}
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: recipientList.Data, Status: recipientList.Status, Message: recipientList.Message}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *RecipientController) CreateTransferRecipient() {
	var v models.NewRecipientModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, "", "POST")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *RecipientController) UpdateTransferRecipient() {
	var v models.UpdateRecipientModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, v.Recipient_code_or_id, "PUT")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *RecipientController) DeleteTransferRecipient() {
	var v models.DeleteRecipientModel
	requestBodyBytes := c.ExtractRequestBody()
	if err := json.Unmarshal(requestBodyBytes, &v); err == nil {
		c.ProcessHttpRequest(&v, v.Recipient_code_or_id, "DELETE")
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *RecipientController) ListBanks() {
	bankList, err := utilities.MakeHTTPGet("bank")
	if err == nil {
		if bankList.Status {
			c.Ctx.Output.SetStatus(201)
		} else {
			c.Ctx.Output.SetStatus(500)
		}
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: bankList.Data, Status: bankList.Status, Message: bankList.Message}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
	c.ServeJSON()
}

func (c *RecipientController) ProcessHttpRequest(requestBody interface{}, recipientKey, httpVerb string) {
	fmt.Println("Here 0")
	fmt.Printf("%+v", requestBody)
	if result, err := utilities.MakeHTTPCall(requestBody, "transferrecipient/"+recipientKey, httpVerb); err == nil {
		if result.Status {
			c.Ctx.Output.SetStatus(201)
		} else {
			c.Ctx.Output.SetStatus(500)
		}
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: result, Status: result.Status, Message: result.Message}
	} else {
		c.Ctx.Output.SetStatus(500)
		c.Data["json"] = utilities.BaseHTTPResponseModel{Data: nil, Status: false, Message: err.Error()}
	}
}
