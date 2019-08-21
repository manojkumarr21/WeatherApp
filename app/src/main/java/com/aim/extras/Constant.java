package com.aim.extras;

public class Constant {

    /** Constants values are here */

    public static class baseUrl{
        public final static String WEATHER_BASE_URL = "http://api.openweathermap.org/data/2.5/";
        public final static String WEATHER_IMAGE_BASE_URL = "https://openweathermap.org/img/w/";
    }

    public static class apiKeys{
//        public final static String WEATHER_API = "9b1861904f8426be4f0e37b7eb8dfd4c";
        public final static String WEATHER_API = "64dc8fb84c957b1fa4a0ec8fcd6e5319";
    }

    public static class defaultLatLng{

       static double lat,lng;

        public defaultLatLng(double lat,double lng) {
            this.lat = lat;
            this.lng = lng;
        }

//        public final static double DEFAULT_LAT = 23.7509;
//        public final static double DEFAULT_LNG =  90.3932;

        public final static double DEFAULT_LAT = lat;
        public final static double DEFAULT_LNG =  lng;
    }


}
