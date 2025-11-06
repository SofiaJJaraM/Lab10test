Al intentar crear un droplet en DigitalOcean para desplegar la aplicación, la plataforma solicitó ingresar un método de pago. Se intentó añadir la tarjeta correspondiente, pero el sistema rechazó (más de una vez y con distintas tarjetas) la operación y mostró el mensaje de error: "Se produjo un error de procesamiento"

Por tanto, no fue posible crear el droplet ni obtener la dirección IP pública necesaria para continuar con los pasos de despliegue (instalación de Docker, configuración de Kamal, etc)

Registro de acciones realizadas:
- Se generó una clave SSH ed25519 local: `~/.ssh/id_ed25519_do` y se mostró la clave pública para importarla en DigitalOcean
- Se creó localmente una plantilla `docker-compose.production.yml`

