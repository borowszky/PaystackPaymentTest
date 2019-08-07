{{ template "shared/layout_error.tpl" . }}

{{ define "mainPageTitle" }}
Internal server error
{{ end }}

{{ define "errorType" }}
505
{{ end }}

{{ define "errorDescription" }}
Oops, an error has occurred. Internal server error!
{{ end }}