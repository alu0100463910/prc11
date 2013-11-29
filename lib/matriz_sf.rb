#require "matriz_sf/version"

module Matriz_sf
    class Matrix
        attr_reader :filas, :columnas
	#constructor clase Matrix
        def initialize(filas,columnas)
            @filas, @columnas = filas, columnas
        end
	def encontrar ()  
	  i,j=-1
	   @filas.times do |i|
                @columnas.times do |j|
		     if (self[i][j] != nil) 
		        if yield self[i][j]
			  return i,j
			end
		     end
		end
	   end
	  return i,j
	end

	#operador suma  +
        def +(o)
            raise ArgumentError, "Matrix size must be equal" unless @filas == o.filas && @columnas == o.columnas
            c = MatrizDensa.new(@filas, @columnas)
            @filas.times do |i|
                @columnas.times do |j|
                    if self[i][j] == nil && o[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && o[i][j] != nil
                        c[i][j] = o[i][j]
                    elsif self[i][j] != nil && o[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] + o[i][j]
                    end
                end
            end
            c
        end
	#operador resta -
        def -(o)
            raise ArgumentError, "Matrix size must be equal" unless @filas == o.filas && @columnas == o.columnas
            c = MatrizDensa.new(@filas, @columnas)
            @filas.times do |i|
                @columnas.times do |j|
                    if self[i][j] == nil && o[i][j] == nil
                        c[i][j] = 0
                    elsif self[i][j] == nil && o[i][j] != nil
                        c[i][j] = -o[i][j]
                    elsif self[i][j] != nil && o[i][j] == nil
                        c[i][j] = self[i][j]
                    else
                        c[i][j] = self[i][j] - o[i][j]
                    end
                end
            end
            c
        end
	#Operador multiplicacion
        def *(o)
            raise ArgumentError, "Columns and Rows must be equal" unless (@columnas == o.filas)
            c = MatrizDensa.new(@filas,o.columnas)
            @filas.times do |i|
                o.columnas.times do |j|
                    ac = 0
                    @columnas.times do |k|
                        ac += self[i][k] * o[k][j] if (self[i][k] != nil && o[k][j] != nil)
                    end
                    c[i][j] = ac
                end
            end
            c
        end
	#valor maximo de una matriz
        def max
            value = -9999
            @filas.times do |i|
                @columnas.times do |j|
                    if self[i][j] != nil && (self[i][j] > value)
                        value = self[i][j]
                    end
                end
            end
            value
        end
	#Valor minimo de una matriz
        def min
            value = 999
            @filas.times do |i|
                @columnas.times do |j|
                    if self[i][j] != nil && self[i][j] < value
                        value = self[i][j]
                    end
                end
            end
            value
        end
    end
    #clase matriz Densa. Representa una matriz de numeros reales 
    class MatrizDensa < Matrix
        attr_reader :data
	#constructor de la clase matriz densa en funcion de los parametros de entrada
	def initialize *arg
	  case arg.size
	    when 1
	      m=arg.pop
	      @data = m 
	      super(m[0].size, m.size)
	    when 2
	      filas, columnas = arg
	      @data = Array.new(filas) {Array.new(columnas)}
	      super(filas, columnas)
	    else
	      "error"
	  end
        end
	#operador de indexacion
        def [](i)
            @data[i]
        end
	#operador de indexacion y asignacion
        def []=(i,value)
            @data[i] = value
        end
	#se devuelve la traspuesta de una matriz
        def traspuesta()
            c = MatrizDensa.new(@columnas, @filas)
            c.filas.times do |i|
                c.columnas.times do |j|
                    c[i][j] = self[j][i]
                end
            end
            c
        end
        def x(value)
            self.filas.times do |i|
                self.columnas.times do |j|
                    self[i][j] *= 2
                end
            end
        end
    end
    #Clase vector disperso
    class VectorDisperso
        attr_reader :vector
        def initialize(h = {})
            @vector = Hash.new(0)
            @vector = @vector.merge!(h)
        end
        def [](i)
            @vector[i]
	end
        def []=(i,j)
            @vector[i]=j
        end
    end
    #Clase Matriz dispersa. Representa un amatriz dispersa
    class MatrizDispersa < Matrix
        attr_reader :data
        def initialize(filas,columnas, h = {})
            @data = Hash.new({})
            for k in h.keys do
                if h[k].is_a? VectorDisperso
                    @data[k] = h[k]
                else
                    @data[k] = VectorDisperso.new(h[k])
                end
            end
            super(filas,columnas)
        end
        def [](i)
            @data[i]
        end
    end
    #CLase Fraccion. Representa un numero fraccionario en formato decimal o fraccionario
    class Fraccion
        include Comparable

        attr_accessor :num, :denom
        def initialize(a, b)
            x = mcd(a,b)
            @num = a/x
            @denom = b/x
            if (@num < 0 && @denom < 0)
                @num = @num * -1
                @denom = @denom * -1
            end
            if (@denom < 0)
                @denom = @denom * -1
                @num = @num * -1
            end
        end
        def mcd(u, v)
           u, v = u.abs, v.abs
           while v != 0
              u, v = v, u % v
           end
           u
        end
        def to_s
            "#{@num}/#{@denom}"
        end
        def to_f
            @num.to_f/@denom.to_f
        end
        def +(o)
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                Fraccion.new(@num * c.denom + @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * o.denom + @denom * o.num, @denom * o.denom)
            end
        end
        def -(o)
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                Fraccion.new(@num * c.denom - @denom * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * o.denom - @denom * o.num, @denom * o.denom)
            end
        end
        def *(o)
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                Fraccion.new(@num * c.num, @denom * c.denom)
            else
                Fraccion.new(@num * o.num, @denom * o.denom)
            end
        end
        def /(o)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.      
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                Fraccion.new(@num * c.denom, @denom * c.num)
            else
                Fraccion.new(@num * o.denom, @denom * o.num)
            end        
        end
        # Metodo que realiza el modulo entre numeros fraccionales.
        def %(o)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.            
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                division = Fraccion.new(@num * c.denom, @denom * c.num)
            else
                division = Fraccion.new(@num * o.denom, @denom * o.num)
            end  
            division.num % division.denom
        end
        # Metodo que almacena el valor absoluto de un numero fraccional.
        def abs
            @num = @num.abs
            @denom = @denom.abs
        end
        # Metodo que realiza el reciproco de un numero fraccional.
        def reciprocal
            x = @num
            @num = @denom
            @denom = x
        end
        # Metodo que realiza el opuesto de un numero fraccional.
        def -@
            if (@num > 0)
                @num = @num * -1
            end
        end
        # Metodo que realiza comparaciones entre numeros fraccionales.
        def <=>(o)
           # return nil unless (o.instance_of? Fraccion) || (o.instance_of? Fixnum)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.            
            if o.instance_of? Fixnum
               # c = Fraccion.new(o,1)
               (self.num.to_f/self.denom.to_f) <=>  (o.to_f/1.0)
            else
	       (self.num.to_f/self.denom.to_f) <=> (o.num.to_f/o.denom.to_f) 
            end
        end
        def coerce(o)
            [Fraccion.new(o,1.0),self]
        end
    end
end








