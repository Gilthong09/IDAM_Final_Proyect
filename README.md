# Defensa Civil RD - App Móvil

Aplicación móvil desarrollada en Flutter para la **Defensa Civil Dominicana**, enfocada en informar, conectar y apoyar a la comunidad a través de funciones como inicio de sesión, recuperación de contraseña, slider de imágenes institucionales y un apartado especial para los desarrolladores.

---

## 📲 Funcionalidades principales

- 🔐 **Inicio de sesión** con cédula y contraseña
- 🔄 **Recuperación de contraseña** mediante correo electrónico
- 🖼️ **Slider de inicio** con imágenes destacadas de las actividades institucionales
- 👨‍💻 **Página de desarrolladores** con acceso rápido a sus contactos
- 💡 **Diseño moderno**, accesible y responsivo

---

## 🛠️ Tecnologías utilizadas

- `Flutter` 3+
- `Dart`
- `Material Design`
- `url_launcher` (para llamadas y enlaces de Telegram)
- Arquitectura con `StatefulWidgets` y separación por características (`lib/features/`)

---

## 📁 Estructura del proyecto

```
lib/
├── features/
│   ├── auth/
│   │   ├── login_page.dart
│   │   └── auth_service.dart
│   ├── home/
│   │   └── slider_page.dart
│   └── about/
│       └── about_page.dart
├── main.dart
assets/
├── images/
├── about/
└── screenshots/
```

---

## 👨‍💻 Desarrolladores

| Nombre              | Teléfono       | Telegram                                |
|---------------------|----------------|------------------------------------------|
| Gilthong Palin       | +34 611 949 632| [@Gilthong](https://t.me/Gilthong)       |
| Eimi Rosalia         | +1 809 886 3715| [@eimirosalia](https://t.me/eimirosalia) |
| Enmanuel Lopéz       | +1 849 404 4912| [@EnmanuelLopez12](https://t.me/EnmanuelLopez12) |
| Juan Rosario         | +1 809 987 6543| [@JERB24](https://t.me/JERB24)           |
| Diorkys Cabrera      | +1 849 448 9562| [@diorkyscabrefa](https://t.me/diorkyscabrefa) |

---

## 📌 Notas adicionales

- Las imágenes se encuentran en la carpeta `assets/images/` y los avatares en `assets/about/`.
- El proyecto está preparado para expandirse con nuevos módulos y servicios.

---

## 🚀 Cómo correr la app

```bash
git clone https://github.com/Gilthong09/IDAM_Final_Proyect.git
cd defensa-civil-app
flutter pub get
flutter run
```

---

## 📄 Licencia

Este proyecto fue creado con fines educativos y comunitarios. Todos los derechos reservados a los autores mencionados.
