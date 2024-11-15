class Currency {
  final String codigo;
  final String nombre;
  final String unidadMedida;
  final DateTime fecha;
  final double valor;

  Currency({
    required this.codigo,
    required this.nombre,
    required this.unidadMedida,
    required this.fecha,
    required this.valor,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      codigo: json['codigo'] as String,
      nombre: json['nombre'] as String,
      unidadMedida: json['unidad_medida'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      valor: (json['valor'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nombre': nombre,
        'unidad_medida': unidadMedida,
        'fecha': fecha.toIso8601String(),
        'valor': valor,
      };
}
