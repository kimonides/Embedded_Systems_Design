/*@ begin PerfTuning (
 def build {
  arg build_command = 'gcc -O0 -mcmodel=large';
 }
 def performance_counter {
  arg method = 'basic timer';
  arg repetitions = 10;
 }
 def performance_params {
  param UF[] = range(1,33);
 }

 def input_params {
  param N[] = [100000000];
 }

 def input_vars {
  decl static double y[N] = random;
  decl double a1 = random;
  decl double a2 = random;
  decl double a3 = random;
  decl static double x1[N] = random;
  decl static double x2[N] = random;
  decl static double x3[N] = random;
 }

 def search {
  arg algorithm = 'Exhaustive';
}
) @*/
/**-- (Generated by Orio) 
Best performance cost: 
  [0.430761, 0.431884, 0.426883, 0.423554, 0.43842, 0.420261, 0.422451, 0.435028, 0.423372, 0.416078] 
Tuned for specific problem sizes: 
  N = 100000000 
Best performance parameters: 
  UF = 7 
--**/


int i;

/*@ begin Loop ( 
    transform Unroll(ufactor=UF) 
    for (i=0; i<=N-1; i++)
      y[i] = y[i] + a1*x1[i] + a2*x2[i] + a3*x3[i];
) @*/
for (int loop_loop_36=0; loop_loop_36 < 1; loop_loop_36++)  {
    int i;
    for (i = 0; i <= N - 7; i = i + 7) {
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
      y[(i + 1)] = y[(i + 1)] + a1 * x1[(i + 1)] + a2 * x2[(i + 1)] + a3 * x3[(i + 1)];
      y[(i + 2)] = y[(i + 2)] + a1 * x1[(i + 2)] + a2 * x2[(i + 2)] + a3 * x3[(i + 2)];
      y[(i + 3)] = y[(i + 3)] + a1 * x1[(i + 3)] + a2 * x2[(i + 3)] + a3 * x3[(i + 3)];
      y[(i + 4)] = y[(i + 4)] + a1 * x1[(i + 4)] + a2 * x2[(i + 4)] + a3 * x3[(i + 4)];
      y[(i + 5)] = y[(i + 5)] + a1 * x1[(i + 5)] + a2 * x2[(i + 5)] + a3 * x3[(i + 5)];
      y[(i + 6)] = y[(i + 6)] + a1 * x1[(i + 6)] + a2 * x2[(i + 6)] + a3 * x3[(i + 6)];
    }
    for (i = N - ((N - (0)) % 7); i <= N - 1; i = i + 1) 
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
  }
/*@ end @*/

/*@ end @*/