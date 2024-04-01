class Utils {
  Map<DateTime, List<DateTime>> transformDatetimesToMap(List<DateTime> fechas) {
    Map<DateTime, List<DateTime>> fechasPorDia = {};

    // Agrupar las fechas por día
    for (DateTime fecha in fechas) {
      DateTime fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);
      if (!fechasPorDia.containsKey(fechaSinHora)) {
        fechasPorDia[fechaSinHora] = [];
      }
      fechasPorDia[fechaSinHora]!.add(fecha);
    }

    // Seleccionar el primer elemento de cada día
    // List<DateTime> primerasFechasPorDia = [];
    // fechasPorDia.forEach((dia, fechas) {
    //   primerasFechasPorDia.add(fechas.first);
    // });

    return fechasPorDia;
  }
}