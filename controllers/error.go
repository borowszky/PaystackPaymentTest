package controllers

import "PaystackInterviewTest/utilities"

// ErrorControllerController operations for ErrorController
type ErrorController struct {
	utilities.ExtendedBeegoController
}

func (c *ErrorController) URLMapping() {
	c.SetLanguange()
}

func (c *ErrorController) Error401() {
	c.TplName = "error/error_401.tpl"
}

func (c *ErrorController) Error403() {
	c.TplName = "error/error_404.tpl"
}

func (c *ErrorController) Error404() {
	c.TplName = "error/error_404.tpl"
}

func (c *ErrorController) Error500() {
	c.TplName = "error/error_500.tpl"
}

func (c *ErrorController) Error503() {
	c.TplName = "error/error_500.tpl"
}

func (c *ErrorController) ErrorDb() {
	c.TplName = "error/error_500.tpl"
}
