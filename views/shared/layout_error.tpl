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
	<script src="/static/js/layout_error/app.js"></script>
	<!-- /theme JS files -->

</head>

<body>

	<!-- Page content -->
	<div class="page-content">

		<!-- Main content -->
		<div class="content-wrapper">

			<!-- Content area -->
			<div class="content d-flex justify-content-center align-items-center">

				<!-- Container -->
				<div class="flex-fill">

					<!-- Error title -->
					<div class="text-center mb-3">
						<h1 class="error-title">{{ block "errorType" . }}{{ end }}</h1>
						<h5>{{ block "errorDescription" . }}{{ end }}</h5>
					</div>
					<!-- /error title -->


					<!-- Error content -->
					<div class="row">
						<div class="col-xl-4 offset-xl-4 col-md-8 offset-md-2">					

							<!-- Buttons -->
							<div class="row">
									<a href="/recipients" class="btn btn-primary btn-block"><i class="icon-home4 mr-2"></i> Dashboard</a>
							</div>
							<!-- /buttons -->
							
						</div>
					</div>
					<!-- /error wrapper -->

				</div>
				<!-- /container -->

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

</body>
</html>
