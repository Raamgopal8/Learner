document.addEventListener("DOMContentLoaded", function () {
  const totalTime = 60 * 60; // 10 minutes (in seconds)
  let remainingTime = totalTime;

  const display = document.getElementById("time-display");
  const progressBar = document.getElementById("timer-progress");
  const form = document.getElementById("test-form");

  function updateTimer() {
    const minutes = Math.floor(remainingTime / 60);
    const seconds = remainingTime % 60;
    display.textContent = `${minutes.toString().padStart(2, "0")}:${seconds
      .toString()
      .padStart(2, "0")}`;

    const progress = (remainingTime / totalTime) * 100;
    progressBar.style.width = `${progress}%`;

    if (remainingTime <= 0) {
      clearInterval(timer);
      alert("⏰ Time’s up! Submitting your answers...");
      form.submit();
    }

    remainingTime--;
  }

  updateTimer();
  const timer = setInterval(updateTimer, 1000);
});
