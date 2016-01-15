public class Fechas {

	public static void main(String[] args) {
		int ano = 2015;
		int mes = 02;
		int dia = 15;

		int anoAct = 2016;
		int mesAct = 01;
		int diaAct = 14;

		int restAno = anoAct - ano;
		if(mesAct - mes == 0 && diaAct - dia < 0 || mesAct - mes < 0){
			restAno--;
		}

		System.out.println(restAno);

	}

}