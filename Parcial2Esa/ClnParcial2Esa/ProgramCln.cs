using CadParcial2Esa;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnParcial2Esa
{
    public class ProgramaCln
    {
        public static int insertar(Programa programa)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                context.Programa.Add(programa);
                context.SaveChanges();
                return programa.id;
            }
        }
        public static int Actualizar(Programa programa)
        {
            using (var context = new Parcial2EsaEntities1())
            {

                var existe = context.Programa.Find(programa.id);

                existe.idCanal = programa.idCanal;
                existe.titulo = programa.titulo;
                existe.descripcion = programa.descripcion;
                existe.duracion = programa.duracion;
                existe.productor = programa.productor;
                existe.fechaEstreno = programa.fechaEstreno;
                existe.Tipo = programa.Tipo;
                


                return context.SaveChanges();
            }
        }


        public static int Eliminar(int id)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                var existe = context.Programa.Find(id);
                existe.estado = -1;
                return context.SaveChanges();
            }
        }

        public static Programa obtenerUno(int id)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                return context.Programa.Find(id);
            }
        }

        public static List<Programa> listar()
        {
            using (var context = new Parcial2EsaEntities1())
            {
                return context.Programa.Where(x => x.estado == 1).ToList();
            }
        }


        public static List<paProgramaListar_Result> ListarPa(string parametro)
        {
            using (var context = new Parcial2EsaEntities1())
            {
                return context.paProgramaListar(parametro).ToList();
            }
        }
    }
}

