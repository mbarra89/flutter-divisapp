class EconomicIndicatorModel {
  final int? id;
  final String codigo;
  final String nombre;
  final String descripcion;

  EconomicIndicatorModel({
    this.id,
    required this.codigo,
    required this.nombre,
    required this.descripcion,
  });

  // Constructor para convertir desde un mapa (útil para SQLite)
  factory EconomicIndicatorModel.fromMap(Map<String, dynamic> map) {
    return EconomicIndicatorModel(
      id: map['id'],
      codigo: map['codigo'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
    );
  }

  // Método para convertir el modelo a un mapa (útil para inserción en SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
