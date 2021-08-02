const weather = document.querySelector(".js-weather");
const API_key = "2f1ca957c177f235645e1af76a1d203e";

var latlon = [
	{city: '무안국제공항', lat:34.994155387639395, lon:126.3878557},
	{city: '광주공항', lat:35.139974329756754, lon:126.81095536908383},
	{city: '군산공항', lat:35.925966645573965, lon:126.6156633525841},
	{city: '여수공항', lat:34.840389933471336, lon:127.61403589791314},
	{city: '원주공항', lat:37.459453805966966, lon:127.9771644267999},
	{city: '양양국제공항', lat:38.059006275483654, lon:128.66291538263624},
	{city: '제주국제공항', lat:33.510547663872345, lon:126.49134266905355},
	{city: '김해국제공항', lat:35.17344286580726, lon:128.94639542878042},
	{city: '사천공항', lat:35.0926697246419, lon:128.08660265213248},
	{city: '울산공항', lat:35.59332819433661, lon:129.3556364844331},
	{city: '김포국제공항', lat:37.55886710617755, lon:126.79458118631851},
	{city: '포항공항', lat:35.984808365465355, lon:129.43390766910008},
	{city: '대구국제공항', lat:35.89966958799957, lon:128.63842951327422},
	{city: '청주국제공항', lat:36.722183271513536, lon:127.49585681144411}
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
		const weathers = json.weather[json.weather.length -1];
		const icon = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
			
		var current_weather = "";
		current_weather += "<div class=\"wea\">"+ region + "<br><img src=\'"+icon+"\''/><br>" + temperature  +"</div>"
		document.getElementById("js-weather").innerHTML += current_weather;
	});
}