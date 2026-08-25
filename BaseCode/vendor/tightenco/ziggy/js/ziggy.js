// Stub ziggy.js (thay thế file do `php artisan ziggy:generate` tạo ra)
window.Ziggy = {
  url: function () { return '/'; },
  route: function () { return '/'; },
  location: function () { return '/'; }
};
export const ZiggyVue = {
  install(app) {
    app.config.globalProperties.$ziggy = window.Ziggy;
  }
};
export default window.Ziggy;
