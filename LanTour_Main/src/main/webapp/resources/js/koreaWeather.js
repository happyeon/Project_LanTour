		const weather = document.querySelector(".js-weather");
		const API_key = "2f1ca957c177f235645e1af76a1d203e";

		
		
		var latlon = [
			{city: '서울', lat:37.568779391877825, lon:126.97881017176033},
			{city: '인천', lat:37.459428662639844, lon:126.70540287037385},
			{city: '대전', lat:36.35479007682754, lon:127.38556879406704},
			{city: '대구', lat:35.876401130501556, lon:128.60074620601165},
			{city: '광주', lat:35.16938967514004, lon:126.84737597643871},
			{city: '부산', lat:35.181128419807166, lon:129.07488367545423},
			{city: '울산', lat:35.541316543882445, lon:129.3113221199205},
			{city: '세종특별자치시', lat:36.48252270642468, lon:127.28942764391785},
			{city: '경기도', lat:37.38908728533358, lon:127.46993816174404},
			{city: '강원도', lat:37.79668426525409, lon:128.31685750652235},
			{city: '충청북도', lat:36.90674089043434, lon:127.74415708634328},
			{city: '충청남도', lat:36.59057889387879, lon:126.81422934489969},
			{city: '경상북도', lat:36.50914762472446, lon:128.71761824667922},
			{city: '경상남도', lat:35.463270932165045, lon:128.2213331304243},
			{city: '전라북도', lat:35.74625989839409, lon:127.12753773951952},
			{city: '전라남도', lat:34.96642412807874, lon:127.0085846831903},
			{city: '제주도', lat:33.39863274316035, lon:126.56539244941348}
		]
		
		

	for (key in latlon) {
		const region = latlon[key].city;
		fetch(
			'https://api.openweathermap.org/data/2.5/weather?lat=' + latlon[key].lat + '&lon=' + latlon[key].lon + '&appid=' + API_key + '&units=metric&lang=kr'
		)
		.then(function (response) { // .then = fetch가 완료 된 후 실행됨
			return response.json(); // json형태로 변환
		})		
		.then(function (json) { 
			const temperature = json.main.temp; 
			//const region = latlon[key].city;
			//alert(region)
			const weathers = json.weather[json.weather.length -1];
			const icon = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
			
			var current_weather = "";
			current_weather += "<div class=\"wea\">"+ region + "<br><img src=\'"+icon+"\''/><br>" + temperature +"</div>"
			document.getElementById("js-weather").innerHTML += current_weather;
		});
		
		
	}
		
