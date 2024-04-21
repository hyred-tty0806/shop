<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>sample</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<style type="text/css">
.pagination-item {
	width: 38px;
	text-align: center;
}

.hhj-footer {
	height: 10vh;
}

.hhj-header {
	height: 10vh;
}

.hhj-main {
	height: 80vh;
}

.merriweather-bold {
	font-family: "Merriweather", serif;
	font-weight: 700;
	font-style: normal;
}
</style>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Jacquard+24&family=Jacquarda+Bastarda+9+Charted&family=Jersey+20+Charted&family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300;1,400;1,700;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Jersey+10&family=Roboto+Mono:ital,wght@0,100..700;1,100..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
	rel="stylesheet">
</head>
<body class="merriweather-bold">
	<div class="container-fluid ">
		<!-- Content here -->
		<div class="row">
			<div class="col-12 ">
				<!-- 최상단 -->
				<%@ include file="/common/shopMenu.jsp"%>
				<!-- 최상단 -->

				<!-- 콘텐츠 -->
				<div class="row">
					<!-- 메인콘텐츠 -->
					<div class="col mx-1 my-1">
						<div class="position-relative hhj-main">

							<div class="position-absolute top-50 start-50 translate-middle">
								<div class="row">
									<form action="/shop/shop/shopJoinAction.jsp" method="post">
										<div class="col-12">
											<div class="row mb-3">
												<div class="col-4">
													<label for="inputId">ID</label>
												</div>
												<div class="col-8">
													<input type="text" name="id" class="form-control"
														id="inputId">
												</div>
											</div>
											<div class="row mb-3">
												<div class="col-4">
													<label for="inputPassword" class="col col-form-label">Password</label>
												</div>
												<div class="col-8">
													<input type="password" name="pw" class="form-control"
														id="inputPassword">
												</div>
											</div>
											<div class="row mb-3">
												<div class="col-4">
													<label for="inputName">NAME</label>
												</div>
												<div class="col-8">
													<input type="text" name="name" class="form-control"
														id="inputId">
												</div>
											</div>
											<div class="row mb-3">
												<div class="col-4">
													<label for="inputBirth" class="col col-form-label">BIRTH</label>
												</div>
												<div class="col-8">
													<input type="date" name="birth" class="form-control"
														id="inputBirth">
												</div>
											</div>
											<div class="row mb-3">
												<div class="col-12 d-flex justify-content-evenly">
													<div class="form-check">
														<input class="form-check-input" type="radio"
															name="gender" value="남" id="gman"> 
														<label
															class="form-check-label" for="gman">
															MAN </label>
													</div>
													<div class="form-check">
														<input class="form-check-input" type="radio"
															name="gender" value="여" id="gw" checked>
														<label class="form-check-label" for="gw">
															WOMAN </label>
													</div>
												</div>
											</div>
											<div class="row mb-3">
												<div class="d-flex justify-content-center">
													<button type="submit" class="btn btn-light me-2">REGISTRATION</button>
													<a href="#" class="btn btn-light">BACK</a>
												</div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>

					</div>

				</div>
				<!-- 메인콘텐츠 -->
			</div>
			<!-- 콘텐츠 -->
			<!-- 최하단 -->
			<div class="row">
				<div class="col  mx-1 my-1 hhj-footer" style="height: 10vh;">bottom</div>
			</div>
		</div>
	</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
</body>
</html>
