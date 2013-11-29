require 'spec_helper'

describe Matriz_sf do
        before :each do
                @a = Matriz_sf::MatrizDensa.new(2,2)
                @a[0][0] = Matriz_sf::Fraccion.new(1,1)
                @a[0][1] = Matriz_sf::Fraccion.new(2,1)
                @a[1][0] = Matriz_sf::Fraccion.new(3,1)
                @a[1][1] = 4

                @b = Matriz_sf::MatrizDispersa.new(2,2,0 => { 0 => 1, 1 => 2})
        end

        describe "\n # Datos de las Matrices \n" do
                it "### las matrices tiene su numero de filas almacenadas" do
                        @a.filas.should eq(2)
                end

                it "### las matrices tiene su numero de columnas almacenadas" do
                        @a.columnas.should eq(2)
                end         
        end

        describe "\n # Operaciones con matrices densas" do
                describe "\n  ## Suma de matrices densas \n" do
                        it "### Se pueden sumar matrices del mismo tamano" do
                                c = Matriz_sf::MatrizDensa.new(2,2)

                                c[0][0] = 1
                                c[0][1] = 2
                                c[1][0] = 3
                                c[1][1] = 4

                                d = @a + c

                                d[0][0].should eq(2)
                                d[0][1].should eq(4)
                                d[1][0].should eq(6)
                                d[1][1].should eq(8)
                        end
                end
                describe "\n  ## Resta de matrices densas \n" do
                        it "### Se pueden restar matrices del mismo tamano" do
                                c = Matriz_sf::MatrizDensa.new(2,2)

                                c[0][0] = Matriz_sf::Fraccion.new(1,1)
                                c[0][1] = Matriz_sf::Fraccion.new(2,1)
                                c[1][0] = Matriz_sf::Fraccion.new(3,1)
                                c[1][1] = Matriz_sf::Fraccion.new(4,1)

                                d = @a - c

                                d[0][0].should eq(Matriz_sf::Fraccion.new(0,1))
                                d[0][1].should eq(Matriz_sf::Fraccion.new(0,1))
                                d[1][0].should eq(Matriz_sf::Fraccion.new(0,1))
                                d[1][1].should eq(Matriz_sf::Fraccion.new(0,1))
                        end
                end
                describe "\n  ## Multiplicacion de matrices densas \n" do
                        it "### Se pueden multiplicar dos matrices si el numero de columnas de la primera es igual al numero de de la segunda matriz" do
                                c = Matriz_sf::MatrizDensa.new(2,5)

                                c[0][0] = Matriz_sf::Fraccion.new(1,1)
                                c[0][1] = Matriz_sf::Fraccion.new(2,1)
                                c[0][2] = Matriz_sf::Fraccion.new(3,1)
                                c[0][3] = Matriz_sf::Fraccion.new(4,1)
                                c[0][4] = Matriz_sf::Fraccion.new(5,1)
                                c[1][0] = Matriz_sf::Fraccion.new(6,1)
                                c[1][1] = Matriz_sf::Fraccion.new(7,1)
                                c[1][2] = Matriz_sf::Fraccion.new(8,1)
                                c[1][3] = Matriz_sf::Fraccion.new(9,1)
                                c[1][4] = Matriz_sf::Fraccion.new(10,1)

                                d = @a * c

                                d[0][0].should eq(Matriz_sf::Fraccion.new(13,1))
                                d[0][1].should eq(Matriz_sf::Fraccion.new(16,1))
                                d[0][2].should eq(Matriz_sf::Fraccion.new(19,1))
                                d[0][3].should eq(Matriz_sf::Fraccion.new(22,1))
                                d[0][4].should eq(Matriz_sf::Fraccion.new(25,1))
                                d[1][0].should eq(Matriz_sf::Fraccion.new(27,1))
                                d[1][1].should eq(Matriz_sf::Fraccion.new(34,1))
                                d[1][2].should eq(Matriz_sf::Fraccion.new(41,1))
                                d[1][3].should eq(Matriz_sf::Fraccion.new(48,1))
                                d[1][4].should eq(Matriz_sf::Fraccion.new(55,1))
                        end
				end
                describe "\n ## Opuesta de una matriz densa \n" do
                        it "### Se puede calcular la opuesta de una matriz densa" do
                                c = @a.traspuesta

                                c[0][0].should eq(1)
                                c[0][1].should eq(3)
                                c[1][0].should eq(2)
                                c[1][1].should eq(4)
                        end
                        it "### En el calculo de la matriz opuesta de una matriz se intercambian sus filas y columnas" do
                                c = Matriz_sf::MatrizDensa.new(2,5)

                                c[0][0] = Matriz_sf::Fraccion.new(1,1)
                                c[0][1] = Matriz_sf::Fraccion.new(2,1)
                                c[0][2] = Matriz_sf::Fraccion.new(3,1)
                                c[0][3] = Matriz_sf::Fraccion.new(4,1)
                                c[0][4] = Matriz_sf::Fraccion.new(5,1)
                                c[1][0] = Matriz_sf::Fraccion.new(6,1)
                                c[1][1] = Matriz_sf::Fraccion.new(7,1)
                                c[1][2] = Matriz_sf::Fraccion.new(8,1)
                                c[1][3] = Matriz_sf::Fraccion.new(9,1)
                                c[1][4] = Matriz_sf::Fraccion.new(10,1)

                                d = c.traspuesta

                                d.filas.should eq(5)
                                d.columnas.should eq(2)
                        end
                end
        end

        describe "\n # Calculo de valores maximos y minimos en una matriz \n" do
                it "### Se puede calcular el valor maximo de los elementos de una matriz" do
                        @a.max.should eq(4)
                end

                it "### Se puede calcular el valor minimo de los elementos de una matriz" do
                        @a.min.should eq(1)
                end
        end

        describe "\n # Operaciones con matrices dispersas \n" do
                it "### Sumar dos matrices dispersas" do
                        q = Matriz_sf::MatrizDispersa.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})
                        w = Matriz_sf::MatrizDispersa.new(2,2,0 => { 0 => 1, 1 => 2}, 1 => { 0 => 3, 1 => 4})
                        c = q + w
                        c[0][0].should eq(2)
                        c[0][1].should eq(4)
                        c[1][0].should eq(6)
                        c[1][1].should eq(8)
                end
        end

        describe "\n # Problema Propuesto \n" do
                it "Suma de una matriz densa y una matriz dispersa" do
		        f = Matriz_sf::MatrizDensa.new([[2,1],[-5, Matriz_sf::Fraccion.new(-3,2)]])
                        g = Matriz_sf::MatrizDispersa.new(2,2, 1 => {1 => 1})
                        h = f + g
                        h.filas.should eq(2)
                        h.columnas.should eq(2)
                        h[1][1].should eq(Matriz_sf::Fraccion.new(-1,2))
			h.data.inspect.should == "[[2, 1], [-5, -1/2]]"
                end
        end
	
	describe "\n # Problema Propuesto \n" do
                it "Probando Funcion Encontrar" do
		        f = Matriz_sf::MatrizDensa.new([[2,1],[5,2]])
			f.encontrar {|e| e*e>6}.should eq [1,0]
                end
        end
end

