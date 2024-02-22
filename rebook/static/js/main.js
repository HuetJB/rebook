function getCookie(name) {
    for(let cookie of document.cookie.split(";")) {
        if (cookie.includes(name)) {
            return cookie.split("=")[1];
        }
    }

    return null;
}
