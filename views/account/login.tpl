{{ template "shared/layout_account.tpl" . }}

{{ define "mainPageTitle" }}
{{i18n .Lang "LoginPageTitle"}}
{{ end }}

{{ define "content" }}
	<!-- Login card -->
	<form class="login-form" action="LoginPost" controller="Accountcontroller" method="post">
		<div class="card mb-0">
			<div class="card-body">
				<div class="text-center mb-3">
					<i class="icon-reading icon-2x text-slate-300 border-slate-300 border-3 rounded-round p-3 mb-3 mt-1"></i>
					<h5 class="mb-0">{{i18n .Lang "LoginText"}}</h5>
					<span class="d-block text-muted">{{i18n .Lang "LoginCredential"}}</span>
				</div>

				<div class="form-group form-group-feedback form-group-feedback-left">
					<input type="text" id="username" name="Username" class="form-control" placeholder={{i18n .Lang "LoginUsername"}} required>
					<div class="form-control-feedback">
						<i class="icon-user text-muted"></i>
					</div>
				</div>

				<div class="form-group form-group-feedback form-group-feedback-left">
					<input type="password" id="password" name="Password" class="form-control" placeholder={{i18n .Lang "LoginPassword"}} required>
					<div class="form-control-feedback">
						<i class="icon-lock2 text-muted"></i>
					</div>
				</div>

				<div class="form-group d-flex align-items-center">
					<div class="form-check mb-0">
						<label class="form-check-label">
							<input type="checkbox" name="remember" class="form-input-styled" checked data-fouc>
							{{i18n .Lang "LoginRemember"}}
						</label>
					</div>

					<a href="/account/recover" class="ml-auto">{{i18n .Lang "LoginForgotPassword"}}</a>
				</div>

				<div class="form-group">
					<button type="submit" id="btn_submit" class="btn btn-primary btn-block">{{i18n .Lang "LoginSignIn"}} <i class="icon-circle-right2 ml-2"></i></button>
				</div>

				<span class="form-text text-center text-muted">{{i18n .Lang "LoginTandC1"}} <a href="#">{{i18n .Lang "LoginTandC2"}}</a> {{i18n .Lang "LoginTandC3"}} <a href="#">{{i18n .Lang "LoginTandC4"}}</a></span>
			</div>
		</div>
	</form>
	<!-- /login card -->
{{end}}