<%-- 
    Document   : admin
    Created on : 8 jun 2023, 19:25:53
    Author     : Juancarlos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <!-- bootstrap5 -->
        <link rel="stylesheet" href="bootstrap5/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <!-- mis estilos -->
        <link rel="stylesheet" href="estilos/admin.css"/>
        <script src="script/jquery-3.7.0.min.js"></script>
        <script src="script/admin.js"></script>
        <!-- datatables -->
        <link rel="stylesheet" href="datatables/datatables.min.css"/>
        <title>Admin</title>
    </head>
    <body>
        <div class="navPrincipal">
            <div>
                <img src="${sessionScope.datosUsuario.getFoto() != null ? sessionScope.datosUsuario.getFoto() : 'img/usuario.png'}" alt="Imagen de perfil" width="50px" height="46px" class="rounded-circle" />
            </div>
            <div>
                <span>PANEL ADMINISTRADOR</span>
            </div>
            <div>
                <ul>
                    <li class="">
                        <a class="" href="index.jsp">
                            <i class="bi bi-house"></i><span class="palabraIcono">Home</span>
                        </a>
                    </li>
                    <li class="">
                        <a class="" href="Cerrar_sesion">
                            <i class="bi bi-box-arrow-right"></i><span class="palabraIcono">Cerrar sesión</span>
                        </a>
                    </li>
                </ul>

            </div>
        </div>

        <div class="navSecundario">
            <button class="navButton" id="usuariosOpciones">
                <i class="bi bi-person-fill"></i>
                <span>Usuarios</span>
            </button>

            <button class="navButton" id="mensajesOpciones">
                <i class="bi bi-envelope-fill"></i>
                <span>Mensajes</span>
            </button>

            <button class="navButton" id="baneosOpciones">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>Baneos</span>
            </button>
        </div>

        <div style="width: 90%; margin: 40px auto;">
            <table id="tablaUsuarios" class="table table-striped" style="width: 100%;">

            </table>
        </div>


        <!-- bootstrap5 -->
        <script src="bootstrap5/js/bootstrap.bundle.min.js"></script>
        <!-- DATATABLES -->
        <script src="datatables/datatables.min.js"></script>  
    </body>
</html>
