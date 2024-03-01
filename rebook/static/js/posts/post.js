let favouriteButton = document.querySelector("#favouritesButton");

if (favouriteButton) {
    favouriteButton.changeTextToFavourite = () => favouriteButton.innerText = "Remove from favourites";
    favouriteButton.changeTextToNotFavourite = () => favouriteButton.innerText = "Add to favourites";

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
            if (data.favourite_status) favouriteButton.changeTextToFavourite();
            else favouriteButton.changeTextToNotFavourite();
        })
    }
}

let imageIndex = 0;
let images = document.querySelectorAll("div#images img");
let previousButton = document.querySelector("div#images button#previous");
let nextButton = document.querySelector("div#images button#next");

function showImage(index) {
    if (index < 0 || index >= images.length) return;

    imageIndex = index;

    if (imageIndex <= 0) previousButton.style.display = "none";
    else previousButton.style.display = "block";

    if (imageIndex >= images.length - 1) nextButton.style.display = "none";
    else nextButton.style.display = "block";

    images.forEach(image => image.style.display = "none");

    images[imageIndex].style.display = "block";
}

showImage(imageIndex);

previousButton.onclick = () => showImage(imageIndex - 1);
nextButton.onclick = () => showImage(imageIndex + 1);
