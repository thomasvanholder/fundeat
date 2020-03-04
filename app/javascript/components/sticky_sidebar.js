const setWidth = () => {
  const sidebar = document.getElementById("sidebar")

  if (sidebar) {
    const width = sidebar.offsetWidth - 30
    const card = document.getElementById("card-fixed")
    card.style.width = `${width}px`;
  }
}

export { setWidth };
