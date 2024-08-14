module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('daisyui'),
    // ...
  ],
  daisyui: {
    themes: [
      "lemonade",
      {
        mytheme: {
          "primary": "#3730a3",
          "secondary": "#7dd3fc",
          "accent": "#c026d3",
          "neutral": "#f43f5e",
          "base-100": "#f5f5f4",
          "info": "#3b82f6",
          "success": "#86efac",
          "warning": "#fef08a",
          "error": "#fca5a5",
        },
      },
    ],
  },
}
