defmodule Taller do

  def main do
    matriz = [
      [1,2,3,4],
      [4,5,6,7],
      [9,4,6,7]
    ]

    # Corrección: Pasar funciones anónimas a Task.async
    task1 = Task.async(fn -> t1(matriz) end)
    task2 = Task.async(fn -> t2(matriz) end)

    # Obtener resultados
    a = Task.await(task1)
    b = Task.await(task2)

    c = s3(a, b)
    s4(c)
  end

  def t1(matriz) do
    recorrer_filas_abajo(matriz, 0)
  end

  defp recorrer_filas_abajo([], _indice), do: 0
  defp recorrer_filas_abajo([fila | resto], indice) do
    suma_fila = sumar_elementos_abajo(fila, 0, indice)
    suma_fila + recorrer_filas_abajo(resto, indice + 1)
  end

  defp sumar_elementos_abajo(_, pos, limite) when pos >= limite, do: 0
  defp sumar_elementos_abajo([], _, _), do: 0
  defp sumar_elementos_abajo([x | xs], pos, limite) do
    x + sumar_elementos_abajo(xs, pos + 1, limite)
  end

  def t2(matriz) do
    {suma, cantidad} = recorrer_filas_arriba(matriz, 0)
    if cantidad == 0, do: 0, else: suma / cantidad
  end

  defp recorrer_filas_arriba([], _indice), do: {0, 0}
  defp recorrer_filas_arriba([fila | resto], indice) do
    {suma_fila, cant_fila} = sumar_elementos_arriba(fila, 0, indice)
    {suma_resto, cant_resto} = recorrer_filas_arriba(resto, indice + 1)
    {suma_fila + suma_resto, cant_fila + cant_resto}
  end

  defp sumar_elementos_arriba([], _pos, _indice), do: {0, 0}
  defp sumar_elementos_arriba([x | xs], pos, indice) when pos > indice do
    {suma, cant} = sumar_elementos_arriba(xs, pos + 1, indice)
    {x + suma, 1 + cant}
  end
  defp sumar_elementos_arriba([_ | xs], pos, indice) do
    sumar_elementos_arriba(xs, pos + 1, indice)
  end

  def s3(a, b), do: a * b
  def s4(c), do: IO.puts(c)
end


Taller.main()
