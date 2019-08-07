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
	<script src="/static/js/main/common.js"></script>
	<script src="/static/js/plugins/tables/datatables/datatables.min.js"></script>
	<script src="/static/js/plugins/tables/datatables/extensions/responsive.min.js"></script>
	<script src="/static/js/plugins/forms/selects/select2.min.js"></script>
	<script src="/static/js/plugins/forms/styling/uniform.min.js"></script>
	<script src="/static/js/plugins/notifications/sweet_alert.min.js"></script>

	<script src="/static/js/app.js"></script>
	<script src="/static/js/main/datatables_responsive.js"></script>
	<!-- /theme JS files -->

</head>

<body class="navbar-top">

	<!-- Main navbar -->
	<div class="navbar navbar-expand-md navbar-dark bg-indigo navbar-static fixed-top">
		<div class="navbar-brand">
			<a href="/recipients" class="d-inline-block">
				<img src="/static/img/logo_light.png" alt="">
			</a>
		</div>

		<div class="d-md-none">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-mobile">
				<i class="icon-tree5"></i>
			</button>
			<button class="navbar-toggler sidebar-mobile-main-toggle" type="button">
				<i class="icon-paragraph-justify3"></i>
			</button>
		</div>

		<div class="collapse navbar-collapse" id="navbar-mobile">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a href="#" class="navbar-nav-link sidebar-control sidebar-main-toggle d-none d-md-block">
						<i class="icon-paragraph-justify3"></i>
					</a>
				</li>
			</ul>

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

				<li class="nav-item dropdown dropdown-user">
					<a href="#" class="navbar-nav-link d-flex align-items-center dropdown-toggle" data-toggle="dropdown">
						<img src="{{.UserDetail.PictureUrl}}" class="rounded-circle mr-2" style="width:34px !important; height:34px !important" alt="">
						<span>{{.UserDetail.FirstName}} {{.UserDetail.LastName}}</span>
					</a>

					<div class="dropdown-menu dropdown-menu-right">
						<a href="/account/logout" class="dropdown-item"><i class="icon-switch2"></i> {{i18n .Lang "LayoutLogout"}}</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<!-- /main navbar -->


	<!-- Page content -->
	<div class="page-content">

		<!-- Main sidebar -->
		<div class="sidebar sidebar-light sidebar-main sidebar-fixed sidebar-expand-md">

			<!-- Sidebar mobile toggler -->
			<div class="sidebar-mobile-toggler text-center">
				<a href="#" class="sidebar-mobile-main-toggle">
					<i class="icon-arrow-left8"></i>
				</a>
				{{i18n .Lang "LayoutNavigation"}}
				<a href="#" class="sidebar-mobile-expand">
					<i class="icon-screen-full"></i>
					<i class="icon-screen-normal"></i>
				</a>
			</div>
			<!-- /sidebar mobile toggler -->


			<!-- Sidebar content -->
			<div class="sidebar-content">

				<!-- User menu -->
				<div class="sidebar-user-material">
					<div class="sidebar-user-material-body" style="background: url(/static/img/backgrounds/user_bg3.jpg) center center no-repeat;">
						<div class="card-body text-center">
							<a href="#">
								<img src="{{.UserDetail.PictureUrl}}" class="img-fluid rounded-circle shadow-1 mb-3" style="width:80px !important; height:80px !important" alt="">
							</a>
							<h6 class="mb-0 text-white text-shadow-dark">{{.UserDetail.FirstName}} {{.UserDetail.LastName}}</h6>
							<span class="font-size-sm text-white text-shadow-dark">{{.UserDetail.Email}}</span>
						</div>
													
						<div class="sidebar-user-material-footer">
							<a href="#user-nav" class="d-flex justify-content-between align-items-center text-shadow-dark dropdown-toggle" data-toggle="collapse"><span>{{i18n .Lang "LayoutNavigation"}}</span></a>
						</div>
					</div>

					<div class="collapse" id="user-nav">
						<ul class="nav nav-sidebar">
							<li class="nav-item">
								<a href="/account/logout" class="nav-link">
									<i class="icon-switch2"></i>
									<span>{{i18n .Lang "LayoutLogout"}}</span>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- /user menu -->


				<!-- Main navigation -->
				<div class="card card-sidebar-mobile">
					<ul class="nav nav-sidebar" data-nav-type="accordion">

						<!-- Main -->
                        <li class="nav-item-header"><div class="text-uppercase font-size-xs line-height-xs">{{i18n .Lang "LayoutMainLine"}}</div> <i class="icon-menu" title="{{i18n .Lang "LayoutMainLine"}}"></i></li>
						<li class="nav-item">
							<a href="/recipients" class="nav-link">
								<i class="icon-users4"></i>
								<span>{{i18n .Lang "LayoutMenuTransferBeneficiaries"}}</span>
							</a>
						</li>
						<li class="nav-item">
							<a href="/transfers" class="nav-link">
								<i class="icon-paperplane"></i>
								<span>{{i18n .Lang "LayoutMenuTransfer"}}</span>
							</a>
						</li>  
                   
						<!-- /main -->

					</ul>
				</div>
				<!-- /main navigation -->

			</div>
			<!-- /sidebar content -->
			
		</div>
		<!-- /main sidebar -->


		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Content area -->
			<div class="content">
            {{ block "content" . }}{{ end }}
			</div>
			<!-- /content area -->
			
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

		</div>
		<!-- /main content -->

	</div>
	<!-- /page content -->
	<script>
		var baseUrl = {{config "String" "internalApiBaseUrl" ""}}
	</script>
</body>
</html>
