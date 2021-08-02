	const weather = document.querySelector(".js-weather");
	const API_key = "2f1ca957c177f235645e1af76a1d203e";
	const COORDS = "coords";

	init();

	function init() {
	  loadCoords();
	}

	function loadCoords() {
		const loadedCoords = localStorage.getItem(COORDS); // localStorage에서 위치정보 가져옴
		if (loadedCoords === null) { // 위치 정보가 없으면
			askForCoords(); // 위치 정보 요청 함수
		} else {
			const parseCoords = JSON.parse(loadedCoords); // json형식을 객체 타입으로 바꿔서 저장
			getWeather(parseCoords.latitude, parseCoords.longitude); // 날씨 요청 함수
		}
	}

	
	function getWeather(lat, lon) {
		fetch(
			'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&appid=' + API_key + '&units=metric&lang=kr'
		)
		.then(function (response) { // .then = fetch가 완료 된 후 실행됨
			return response.json(); // json형태로 변환
		})
		.then(function (json) { 
			const temperature = json.main.temp; 
			const place = json.name;
	
	        const weathers = json.weather[json.weather.length -1];
	        const icon = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
			
			var current_weather = "";
			current_weather += "<div>현재 위치는 "+place+"입니다.</div>"
			current_weather += "<div>현재 온도는 "+temperature+"입니다.</div>"
			current_weather += "<img src=\'"+icon+"\''/>"
			document.getElementById("js-weather").innerHTML += current_weather;
		});
	}


	function askForCoords() { 
		navigator.geolocation.getCurrentPosition(success, error, options);
	}
	
	function success(pos) {
		var crd = pos.coords;
		
		const latitude = crd.latitude
		const longitude = crd.longitude
		const coordsObj = {
		  latitude,
		  longitude,
		};
		saveCoords(coordsObj); // localStorage에 저장 함수
	}
	
	function error(err) {
		console.warn(`ERROR(${err.code}): ${err.message}`);
	}

	var options = {
		enableHighAccuracy: true,
		timeout: 5000,
		maximumAge: 0
	};
	
	
	function saveCoords(coordsObj) { // localStorage에 저장
		  localStorage.setItem(COORDS, JSON.stringify(coordsObj));
	}