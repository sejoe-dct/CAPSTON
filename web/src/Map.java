public class Map {
    String CommID;
    String EventID;
    String userID;
    float lat;
    float lng;
    static float startLat;
    static float startLng;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getCommID() {
        return CommID;
    }

    public void setCommID(String commID) {
        CommID = commID;
    }

    public String getEventID() {
        return EventID;
    }

    public void setEventID(String eventID) {
        EventID = eventID;
    }

    public float getLat() {
        return lat;
    }

    public void setLat(float lat) {
        this.lat = lat;
    }

    public float getLng() {
        return lng;
    }

    public void setLng(float lng) {
        this.lng = lng;
    }

    public static float getStartLat() {
        return startLat;
    }

    public static void setStartLat(float startLat) {
        Map.startLat = startLat;
    }

    public static float getStartLng() {
        return startLng;
    }

    public static void setStartLng(float startLng) {
        Map.startLng = startLng;
    }
}
