package utilities

import (
	"fmt"
	"io/ioutil"
	"time"

	"github.com/astaxie/beego"
	"github.com/beego/i18n"
)

type ExtendedBeegoController struct {
	beego.Controller
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

func (c *ExtendedBeegoController) UpdateDaysAndMonthsToUserLocale() {
	time.LongDayNames = []string{
		i18n.Tr(c.Lang, "LongDayNameSunday"),
		i18n.Tr(c.Lang, "LongDayNameMonday"),
		i18n.Tr(c.Lang, "LongDayNameTuesday"),
		i18n.Tr(c.Lang, "LongDayNameWednesday"),
		i18n.Tr(c.Lang, "LongDayNameThursday"),
		i18n.Tr(c.Lang, "LongDayNameFriday"),
		i18n.Tr(c.Lang, "LongDayNameSaturday"),
	}
	for index := 0; index < len(time.LongDayNames); index++ {
		time.Days[index] = time.LongDayNames[index]
	}

	time.ShortDayNames = []string{
		i18n.Tr(c.Lang, "ShortDayNameSunday"),
		i18n.Tr(c.Lang, "ShortDayNameMonday"),
		i18n.Tr(c.Lang, "ShortDayNameTuesday"),
		i18n.Tr(c.Lang, "ShortDayNameWednesday"),
		i18n.Tr(c.Lang, "ShortDayNameThursday"),
		i18n.Tr(c.Lang, "ShortDayNameFriday"),
		i18n.Tr(c.Lang, "ShortDayNameSaturday"),
	}
	time.LongMonthNames = []string{
		i18n.Tr(c.Lang, "LongMonthNameJanuary"),
		i18n.Tr(c.Lang, "LongMonthNameFebruary"),
		i18n.Tr(c.Lang, "LongMonthNameMarch"),
		i18n.Tr(c.Lang, "LongMonthNameApril"),
		i18n.Tr(c.Lang, "LongMonthNameMay"),
		i18n.Tr(c.Lang, "LongMonthNameJune"),
		i18n.Tr(c.Lang, "LongMonthNameJuly"),
		i18n.Tr(c.Lang, "LongMonthNameAugust"),
		i18n.Tr(c.Lang, "LongMonthNameSeptember"),
		i18n.Tr(c.Lang, "LongMonthNameOctober"),
		i18n.Tr(c.Lang, "LongMonthNameNovember"),
		i18n.Tr(c.Lang, "LongMonthNameDecember"),
	}
	for index := 0; index < len(time.LongMonthNames); index++ {
		time.Months[index] = time.LongMonthNames[index]
	}
	time.ShortMonthNames = []string{
		i18n.Tr(c.Lang, "ShortMonthNameJanuary"),
		i18n.Tr(c.Lang, "ShortMonthNameFebruary"),
		i18n.Tr(c.Lang, "ShortMonthNameMarch"),
		i18n.Tr(c.Lang, "ShortMonthNameApril"),
		i18n.Tr(c.Lang, "ShortMonthNameMay"),
		i18n.Tr(c.Lang, "ShortMonthNameJune"),
		i18n.Tr(c.Lang, "ShortMonthNameJuly"),
		i18n.Tr(c.Lang, "ShortMonthNameAugust"),
		i18n.Tr(c.Lang, "ShortMonthNameSeptember"),
		i18n.Tr(c.Lang, "ShortMonthNameOctober"),
		i18n.Tr(c.Lang, "ShortMonthNameNovember"),
		i18n.Tr(c.Lang, "ShortMonthNameDecember"),
	}
}

func (c *ExtendedBeegoController) ExtractRequestBody() []byte {
	requestBodyBytes, err := ioutil.ReadAll(c.Ctx.Request.Body)
	if err != nil {
		c.Ctx.Output.SetStatus(500)
		return make([]byte, 0)
	}
	return requestBodyBytes
}
