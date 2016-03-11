#!/bin/bash
##TEXTO DE CONFIGURACIONES DE ARCHIVOS
{
##smb.conf
: '
#Configurado a traves del script JOSJOS hecho por Marcos, Dario y Nicolas
[global]
	workgroup = INFORMATICA
	realm = INFORMATICA.CIFPAVILES.PA
	server string = %h server (Samba, Ubuntu)
	security = ADS
	map to guest = Bad User
	obey pam restrictions = Yes
	pam password change = Yes
	passwd program = /usr/bin/passwd %u
	passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
	unix password sync = Yes
	syslog = 0
	log file = /var/log/samba/log.%m
	max log size = 1000
	domain master = No
	dns proxy = No
	usershare allow guests = Yes
	panic action = /usr/share/samba/panic-action %d
	idmap uid = 10000-20000
	idmap gid = 10000-20000
	template shell = /bin/bash
	winbind enum users = Yes
	winbind enum groups = Yes
	winbind use default domain = Yes

[printers]
	comment = All Printers
	path = /var/spool/samba
	create mask = 0700
	printable = Yes
	browseable = No

[print$]
	comment = Printer Drivers
	path = /var/lib/samba/printers
    
'

##krb.conf

: '
#Configurado a traves del script JOSJOS hecho por Marcos, Dario y Nicolas
[libdefaults]
        default_realm = INFORMATICA.CIFPAVILES.PA

# The following krb5.conf variables are only for MIT Kerberos.
        krb4_config = /etc/krb.conf
        krb4_realms = /etc/krb.realms
        kdc_timesync = 1
        ccache_type = 4
        forwardable = true
        proxiable = true

# The following encryption type specification will be used by MIT Kerberos
# if uncommented.  In general, the defaults in the MIT Kerberos code are
# correct and overriding these specifications only serves to disable new
# encryption types as they are added, creating interoperability problems.
#
# Thie only time when you might need to uncomment these lines and change
# the enctypes is if you have local software that will break on ticket
# caches containing ticket encryption types it doesnt know about (such as
# old versions of Sun Java).

#       default_tgs_enctypes = des3-hmac-sha1
#       default_tkt_enctypes = des3-hmac-sha1
#       permitted_enctypes = des3-hmac-sha1

# The following libdefaults parameters are only for Heimdal Kerberos.
        v4_instance_resolve = false
        v4_name_convert = {
                host = {
                        rcmd = host
                        ftp = ftp
                }
                plain = {
                        something = something-else
                }
        }
        fcc-mit-ticketflags = true

[realms]

[login]
        krb4_convert = true
        krb4_get_tickets = false

'
##nsswitch.conf
: '
passwd:         compat winbind
group:          compat winbind
shadow:         compat

hosts:          files mdns4_minimal [NOTFOUND=return] dns mdns4
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis

'
##pam.d/common-account 
: '
account sufficient pam_winbind.so
account required pam_unix.so try_first_pass

'
##pam.d/common-auth
: '
auth sufficient pam_winbind.so
auth required pam_unix.so nullok_secure try_first_pass nullok_secure

'
##pam.d/common-password
: '
password sufficient pam_winbind.so
password required pam_unix.so nullok obscure min=4 max=8 md5 try_first_pass

'
##pam.d/common-session
: '
session required pam_mkhomedir.so skel=/etc/skel/ umask=0022
session sufficient pam_winbind.so
session required pam_unix.so try_first_pass

'

} 
if [ "$EUID" -ne 0 ]
  then echo "Por favor ejecute este script como root"
  exit
fi

echo "     ██╗ ██████╗ ███████╗     ██╗ ██████╗ ███████╗"
echo "     ██║██╔═══██╗██╔════╝     ██║██╔═══██╗██╔════╝"
echo "     ██║██║   ██║███████╗     ██║██║   ██║███████╗"
echo "██   ██║██║   ██║╚════██║██   ██║██║   ██║╚════██║"
echo "╚█████╔╝╚██████╔╝███████║╚█████╔╝╚██████╔╝███████║"
echo " ╚════╝  ╚═════╝ ╚══════╝ ╚════╝  ╚═════╝ ╚══════╝"
echo
echo "Bienvenido a JOSJOS, el asistente de integracion de sistemas Linux en Active Directory"
echo "█ █ █ Creado por Nicolas Seiz, Dario Garcia y Marcos Sobrino(oblop) █ █ █"
until [ "$BUCLEE" = 1 ]
    do
        echo
        echo "Seleccione la accion que desee realizar"
        MEN=("Integracion en AD" "Opciones de testeo" "Desintegracion AD" "Salir")
        select OPC in "${MEN[@]}"
        do
            case $OPC in
       
                "Integracion en AD")
                    {
        echo 'Asegurese antes de ejecutar este script que se ha realizando un apt-get update'
        echo '¿Desea realizarlo ahora?[s/N]'
        read -r UPDATE
        if [ "$UPDATE" = "S" ] ||  [ "$UPDATE" = "s"  ]
            then
                echo 'Actualizando'
                apt-get update -y > /dev/null
                echo 'actualizado'
        fi
        echo "Su hostname actual es este $HOSTNAME si realiza cambios en el despues de integrar esta maquina creara problemas de conectividad"
        echo '¿Esta seguro de que desea continuar?[S/n]'
        read -r CONT
        if [ "$CONT" = "N" ] ||  [ "$CONT" = "n" ]
            then 
                exit 0
            else

                #Tabla de contenido#

                echo
                echo "Tabla de ejemplo de informacion necesaria para la integracion:"
                echo
                #echo "Maquina a integrar: nombre corto    | busgosu                           |   ----------"
                #echo "Maquina a integrar: nombre largo    | busgosu.informatica.cifpaviles.pa |   ----------"
                #echo "Controlador de domino: nombre corto | telva                             |   ----------"
                echo "Controlador de domino: nombre largo | telva.informatica.cifpaviles.pa   |   ----------"
                echo "Dominio AD: nombre corto (NETBIOS)  | INFORMATICA                       |   ----------"
                echo "Dominio AD: nombre largo(DNS)       | informatica.cifpaviles.pa         |   ----------"
                echo "Reino Kerberos                      | INFORMATICA.CIFPAVILES.PA         |   ----------"
                echo "Usuario administrador del dominio   | administrador                     |   ----------"
                echo


                #Preguntas

                TECLA=""
                
                until  [ "$TECLA" = "S"  ] ||  [  "$TECLA" = "s"  ]

                    do
                        #Preguntas#

                        #echo "Maquina a integrar:nombre corto : "
                        #read -r CORTO
                        #echo "Maquina a integrar:nombre largo : "
                        #read -r LARGO
                        #echo "Controlador de domino: nombre corto : "
                        #read -r CDCORTO
                        echo "Controlador de domino: nombre largo : "
                        read -r CDLARGO
                        echo "Dominio AD: nombre corto (NETBIOS) : "
                        read -r NETBIOS
                        echo "Dominio AD: nombre largo(DNS) : "
                        read -r DNS
                        echo "Reino Kerberos : "
                        read -r KERBEROS
                        echo "Usuario administrador del dominio :"
                        read -r ADMIN

                        #Tabla completa#

                        echo
                        echo "Tabla de ejemplo de informacion necesaria para la integracion:"
                        echo
                        #echo "Maquina a integrar: nombre corto    | busgosu                           |   $CORTO"
                        #echo "Maquina a integrar: nombre largo    | busgosu.informatica.cifpaviles.pa |   $LARGO"
                        #echo "Controlador de domino: nombre corto | telva                             |   $CDCORTO"
                        echo "Controlador de domino: nombre largo | telva.informatica.cifpaviles.pa   |   $CDLARGO"
                        echo "Dominio AD: nombre corto (NETBIOS)  | INFORMATICA                       |   $NETBIOS"
                        echo "Dominio AD: nombre largo(DNS)       | informatica.cifpaviles.pa         |   $DNS"
                        echo "Reino Kerberos                      | INFORMATICA.CIFPAVILES.PA         |   $KERBEROS"
                        echo "Usuario administrador del dominio   | administrador                     |   $ADMIN"
                        echo
                        
                        #Fin Bucle

                        echo "Son correctos los datos?"
                        TECLA=""
                        until  [ "$TECLA" = "S"  ] ||  [  "$TECLA" = "s"  ] ||  [ "$TECLA" = "N" ] ||  [ "$TECLA" = "n" ]
                                do
                                    echo "Introduce S/N";
                                    read -r TECLA
                                done
                    done

                #instalaciones#

                echo 'Instalando samba'
                sudo apt-get install samba -y > /dev/null
                echo 'samba instalado'
                echo 'Creando backup archivo smb.conf'
                cp /etc/samba/smb.conf /etc/samba/smb.conf.bak 
                echo 'Backup realizada'
                
                echo 'Instalando utilidades samba'
                apt-get install samba-common-bin -y > /dev/null
                echo 'Instaladas'
                
                echo 'Instalando krb5-config'
                sed -n 48,87p "$0" > /etc/krb5.conf
                apt-get install krb5-config -y > /dev/null
                echo 'krb5-config instalado'
                echo 'Creando  backup krb5.conf'
                cp /etc/krb5.conf /etc/krb5.conf.bak
                echo 'Backup creado'
                
                echo 'Instalando krb5.conf'
                sed -i "3c\    default_realm = $KERBEROS" /etc/krb5.conf
                apt-get install krb5-user -y > /dev/null
                echo 'Instalado'
                
                echo 'Instalando winbind'
                apt-get install winbind -y > /dev/null
                echo 'Instalado'

                #configuracion smb.conf
                echo 'Configurando smb.conf'
                sed -n 6,42p "$0" > /etc/samba/smb.conf
                sed -i "3c\     workgroup = $NETBIOS" /etc/samba/smb.conf 
                sed -i "4c\     realm = $KERBEROS" /etc/samba/smb.conf
                echo 'Configurado'

                #configuracion krb5.conf
                echo 'Configurando krb5.conf'
                #bucle de reinos
                echo 'Escribe la palabra "fin" para finalizar la creacion de reinos'
                FIN=FIN
                fin=fin
                while true;
                    do
                        echo 'Nombre de nuevo reino'
                        read -r REINO
                        if [ $FIN = "$REINO" ] ||  [ $fin = "$REINO" ];
                            then 
                                break
                            else
                                {
                                echo " $REINO = { "
                                echo "          	kdc = $CDLARGO " 
                                echo "           	admin_server = $CDLARGO " 
                                echo -e "\n         default_domain = $DNS \n 				}"
                                } >> /etc/krb5.conf

                        fi
                    done
                {
                echo "[domain_realm]"
                echo ""
                echo "       .$DNS = $KERBEROS"
                echo "        $DNS = $KERBEROS"
                echo ""
                } >> /etc/krb5.conf
                sed -n 88,92p "$0" >> /etc/krb5.conf
                echo 'Configurado'

                echo 'Creando  backup nsswitch.conf'
                cp /etc/nsswitch.conf /etc/nsswitch.conf.bak
                echo 'Backup creado'
                echo 'Configurando nsswitch.conf'
                sed -n 96,109p "$0" > /etc/nsswitch.conf
                echo 'Configurado'
                
                echo 'Creando  backup archivos de pam'
                cp /etc/pam.d/common-account /etc/pam.d/common-account.bak
                cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
                cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
                cp /etc/pam.d/common-session /etc/pam.d/common-session.bak
                echo 'Backup creado'
                echo 'Configurando archivos de pam'
                sed -n 113,115p "$0" > /etc/pam.d/common-account
                sed -n 119,121p "$0" > /etc/pam.d/common-auth
                sed -n 125,127p "$0" > /etc/pam.d/common-password
                sed -n 131,134p "$0" > /etc/pam.d/common-session
                echo 'Configurados'
                
                echo 'Creacion de ticket kerberos'
                kinit "$ADMIN"@"$KERBEROS"
                echo 'Creado'
                
                echo 'Sincronizacion horaria con el controlador del dominio'
                net time set
                echo 'Sincronizado'

                echo 'Unión de host al dominio'
                net ads join '-U' "$ADMIN"@"$KERBEROS"
                echo 'Completado'
                
                echo 'Reiniciando servicios'
                service smbd restart
                echo 'Terminado'
                
                echo 'Se debera reiniciar el equipo para aplicar cambios'
                echo '¿Desea reiniciar?[s/N]'
                read -r REB
                    if [ "$REB" = "S" ] ||  [ "$REB" = "s"  ]
                        then 
                            reboot
                        else
                            break
                    fi

        fi
}
                    break
                    ;;
                 "Opciones de testeo")
                    {
                    until [ "$BUCLEE" = 1 ]
                        do
                            echo
                            echo "Selecciona una opcion de testeo"
                            opciones=("Lista usuarios AD" "Lista grupos AD" "Lista de usuarios de dominio" "Informacion general AD" "Salir")
                            select OPT in "${opciones[@]}"
                                do
                                    case $OPT in

                                        "Lista usuarios AD")
                                            echo "Lista usuarios AD"
                                            wbinfo -u  
                                            break
                                            ;;
                                         "Lista grupos AD")
                                            echo "Lista grupos AD"
                                            wbinfo -g  
                                            break
                                            ;;
                                        "Lista de usuarios de dominio")
                                            echo "Lista de usuarios de dominio"
                                            getent passwd
                                            break
                                            ;;
                                        "Informacion general AD")
                                            echo  "Informacion general AD"
                                            net ads info
                                            break
                                            ;;
                                        "Salir")
                                            break
                                            ;;
                                        *) echo "Opcion incorrecta"
                                            ;;
                                    esac
                                done  
                                break
                        done
                        }
                    break
                    ;;
                "Desintegracion AD")
                    {
                    echo "Nombre del dominio del que quiere salir :"
                    read -r REINOO
                    echo "Usuario administrador del dominio :"
                    read -r ADMINISTRADOR
                    echo "Desintegrando."
                    cp /etc/samba/smb.conf /etc/samba/smb.conf.bak"$REINOO"
                    cp /etc/krb5.conf /etc/krb5.conf.bak"$REINOO"
                    cp /etc/nsswitch.conf /etc/nsswitch.conf.bak"$REINOO"
                    net ads leave '-U' "$ADMINISTRADOR"@"$REINOO"
                    echo "Desintegrando.."
                    cp /etc/pam.d/common-account.bak /etc/pam.d/common-account
                    cp /etc/pam.d/common-auth.bak /etc/pam.d/common-auth
                    cp /etc/pam.d/common-password.bak /etc/pam.d/common-password
                    cp /etc/pam.d/common-session.bak /etc/pam.d/common-session
                    cp /etc/krb5.conf.bak /etc/krb5.conf
                    echo "Desintegrando..."
                    cp /etc/nsswitch.conf.bak /etc/nsswitch.conf
                    cp /etc/samba/smb.conf.bak /etc/samba/smb.conf
                    echo "¡Desintegrado Correctamente!"
                    echo 'Se debera reiniciar el equipo para aplicar cambios'
                    echo '¿Desea reiniciar?[s/N]'
                    read -r REBO
                        if [ "$REBO" = "S" ] ||  [ "$REBO" = "s"  ]
                            then 
                                reboot
                            else
                                break
                        fi
}
                    break
                    ;;
                "Salir")
                    exit 0
                    ;;
                *) echo "Opcion incorrecta"
                    ;;
            esac
        done
    done
    
