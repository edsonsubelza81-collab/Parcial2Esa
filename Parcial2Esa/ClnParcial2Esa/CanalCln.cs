using CadParcial2Esa;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ClnParcial2Esa
{
    public class CanalCln
    {
        public static List<Canal> listar()
        {
            using (var context = new Parcial2EsaEntities1())
            {
                return context.Canal.ToList();
            }
        }

        public static Canal obtenerUno(int id)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                return context.Canal.FirstOrDefault(c => c.id == id && c.estado == 1);
            }
        }
        public static Canal validar(string nombre, string frecuencia)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                var canal = context.Canal.FirstOrDefault(c => c.nombre == nombre && c.frecuencia == frecuencia);
                if (canal == null)
                {
                    canal = new Canal
                    {
                        nombre = nombre,
                        frecuencia = frecuencia,
                        estado = 1
                    };
                    context.Canal.Add(canal);
                    context.SaveChanges();
                }
                return canal;
            }
        }
    }
}