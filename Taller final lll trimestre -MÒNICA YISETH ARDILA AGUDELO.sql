/*1. Seleccione los datos de todos los aprendices que tienen asesoría asignada*/
select * from aprendices 
inner join asesorias
on aprendiz = documento
where estado = "asignada" ;

/*2. Seleccione los datos de los aprendices y la fecha y hora de la asesoría de aquellos que tienen una asesoría asignada*/
select a.idasesoria, a.fecha,a.hora,
concat(ap.apellidos,' ',ap.nombres,' ',ap.documento,' ',ap.programa) as datosaprendiz, 
a.estado as estadoasesoria
from asesorias a inner join aprendices ap
on ap.documento=a.aprendiz
order by a.idasesoria;

/*3. Seleccione los datos de TODOSlos aprendices que tienen asesoría o que no tienen registro de asesorías.*/ 
SELECT * from aprendices ap left join asesorias a
on a.aprendiz=ap.documento;

SELECT * from asesorias a right join aprendices ap
on a.aprendiz=ap.documento;

/*4. Seleccione los aprendices que se divierten con videojuegos*/
select * from aprendices where jugadorvd='S';

/*5.  Seleccione los aprendices que NO juegan videojuegos o que no se sabe si lo hacen.*/
SELECT a.nombres, a.apellidos,a.documento, a.jugadorvd
FROM   aprendices a  WHERE jugadorvd='N' OR jugadorvd is null;

/*6 Seleccione los datos de TODAS las asesorías y relacione 
en la consulta el nombre del aprendiz que tiene asignada o 
anulada la asesoría y el nombre del asesor externo que 
brindará la asesoría. Tenga en cuenta que puede que no esté 
relacionado ni el aprendiz ni el asesor, pero se requieren 
los datos de TODAS las asesorías.*/

select a.*,s.nombres, concat(ap.nombres,' ', ap.apellidos) as aprendiz
from asesorias a left join asesores s on a.asesor=s.codigo 
left join aprendices ap on a.aprendiz=ap.documento
order by a.idasesoria;

/*7. Seleccione los datos de las asesorías y relacione en cada una de ellas el aprendiz que tiene 
relacionada la asesoría y el asesor externo que brindará la asesoría pero teniendo en 
cuenta que el aprendiz es jugador de videojuego o no se sabe si lo es. Debe existir siempre 
un aprendiz y un asesor relacionado.
*/
select a.idasesoria, a.fecha, a.hora, ap.nombres,
 ap.documento, a.asesor,se.nombres as nomasesor,
 a.estado, jugadorvd
from asesorias a inner join asesores se
on a.asesor = se.codigo inner join aprendices ap
on ap.documento=a.aprendiz where ap.jugadorvd = 'S' 
or ap.jugadorvd is null ;

/*8. Seleccione los datos delos asesores que tienen asesoría asignada, Debe mostrar los datos de las 
citas de asesoríasy el nombre delos asesores. Utilice Right Join.*/
SELECT a.idasesoria,a.fecha,a.hora,a.estado,
s.nombres as nomasesor
from asesorias a right join asesores s
on a.asesor=s.codigo
where a.estado='Asignada';

/*9. Seleccione  el  nombre  del  instructor  y  la  cantidad  de  veces  que  está  participando  en  las asesorías.*/
select i.nombre, count(se.idasesoria) as numeroAsesorias from
instructores i inner join asesorias se
on se.instructor = i.login
group by i.nombre
order by i.nombre;

/*10. En cuantas asesorías ha participado cada uno de los asesores externos?*/
select a.nombres, count(se.idasesoria) as numeroAsesorias 
from asesores a inner join asesorias se
on se.asesor = a.codigo
group by a.nombres
order by a.nombres;

/*11. Seleccione  la  fecha  y  hora  de  la  asesoría,  el  nombre  del  aprendiz
  y  su  documento  de identidad, el nombre del asesor externo, el nombre del instructor 
  que acompaña y el estado de la asesoría. La consulta debe mostrar siempre el nombre del
  asesor externo así no haya existido acompañamiento del instructor en ese momentoo no haya 
  existido presenciade aprendices*/
SELECT a.fecha, a.hora, ap.nombres AS aprendiz, ap.documento,
ase.nombres AS asesor, i.nombre AS instructor, a.estado
FROM asesorias a inner join asesores ase 
on a.asesor=ase.codigo
left join instructores i on a.instructor=i.login
left join aprendices  ap on ap.documento=a.aprendiz