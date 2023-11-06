# ALOJAMINETOS RURALES

## Tablas 

-ALOJAMIENTOS(*nombre_alojamineto*, direccion, telefono, num_habitaciones, **codigo_personal**)

-PERSONAL(*codigo_personal*, nombre, apellidos, direccion, NIF, **nombre_alojamiento**)

-HABITACIONES(***nombre_alojamiento***, *numero_habitacion*, tipo, cuarto_baño, precio)

-ACTIVIDADES(*codigo_actividad*, nombre_actividad, descripcion, dificultad)

## Relaciones

```
ALOJAMIENTOS  __1__ TRABAJAN __M__ PERSONAL
                1              1

ALOJAMIENTOS __1__ TIENEN __M__ HABITACIONES
               1            1

ALOJAMIENTOS __1__ TIENEN __M__ ACTIVIDADES
               M            1
```