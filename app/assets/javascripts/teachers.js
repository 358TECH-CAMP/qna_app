document.addEventListener("DOMContentLoaded", () => {
  const imgInput = document.getElementById('imgInput');
  const previewImg = document.getElementById('previewImg');

  // 画像プレビュー
  imgInput.addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = function(event) {
      previewImg.src = event.target.result;
      previewImg.style.display = 'block';
    };
    reader.readAsDataURL(file);
  });
});
