# ClientFolderExample
Leer este documento para entender como funciona la estructura de las carpetas...

Estructura:


1)[NombreEmpresa]/Protocols: Aca voy a tener una carpeta por cada protocolo

2)[NombreEmpresa]/Protocols/[NombreProtocolo]:

  Acá vamos a encontrar 4 cosas:
  
    * Una carpeta llamada 'Missions': Dentro de esta carpeta vamos a tener una carpeta por cada 'mission' de ese tipo de 'protocolo'
    (Mas detalle de esto abajo).
        
    * Un archivo 'Index.JSON': Este Json contiene info del protocolo (EJ: Nombre con el q aparece en el menu, version, ultima actualizacion, etc)
    
    * Un archivo '[NombreProtocolo].lua': En este archivo se define la logica del protocolo.
    Implementa la siguiente interface: '[NombreProtocolo].Run(State)', donde 'State' es una 'table' de lua con el estado de una 'mission'
    
    * Assets varios que se utilizan en el protocolo (jpg, audios, luas, etc)
    
    
3)[NombreEmpresa]/Protocols/[NombreProtocolo]/Missions/[IDMission]:

    Acá vamos a encontrar 2 cosas:
    
     * Un archivo 'State.JSON': Este Json contiene el 'estado' de la 'mission'
     
     * Archivos varios asociados a esa mision en particular (Ej: Forms q el usuario lleno o fotos q sacó)
    
