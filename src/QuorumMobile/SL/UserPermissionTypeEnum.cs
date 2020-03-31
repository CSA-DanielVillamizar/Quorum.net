namespace QuorumMobile.SL
{

    /// <summary>
    /// Enum for control users permissions. Needs to be synchronized with db ids.
    /// Enum value = db id (UserPerTypeId).
    /// </summary>
    public enum UserPermissionTypeEnum
    {
        /// <summary>
        /// For non valid Enum when search for enum string value 
        /// </summary> 
        NoValidEnum = -1,


        // PERMISSIONS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO USUARIOS
        /// </summary>
        BINUMBER_ACCESO_USUARIOS = 1,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO ROLES
        /// </summary>
        BINUMBER_ACCESO_ROLES = 2,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO DASHBOARD DIARIO
        /// </summary>
        BINUMBER_ACCESO_DASHBOARD_DIARIO = 3,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO DASHBOARD EST NUM APOSTADOS
        /// </summary>
        BINUMBER_ACCESO_DASHBOARD_EST_NUM_APOSTADOS = 4,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO DASHBOARD PREMIACION
        /// </summary>
        BINUMBER_ACCESO_DASHBOARD_PREMIACION = 5,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO GRID PREMIOS
        /// </summary>
        BINUMBER_ACCESO_GRID_PREMIOS = 20,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO CONSULTAS PREGENERADAS
        /// </summary>
        BINUMBER_ACCESO_CONSULTAS_PREGENERADAS = 21,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO CONSULTAS DIARIAS
        /// </summary>
        BINUMBER_ACCESO_CONSULTAS_DIARIAS = 22,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO DISTRIBUCION NORMAL VENTAS
        /// </summary>
        BINUMBER_ACCESO_DISTRIBUCION_NORMAL_VENTAS = 23,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO DISTRIBUCION NORMAL PREMIOS
        /// </summary>
        BINUMBER_ACCESO_DISTRIBUCION_NORMAL_PREMIOS = 24,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO ESTADISTICAS POR NUMERO
        /// </summary>
        BINUMBER_ACCESO_ESTADISTICAS_POR_NUMERO = 25,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO ESTADISTICAS RESULTADOS
        /// </summary>
        BINUMBER_ACCESO_ESTADISTICAS_RESULTADOS = 26,

        /// <summary>
        /// PERMISSION FOR CAT.(1) BINUMBER, ACCESO PREMIOS RANGOS
        /// </summary>
        BINUMBER_ACCESO_PREMIOS_RANGOS = 27,



    }


}