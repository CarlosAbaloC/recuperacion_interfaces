



//Es una clase comun para guardar todos los datos
import '../ob_firebase/Perfil.dart';

class DataHolder {
  static final DataHolder _dataHolder = new DataHolder._internal(); //Internal funciona como constructor
  String sCollection_Perfil_Name = "Perfil"; //Nombres de las colecciones

  String sMensaje = " ";
  Perfil perfil =Perfil();


  DataHolder._internal() {
    sMensaje ="Mensaje cambiado en DataHolder._internal";
  }

  /*
  void initPlatformAdminDisplaySetting(BuildContext context) {
    platformAdmin.initDisplayData(context);
  }
   */

  factory DataHolder() {
    return _dataHolder; //Data holder simpre devolvera la variable de arriba
  }

}