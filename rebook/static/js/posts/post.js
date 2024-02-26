let favouriteButton = document.querySelector("#favouritesButton");

if (favouriteButton) {
    favouriteButton.changeTextToFavourite = function() {
        favouriteButton.innerText = "Remove from favourites";
    }

    favouriteButton.changeTextToNotFavourite = function() {
        favouriteButton.innerText = "Add to favourites";
    }

    favouriteButton.onclick = function() {
        fetch(favouriteButton.getAttribute("url"), {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "X-CSRFToken": getCookie("csrftoken")
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.favourite_status) {
                favouriteButton.changeTextToFavourite();
            }
            else {
                favouriteButton.changeTextToNotFavourite();
            }
        })
    }
}
