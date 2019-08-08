package utilities

import (
	"fmt"
	"io/ioutil"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"
)

type ExtendedBeegoController struct {
	beego.Controller
	Lang string
}

type langType struct {
	Lang string
	Name string
}

var langTypes = []*langType{}

// setLangVer sets site language version.
func (c *ExtendedBeegoController) SetLanguange() bool {
	isNeedRedir := false
	hasCookie := false

	// 1. Check URL arguments.
	lang := c.Input().Get("lang")

	// 2. Get language information from cookies.
	if len(lang) == 0 {
		lang = c.Ctx.GetCookie("lang")
		hasCookie = true
	} else {
		isNeedRedir = true
	}

	// Check again in case someone modify on purpose.
	if !i18n.IsExist(lang) {
		lang = ""
		isNeedRedir = false
		hasCookie = false
	}

	// 3. Get language information from 'Accept-Language'.
	if len(lang) == 0 {
		al := c.Ctx.Request.Header.Get("Accept-Language")
		if len(al) > 4 {
			al = al[:5] // Only compare first 5 letters.
			if i18n.IsExist(al) {
				lang = al
			}
		}
	}

	// 4. Default language is English.
	if len(lang) == 0 {
		lang = "en-US"
		isNeedRedir = false
	}

	curLang := langType{
		Lang: lang,
	}

	// Save language information in cookies.
	if !hasCookie {
		c.Ctx.SetCookie("lang", curLang.Lang, 1<<31-1, "/")
	}

	var langLength = len(i18n.ListLangs())

	fmt.Println(langLength - 1)

	restLangs := make([]*langType, 0, langLength-1)
	for _, v := range langTypes {
		if lang != v.Lang {
			restLangs = append(restLangs, v)
		} else {
			curLang.Name = v.Name
		}
	}

	// Set language properties.
	c.Lang = lang
	c.Data["Lang"] = curLang.Lang
	c.Data["CurLang"] = curLang.Name
	c.Data["RestLangs"] = restLangs

	return isNeedRedir
}

func (c *ExtendedBeegoController) ExtractRequestBody() []byte {
	requestBodyBytes, err := ioutil.ReadAll(c.Ctx.Request.Body)
	if err != nil {
		c.Ctx.Output.SetStatus(500)
		return make([]byte, 0)
	}
	return requestBodyBytes
}
