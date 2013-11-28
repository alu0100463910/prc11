#require "matriz_sf/version"

module Matriz_sf
    class Matrix
        attr_reader :filas, :columnas
        def initialize(filas,columnas)
            @filas, @columnas = filas, columnas
        end
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
        def max
            encontrado = false
            value = 0
            i = -1
            while encontrado == false
                i += 1
                j = 0
                while j < self.columnas
                    if self[i][j] != nil and value == 0
                        value = self[i][j]
                        encontrado = true
                        break
                    else
                        j += 1
                    end
                end
            end
            @filas.times do |i|
                @columnas.times do |j|
                    if self[i][j] != nil && self[i][j] > value
                        value = self[i][j]
                    end
                end
            end
            value
        end
        def min
            encontrado = false
            value = 0
            i = -1
            while encontrado == false
                i += 1
                j = 0
                while j < self.columnas
                    if self[i][j] != nil and value == 0
                        value = self[i][j]
                        encontrado = true
                        break
                    else
                        j += 1
                    end
                end
            end
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
    class MatrizDensa < Matrix
        attr_reader :data
	def initialize *arg
	  case arg.size
	    when 1
	    #  init_array *arg
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
        def [](i)
            @data[i]
        end
        def []=(i,value)
            @data[i] = value
        end
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
            return nil unless (o.instance_of? Fraccion) || (o.instance_of? Fixnum)
            # Comprobacion en caso de que el numero a sumar no sea fraccionario.            
            if o.instance_of? Fixnum
                c = Fraccion.new(o,1)
                (c.num.to_f/c.denom.to_f) <=> (self.num.to_f/self.denom.to_f)
            else
                (self.num.to_f/self.denom.to_f) <=> (o.num.to_f/o.denom.to_f)
            end
        end
        def coerce(o)
            [self,o]
        end
    end
end



