import contrato.*

/*
 * Ahora Duenio (aka cliente, originalmente Aldo),
 * NO esta asociado al comportamiento de una sola persona,
 * representa al comportamiento general de todos los clientes de los 
 * contratistas, lo cual evita tener que modelar un objecto nuevo para cada
 * cliente que participe en el sistema 
 */

class Duenio inherits Sujeto {
	var nombre
	var ahorros
	var ppresupuesto = 20 // %
	var casa
	
	constructor(_nombre,_ahorros,_casa){
		nombre  = _nombre
		ahorros = _ahorros
		casa    = _casa
	}
	
	constructor(_nombre,_ahorros,_casa, _ppresupuesto){
		nombre      = _nombre
		ahorros     = _ahorros
		casa        = _casa
		ppresupuesto = _ppresupuesto
	}
	
	method nombre() = nombre
	
	method ahorros() = ahorros
	
	method ahorros(_ahorro){ahorros  = _ahorro}
	
	method ahorrar(_monto ){ahorros += _monto }
	
	method casa() = casa
	
	method presupuesto() {
		return ahorros * ppresupuesto / 100
	}
	
	method puedeContratar(_contratista){
		
		return (_contratista.darPresupuesto(casa)) <= (self.presupuesto())
		
	}
	
	method contratar(_contratista) {
		
		if (not self.puedeContratar(_contratista))
			throw new Exception("No le da el presupuesto para contratar") 
		
		const contrato = _contratista.serContratado(casa, self)
		
		contratos.add(contrato)
		
		ahorros -= contrato.monto()
	}
	
	method fueDescuidado() {
		return contratos.any {contrato => contrato.monto() > 5000}
	}
	
	method contratados() {
		return contratos.map { contrato => contrato.contratista() } .asSet()
	}
}

/**
 * Subclase para el caso de damian y personas con su mismo criterio
 */
class DuenioDespreocupado inherits Duenio {
	
	constructor(_nombre,_ahorros,_casa)               = super(_nombre,_ahorros,_casa)
	constructor(_nombre,_ahorros,_casa, _presupuesto) = super(_nombre,_ahorros,_casa, _presupuesto)
	
	override method fueDescuidado() {
		return (casa.pisos() < 3) && super()
	}
}

