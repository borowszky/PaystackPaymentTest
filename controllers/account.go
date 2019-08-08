package controllers

import (
	"PaystackInterviewTest/models"
	"PaystackInterviewTest/utilities"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"
)

// AccountController operations for Account
type AccountController struct {
	utilities.ExtendedBeegoController
}

func (c *AccountController) URLMapping() {
	c.SetLanguange()
}

func (c *AccountController) Login() {
	sess := c.GetSession(beego.AppConfig.String("SessionName"))
	if sess != nil {
		c.Redirect("/recipients", 302)
		return
	}
	c.TplName = "account/login.tpl"
}

func (c *AccountController) LoginPost() {

	sess := c.GetSession(beego.AppConfig.String("SessionName"))
	if sess != nil {
		c.Redirect("/account/login", 302)
		return
	}

	flash := beego.NewFlash()
	c.TplName = "account/login.tpl"

	username := c.GetString("Username")
	password := c.GetString("Password")
	if len(username) == 0 || len(password) == 0 {
		c.Login()
	}
	//dataToPost := models.Agent{Username: username, Password: password}

	if username == "interviewAdmin" && password == "qwe123" {
		//Save Authentication token in session
		fullToken := beego.FullJwt{}
		fullToken.Token = "Token"
		fullToken.Expires = "Expires"
		c.SetSession(beego.AppConfig.String("SessionName"), fullToken)

		//Get Logged in user details and save in session
		//adminUserDetails := c.PerformHTTPGet("GetAdminUserDetail", "")

		var ExtractedadminUserDetails = models.AdminUserDetail{
			ID:                    1,
			FirstName:             "Interview",
			LastName:              "Admin",
			Gender:                "M",
			Email:                 "tettehkangniboris@gmail.com",
			Phone:                 "+233542782464",
			PictureUrl:            "/static/img/image.png",
			EmailVerificationDate: "date",
			PhoneVerificationDate: "date",
			CreationDate:          "date",
			CreatedBy:             "system",
			LastEditDate:          "date",
			LastEditedBy:          "",
			ActivationDate:        "date",
			DeactivationReason:    "",
			ActivatedBy:           "system",
			RoleName:              "admin",
			RoleID:                1,
			Username:              "interviewAdmin",
			LastLoginDate:         "date",
			LastPasswordResetDate: "date"}

		c.SetSession(beego.AppConfig.String("UserDetailSession"), ExtractedadminUserDetails)
		c.Redirect("/recipients", 302)
	} else {
		flash.Warning(i18n.Tr(c.Lang, "LoginFailedMessage"))
		flash.Store(&c.Controller)
		return
	}
}

func (c *AccountController) Logout() {
	sess := c.GetSession(beego.AppConfig.String("SessionName"))
	if sess != nil {
		c.DelSession(beego.AppConfig.String("SessionName"))
		c.DelSession(beego.AppConfig.String("UserDetailSession"))
	}
	c.Redirect("/account/login", 302)
	return
}
