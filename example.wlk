class Persona{
    var emociones = []
    var property edad

    method esAdolescente() = edad between(12,19)
    
    method agregarEmocion(emocion) // Esto es repetir mucha logica, pero si quiero tener una manera de poder agregar emociones de una manera sencilla y didactica en los tests, es lo que se me ocurrio
    {
        if(emocion == furia)
        {
            const anger = new Furia{intensidad = 100}
            emociones.add(anger)
        }       
        if(emocion == alegria)
        {
            const joy = new Alegria{intensidad = 60} // Parto del valor 60 de intensidad
            emociones.add(joy)
        }   
        if(emocion == tristeza)
        {
            const sadness = new Tristeza{intensidad = 90} // Parto del valor 90 de intensidad
            emociones.add(sadness)
        }
        if(emocion == desagrado)
        {
            const displeasure = new Desagrado{intensidad = 70} // Parto del valor 70 de intensidad
            emociones.add(displeasure)
        }      
        if(emocion == temor)
        {
            const fear = new Temor{intensidad = 30} // Parto del valor 30 de intensidad
            emociones.add(fear)
        }
    }

    method estaPorExplotar() = emociones.forEach{e => e.puedeLiberarse()}

    method vivirEvento(evento)
    {
        emociones.forEach(e => emocion.vivirEvento(evento))
    }

}

object grupoDePersonas // No se especifica mas de un grupo de personas, objeto entonces
{
    var personas = []

    method agregarPersona(persona)
    {
        personas.add(persona)
    }

    method hacerVivirEvento(evento)
    {
        personas.forEach{persona => persona.vivirEvento(evento)}
    }
}

class Evento 
{
    var property descripcion
    var property impacto
}

class Emocion
{
    var property intensidad
    var eventosVividos = 0

    method tieneIntensidadElevada() = intensidadElevada.valor() < intensidad

    method vivirEvento(evento)
    {
        cantEventos += 1
        if(self.puedeLiberarse())
        self.liberarse()
    }

    method liberarse()
    {
        intensidad -= evento.impacto()
    }
}

object intensidadElevada
{
    var property valor = 110 // De manera predeterminada el valor de la intensidad elevada esta seteado en 110

    method cambiar(nuevoValor)
    {
        intensidad = nuevoValor
    }
}


class Furia inherits Emocion
{
    var index = 0
    var palabrotas = []

    method puedeLiberarse() = self.tieneIntensidadElevada() and palabrotas.any(p => p.size() > 7)

    method aprenderPalabrota(palabrota)
    {
        palabrotas.add(palabrota)
    }
    
    method olvidarPalabrota(palabrota)
    {
        if(palabrotas.contains(palabrota))
        {
            index = palabrotas.indexOf(palabrota)
            palabrota.removeAt(index)
        }       
    }

    override method liberarse(evento)
    {
        super()
        palabrotas.removeAt(0)
    }

}

class Alegria inherits Emocion
{
    method puedeLiberarse() = self.tieneIntensidadElevada() and eventosVividos % 2 == 0

    override method liberarse()
    {
        super
        if(intensidad < 0)
        intensidad = intensidad * (-1)
    }
}

class Tristeza inherits Emocion
{
    var causa = melancolia

    method puedeLiberarse() = causa != melancolia and self.tieneIntensidadElevada()

    override method liberarse()
    {
        super()
        causa = evento.descripcion()
    }
}

class Desagrado inherits Emocion
{
    method puedeLiberarse() = self.tieneIntensidadElevada() and eventosVividos > intensidad   
}

class Temor inherits Desagrado // Hace exactamente lo mismo que Desagrado, no hace falta cambiar nada
{
}

class Ansiedad inherits Emocion
{
    var factorEstres = 0

    method puedeLiberarse() = self.tieneIntensidadElevada() and factorEstrés >= 5

    override method vivirEvento(evento)
    {
        super()
        if (evento.impacto() > 10)
            factorEstrés += 1
    }

    override method liberarse(evento)
    {      
        super()
        if(factorEstres > 0)
        factorEstres = factorEstres / 2 // Después de liberarse, el factor de estrés se reduce a la mitad (siempre que sea mayor a 0)
    }
}
/*
Polimorfismo fue util en todo el programa ya que permite mandar mensajes con un objeto que
se toma como "variable" y tecnicamete no se especifica cual es, pero si se conoce que debe
tener este metodo incluido. Por ejemplo:

method estaPorExplotar() = emociones.forEach{e => e.puedeLiberarse()}

Ahi fue clave el uso del polimorfismo ya que todas las emociones disponibles en nuestro 
programa entienden el mensaje puedeLiberarse(), lo que hace posible la utilizacion de la
sentencia e => e.puedeLiberarse().

Por otro lado, la herencia fue tambien muy util en todo el programa ya que me permitio
no tener que repetir logica en muchos aspectos de las emociones. Por ejemplo, sabemos
que todas las emociones tienen una intensidad, un metodo puedeLiberarse() y un metodo
liberarse(), por lo que simplemente puedo heredar estas caracteristicas desde unac clase 
Emocion, para todas las emociones. Si bien los metodos hacen cosas distintas en todas las 
emociones, pudesimplificar el hecho de tener que poner el metodo liberarse() cl completo, 
ya que muchas veces bastaba con un super e incluso a veces no hacia falta hacer un override.
*/
