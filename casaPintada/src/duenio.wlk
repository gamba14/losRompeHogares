
class Duenio{
	var nombre
	var ahorros
	var ppresupuesto = 20 // %
	var casa
	
	var historial = []
	
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
		
		if (self.puedeContratar(_contratista))
			throw new Exception("No le da el presupuesto para contratar") 
		
		const contrato = _contratista.serContratado(casa, self)
		
		historial.add(contrato)
		
		ahorros -= contrato.monto()
	}
	
	
	method fueDescuidado() {
		return historial.any {contrato => contrato.monto() > 5000}
	}
}

/**
 * Subclase para el caso de damian
 */
class DuenioDespreocupado inherits Duenio {
	
	constructor(_nombre,_ahorros,_casa) = super(_nombre,_ahorros,_casa)
	constructor(_nombre,_ahorros,_casa, _presupuesto) = super(_nombre,_ahorros,_casa, _presupuesto)
	
	override method fueDescuidado() {
		return casa.pisos() < 3 && super()
	}
}

