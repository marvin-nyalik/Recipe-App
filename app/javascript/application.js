// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function () {
  // Open Popup
  const openPopupButton = document.getElementById('open-popup');
  const recipePopup = document.getElementById('recipe-popup');

  openPopupButton.addEventListener('click', function () {
    recipePopup.classList.remove('hidden');
  });

  // Close Popup
  const closePopupButton = document.getElementById('close-popup');

  closePopupButton.addEventListener('click', function () {
    recipePopup.classList.add('hidden');
  });
});
