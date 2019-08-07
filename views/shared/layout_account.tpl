<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>{{block "mainPageTitle" .}}{{end}}</title>

	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="/static/css/icons/icomoon/styles.min.css" rel="stylesheet" type="text/css">
	<link href="/static/css/layout_error/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="/static/css/layout_error/bootstrap_limitless.min.css" rel="stylesheet" type="text/css">
	<link href="/static/css/layout_error/layout.min.css" rel="stylesheet" type="text/css">
	<link href="/static/css/layout_error/components.min.css" rel="stylesheet" type="text/css">
	<link href="/static/css/layout_error/colors.min.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->

	<!-- Core JS files -->
	<script src="/static/js/main/jquery.min.js"></script>
	<script src="/static/js/main/bootstrap.bundle.min.js"></script>
	<script src="/static/js/plugins/loaders/blockui.min.js"></script>
	<script src="/static/js/plugins/ui/ripple.min.js"></script>
	<!-- /core JS files -->

	<!-- Theme JS files -->
	<script src="/static/js/plugins/forms/styling/uniform.min.js"></script>
	<script src="/static/js/notifications/jgrowl.min.js"></script>
	<script src="/static/js/notifications/noty.min.js"></script>
    <script src="/static/js/plugins/loaders/progressbar.min.js"></script>

	<script src="/static/js/layout_error/app.js"></script>
	<script src="/static/js/login/login.js"></script>
    <script src="/static/js/main/common.js"></script>
	<!-- /theme JS files -->

</head>

<body>

	<!-- Main navbar -->
	<div class="navbar navbar-expand-md navbar-dark bg-indigo navbar-static fixed-top">
		<div class="navbar-brand">
			<a href="/recipients" class="d-inline-block">
				<img src="/static/img/logo_light.png" alt="">
			</a>
		</div>

		<div class="d-md-none">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-mobile">
				<i class="icon-paragraph-justify3"></i>
			</button>
		</div>

		<div class="collapse navbar-collapse" id="navbar-mobile">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown language-switch">
					<a class="navbar-nav-link dropdown-toggle" data-toggle="dropdown"></a>
					<div class="dropdown-menu">
						<a onClick="setLanguage('en-US', '.english')" class="dropdown-item en-US">
							<img src="/static/img/lang/gb.png" class="img-flag" alt="">
							{{i18n .Lang "LanguageSelectEnglish"}}
						</a>
						<a onClick="setLanguage('fr-FR', '.french')" class="dropdown-item fr-FR">
							<img src="/static/img/lang/fr.png" class="img-flag" alt="">
							{{i18n .Lang "LanguageSelectFrench"}}
						</a>
					</div>
				</li>

			</ul>
		</div>
	</div>
	<!-- /main navbar -->

	<!-- Page content -->
	<div class="page-content">

		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Content area -->
			<div class="content d-flex justify-content-center align-items-center">
                {{ block "content" . }}{{ end }}
			</div>
			<!-- /content area -->

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
    
    <!-- Footer -->
    <div class="navbar navbar-expand-lg navbar-light">
        <div class="text-center d-lg-none w-100">
            <button type="button" class="navbar-toggler dropdown-toggle" data-toggle="collapse" data-target="#navbar-footer">
                <i class="icon-unfold mr-2"></i>
                {{i18n .Lang "FooterButton"}}
            </button>
        </div>

        <div class="navbar-collapse collapse" id="navbar-footer">
            <span class="navbar-text">
                &copy; 2019. <a href="#">{{i18n .Lang "FooterAPPName"}}</a> {{i18n .Lang "FooterBy"}} <a href="https://www.linkedin.com/tettehkangniboris" target="_blank">{{i18n .Lang "FooterCompanyName"}}</a>
            </span>
        </div>
    </div>
    <!-- /footer -->
    
    <script>
		var baseUrl = {{config "String" "internalApiBaseUrl" ""}}
        warningMessage = {{.flash.warning}}

        Noty.overrideDefaults({
            theme: 'limitless',
            layout: 'topRight',
            type: 'alert',
            timeout: 2500,
                callback:{
                    onShow: function(){
                        window.location.replace("/recipients")
                        }
                }
        });
		
        if (warningMessage != null && warningMessage.length > 0){
            new Noty({
                layout: 'bottom',
                text: warningMessage,
                type: 'warning'
            }).show();
            window.setTimeout(function () {
                window.location.replace("/account/login")
            }, 2500);
            warningMessage = ''
        }

        $('#btn_submit').on('click', function() {
            if($("#username").val().length > 0 && $("#password").val().length > 0 ){
            var light_4 = $(this).closest('.card');
            $(light_4).block({
                message: '<i class="icon-spinner4 spinner"></i>',
                overlayCSS: {
                    backgroundColor: '#fff',
                    opacity: 0.8,
                    cursor: 'wait'
                },
                css: {
                    border: 0,
                    padding: 0,
                    backgroundColor: 'none'
                }
            });
            window.setTimeout(function () {
                $(light_4).unblock();
            }, 5000);
            }
        });

    </script>

</body>
</html>