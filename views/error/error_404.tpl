{{ template "shared/layout_error.tpl" . }}

{{ define "mainPageTitle" }}
{{i18n .Lang "PageNotFoundTitle"}}
{{ end }}

{{ define "errorType" }}
404
{{ end }}

{{ define "errorDescription" }}
{{i18n .Lang "PageNotFoundDescription"}}
{{ end }}